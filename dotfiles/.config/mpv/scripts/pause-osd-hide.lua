local timer = nil

mp.observe_property("pause", "bool", function(_, paused)
    if paused then
        mp.commandv("script-message-to", "uosc", "flash-timeline")
        if timer then timer:kill() end
        timer = mp.add_timeout(3, function()
        end)
    else
        if timer then
            timer:kill()
            timer = nil
        end
    end
end)
