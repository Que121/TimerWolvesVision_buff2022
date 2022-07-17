#pragma once

#include <fmt/color.h>
#include <fmt/core.h>

#include <opencv2/core.hpp>
#include <string>

#include "devices/camera/mv_video_capture.hpp"
#include "devices/serial/uart_serial.hpp"
#include "record/record.hpp"
#include "utils/fps.hpp"
#include "utils/reset_mv_camera.hpp"
#include "buff/basic_buff.hpp"
#include "angle_solve/basic_pnp.hpp"
#include "armor/basic_armor.hpp"

auto idntifier = fmt::format(fg(fmt::color::green) | fmt::emphasis::bold,
                             "TimerWolves_buff");