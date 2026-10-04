-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.enable_tab_bar = true
config.window_decorations = 'NONE'

config.color_scheme = 'AdventureTime'

config.font = wezterm.font('JetBrains Mono', { weight = 'Bold', italic = true })

config.background = {
    {
        source = {
            File = wezterm.config_dir .. '/space.jpg'
        },
        hsb = { brightness = 0.2 }
    }
}

return config;
