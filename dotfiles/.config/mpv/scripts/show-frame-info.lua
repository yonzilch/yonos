local mp = require("mp")

local function format_time_ms(sec)
    if not sec or sec < 0 then return "00:00:00.000" end
    local h = math.floor(sec / 3600)
    local m = math.floor((sec % 3600) / 60)
    local s = math.floor(sec % 60)
    local ms = math.floor((sec % 1) * 1000)
    return string.format("%02d:%02d:%02d.%03d", h, m, s, ms)
end

local function get_frame_ms()
    local fps = mp.get_property_number("container-fps")
            or mp.get_property_number("estimated-fps")
            or mp.get_property_number("fps")

    if not fps or fps <= 0 then
        local duration = mp.get_property_number("duration", 0)
        local total_frames = mp.get_property_number("estimated-frame-count", 0)
        if duration > 0 and total_frames > 0 then
            fps = total_frames / duration
        end
    end

    if not fps or fps <= 0 then return nil end
    return 1000 / fps
end

local function calc_frame_num(time_sec, frame_ms)
    if not frame_ms or frame_ms <= 0 then return 0 end
    return math.floor(time_sec / (frame_ms / 1000) + 0.5)
end

mp.register_script_message("show-frame-info", function(direction)
    mp.add_timeout(0.1, function()
        local time_sec = mp.get_property_number("time-pos", 0)
        local frame_ms = get_frame_ms()
        local frame_num = calc_frame_num(time_sec, frame_ms)
        local time_str = format_time_ms(time_sec)
        local frame_ms_str = frame_ms and string.format("%.3f", frame_ms) or "N/A"

        local text = string.format("%s frame → %d @ %s (frame %s ms)",
                                   direction, frame_num, time_str, frame_ms_str)
        mp.osd_message(text, 1000)
    end)
end)
mp.register_event("file-loaded", function()
end)
