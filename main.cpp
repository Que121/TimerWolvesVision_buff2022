#include "main.hpp"

int main() {
  cv::Mat src_img_, roi_img_;
  fps::FPS global_fps_;
  cv::VideoWriter vw_src;

  //======== 迈德威视相机初始化 =======//
  mindvision::VideoCapture* mv_capture_ =
      new mindvision::VideoCapture(mindvision::CameraParam(
          0, mindvision::RESOLUTION_1280_X_1024, mindvision::EXPOSURE_15000));
  cv::VideoCapture cap_ = cv::VideoCapture(0);

  //======== 相机录像初始化 =======//
  RecordMode::Record record_ = RecordMode::Record(
      fmt::format("{}{}", CONFIG_FILE_PATH, "/record/recordpath_save.yaml"),
      fmt::format("{}{}", CONFIG_FILE_PATH, "/record/record_packeg/record.avi"),
      cv::Size(1280, 1024));
  cv::FileStorage re_config_get(record_.video_save_path_,
                                cv::FileStorage::READ);
  re_config_get["_PATH"] >> record_.path_;
  std::string save_path_ = "/record/";
  vw_src.open(
      CONFIG_FILE_PATH + save_path_ + std::to_string(record_.path_) + ".avi",
      cv::VideoWriter::fourcc('M', 'J', 'P', 'G'), 120, cv::Size(1280, 1024),
      true);

  //======== 串口初始化 ========//
  uart::SerialPort serial_ = uart::SerialPort(
      fmt::format("{}{}", CONFIG_FILE_PATH, "/serial/uart_serial_config.xml"));

  //======== 能量机关类初始化 ========//
  basic_buff::Detector basic_buff_ = basic_buff::Detector(
      fmt::format("{}{}", CONFIG_FILE_PATH, "/buff/basic_buff_config.xml"));

  //======== PnP解算初始化 ========//
  basic_pnp::PnP pnp_ = basic_pnp::PnP(
      fmt::format("{}{}", CONFIG_FILE_PATH, "/camera/mv_camera_config_407.xml"),
      fmt::format("{}{}", CONFIG_FILE_PATH,
                  "/angle_solve/basic_pnp_config.xml"));

  while (true) {
    global_fps_.getTick();
    if (mv_capture_->isindustryimgInput()) {
      src_img_ = mv_capture_->image();
    } else {
      cap_.read(src_img_);
    }

    if (!src_img_.empty()) {
      serial_.updateReceiveInformation();
      serial_.printReceiveInformation();
      serial_.writeData(basic_buff_.runTask(src_img_, serial_.returnReceive()));

      mv_capture_->cameraReleasebuff();
      cv::imshow("dafule", src_img_);
      cv::waitKey(100);
      // w_src << src_img_; // 录制视频
    }
  }
  return 0;
}