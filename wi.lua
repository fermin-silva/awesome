-----------------------
-- AwesomeWM widgets --
--    version 3.5    --
-----------------------

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
local naughty = require("naughty")

graphwidth  = 120
graphheight = 20
pctwidth    = 40
netwidth    = 50
mpdwidth    = 365

-- {{{ Spacers
space = wibox.widget.textbox()
space:set_text(" ")

comma = wibox.widget.textbox()
comma:set_markup(",")

pipe = wibox.widget.textbox()
pipe:set_markup("|")

tab = wibox.widget.textbox()
tab:set_text("         ")

volspace = wibox.widget.textbox()
volspace:set_text(" ")
-- }}}

-- {{{ Processor
-- Cache
vicious.cache(vicious.widgets.cpu)
vicious.cache(vicious.widgets.cpuinf)

-- Core 0 freq
cpufreq = wibox.widget.textbox()
vicious.register(cpufreq, vicious.widgets.cpuinf,
  function(widget, args)
    return string.format("cpu%1.1fGHz", args["{cpu0 ghz}"])
  end, 3000)

-- Core 0 graph
cpugraph0 = awful.widget.graph()
cpugraph0:set_width(graphwidth):set_height(graphheight)
cpugraph0:set_border_color(nil)
cpugraph0:set_border_color(beautiful.bg_widget)
cpugraph0:set_background_color(beautiful.bg_widget)
cpugraph0:set_color({
  type = "linear",
  from = { 0, graphheight },
  to = { 0, 0 },
  stops = {
    { 0, beautiful.fg_widget },
    { 0.25, beautiful.fg_center_widget },
    { 1, beautiful.fg_end_widget } } })
vicious.register(cpugraph0, vicious.widgets.cpu, "$2")

-- Core 0 %
cpupct0 = wibox.widget.textbox()
cpupct0.fit =
  function(box, w, h)
    local w, h = wibox.widget.textbox.fit(box, w, h)
    return math.max(pctwidth, w), h
  end
vicious.register(cpupct0, vicious.widgets.cpu, "$2%", 2)

-- Core 1 graph
cpugraph1 = awful.widget.graph()
cpugraph1:set_width(graphwidth):set_height(graphheight)
cpugraph1:set_border_color(nil)
cpugraph1:set_border_color(beautiful.bg_widget)
cpugraph1:set_background_color(beautiful.bg_widget)
cpugraph1:set_color({
  type = "linear",
  from = { 0, graphheight },
  to = { 0, 0 },
  stops = {
    { 0, beautiful.fg_widget },
    { 0.25, beautiful.fg_center_widget },
    { 1, beautiful.fg_end_widget }
  }})
vicious.register(cpugraph1, vicious.widgets.cpu, "$3")

-- Core 1 %
cpupct1 = wibox.widget.textbox()
cpupct1.fit =
  function(box, w, h)
    local w, h = wibox.widget.textbox.fit(box, w, h)
    return math.max(pctwidth, w), h
  end
vicious.register(cpupct1, vicious.widgets.cpu, "$3%", 2)

-- Core 2 graph
cpugraph2 = awful.widget.graph()
cpugraph2:set_width(graphwidth):set_height(graphheight)
cpugraph2:set_border_color(nil)
cpugraph2:set_border_color(beautiful.bg_widget)
cpugraph2:set_background_color(beautiful.bg_widget)
cpugraph2:set_color({
  type = "linear",
  from = { 0, graphheight },
  to = { 0, 0 },
  stops = {
    { 0, beautiful.fg_widget },
    { 0.25, beautiful.fg_center_widget },
    { 1, beautiful.fg_end_widget } } })
vicious.register(cpugraph2, vicious.widgets.cpu, "$4")

-- Core 2 %
cpupct2 = wibox.widget.textbox()
cpupct2.fit =
  function(box, w, h)
    local w, h = wibox.widget.textbox.fit(box, w, h)
    return math.max(pctwidth, w), h
  end
vicious.register(cpupct2, vicious.widgets.cpu, "$4%", 2)
-- }}}

-- Initialize widget
cpuwidget = wibox.widget.textbox()
-- Register widget
vicious.register(cpuwidget, vicious.widgets.cpu, "$1%")
cpuicon = wibox.widget.imagebox()
cpuicon:set_image("/home/guerre/.config/awesome/icons/cpu.png")



-- {{{ Memory
-- Cache
vicious.cache(vicious.widgets.mem)

-- RAM used
memused = wibox.widget.textbox()
vicious.register(memused, vicious.widgets.mem,"$2MB", 5)
memicon = wibox.widget.imagebox()
memicon:set_image("/home/guerre/.config/awesome/icons/mem.png")

-- }}}

-- {{{ Network
-- Cache
vicious.cache(vicious.widgets.net)

-- TX graph
-- txgraph = awful.widget.graph()
-- txgraph:set_width(graphwidth):set_height(graphheight)
-- txgraph:set_border_color(nil)
-- txgraph:set_background_color(beautiful.bg_widget)
-- txgraph:set_color({
--   type = "linear",
--   from = { 0, graphheight },
--   to = { 0, 0 },
--   stops = {
--     { 0, beautiful.fg_widget },
--     { 0.25, beautiful.fg_center_widget },
--     { 1, beautiful.fg_end_widget } } })
-- vicious.register(txgraph, vicious.widgets.net, "${eth0 up_kb}")

-- -- TX total
-- txwidget = wibox.widget.textbox()
-- vicious.register(txwidget, vicious.widgets.net,
--   "<span color='" .. beautiful.fg_em .. "'>tx</span>${eth0 tx_mb}MB", 19)

-- -- TX speed
-- txwidget = wibox.widget.textbox()
-- txwidget.fit =
--   function(box, w, h)
--     local w, h = wibox.widget.textbox.fit(box, w, h)
--     return math.max(netwidth, w), h
--   end
-- vicious.register(txwidget, vicious.widgets.net, "${eth0 up_kb}", 2)

-- -- RX graph
-- rxgraph = awful.widget.graph()
-- rxgraph:set_width(graphwidth):set_height(graphheight)
-- rxgraph:set_border_color(nil)
-- rxgraph:set_background_color(beautiful.bg_widget)
-- rxgraph:set_color({
--   type = "linear",
--   from = { 0, graphheight },
--   to = { 0, 0 },
--   stops = {
--     { 0, beautiful.fg_widget },
--     { 0.25, beautiful.fg_center_widget },
--     { 1, beautiful.fg_end_widget } } })
-- vicious.register(rxgraph, vicious.widgets.net, "${eth0 down_kb}")

-- -- RX total
-- rxwidget = wibox.widget.textbox()
-- -- vicious.register(rxwidget, vicious.widgets.net,
--   "<span color='" .. beautiful.fg_em .. "'>rx</span>${eth0 rx_mb}MB", 17)

-- -- RX speed
-- rxwidget = wibox.widget.textbox()
-- rxwidget.fit =
--   function(box, w, h)
--     local w, h = wibox.widget.textbox.fit(box, w, h)
--     return math.max(netwidth, w), h
--   end
-- vicious.register(rxwidget, vicious.widgets.net, "${eth0 down_kb}", 2)
-- -- }}}

-- {{{ Weather
weather = wibox.widget.textbox()
vicious.register(weather, vicious.widgets.weather,
  "${sky} @ ${tempf}°F on",
  1501, "XXXX")
weather:buttons(awful.util.table.join(awful.button({ }, 1,
  function() vicious.force({ weather }) end)))
-- }}}


-- -- {{{ Pianobar
-- -- Icon
-- mpdicon = wibox.widget.imagebox()
-- mpdicon:set_image(beautiful.widget_mpd)

-- -- Song info
-- mpdwidget = wibox.widget.textbox()
-- vicious.register(mpdwidget, vicious.widgets.mpd,
--   function(widget, args)
--     mpdicon:set_image(beautiful.widget_play)
--     local bg = beautiful.bg_focus

--     local italic = ""
--     local like = ""
--     local color = beautiful.fg_focus
--     local f = io.popen("pgrep pianobar")

--     if f:read("*line") then
--       f = io.open(os.getenv("HOME") .. "/.config/pianobar/isplaying")
--       play_or_pause = f:read("*line")
--       f:close()

      -- -- Current song
      -- f = io.open(os.getenv("HOME") .. "/.config/pianobar/nowplaying")
      -- text = f:read("*line"):match("(.*)")
      -- f:close()

      -- -- Awaiting song
      -- if text:match(" -  $") then text = "..." end

      -- -- Loved song
      -- if text:find("%(like%)") then like = "&#x1f495;" end

      -- -- Ampersands
      -- if text:find("&") then text = text:gsub("&","and") end

      -- -- Paused
      -- if play_or_pause == "0" then
      --   if text:len() > 35 then mpdwidget.width = mpdwidth end
      --   italic = "font_style='italic'"
      --   mpdicon:set_image(beautiful.widget_pause)
      --   info = like .. awful.util.escape(text:gsub("%(like%)",""))
      -- else
      --   mpdwidget.width = 0
      --   local helpers = require("vicious.helpers")
      --   info = like ..
      --     awful.util.escape(helpers.scroll(text:gsub("%(like%)",""), 30, mpdwidget))
      -- end
    -- else
      -- -- Stopped
      -- mpdwidget.width = 0
      -- mpdicon:set_image(beautiful.widget_mpd)
      -- bg = beautiful.bg_normal
      -- color = beautiful.fg_normal
      -- info = "..."
    -- end

    -- return "<span color='" .. color .. "' background='" .. bg ..
      -- "' " .. italic  .. ">" .. info .. "</span>"
  -- end, 3)

-- -- Buttons
-- mpdwidget:buttons(awful.util.table.join(
  -- awful.button({ }, 1,
    -- function()
      -- local f = io.popen("pgrep pianobar")
      -- p = f:read("*a"):match("([0-9]*)")
      -- if p == "" then
      --   awful.util.spawn(pianobar_screen, false)
      -- else
      --   awful.util.spawn(pianobar_toggle, false)
      -- end
    -- end),
  -- awful.button({ modkey }, 1, function() awful.util.spawn(pianobar_upcoming, false) end),
  -- awful.button({ }, 2, function() awful.util.spawn(pianobar_quit, false) end),
  -- awful.button({ }, 3, function() awful.util.spawn(pianobar_station, false) end),
  -- awful.button({ }, 4, function() awful.util.spawn(pianobar_next, false) end),
  -- awful.button({ }, 5, function() awful.util.spawn(pianobar_history, false) end)))
-- mpdicon:buttons(mpdwidget:buttons())
-- -- }}}

-- {{{ Volume
-- Cache
vicious.cache(vicious.widgets.volume)

-- Icon
volicon = wibox.widget.imagebox()
volicon:set_image("/home/guerre/.config/awesome/icons/vol.png")

-- Volume %
volpct = wibox.widget.textbox()
vicious.register(volpct, vicious.widgets.volume, "$1%", nil, "Master")

-- Buttons
volicon:buttons(awful.util.table.join(
  awful.button({ }, 1,
    function() awful.util.spawn("amixer -q set Master toggle", false) end),
  awful.button({ }, 4,
    function() awful.util.spawn("amixer -q set Master 2+% unmute", false) end),
  awful.button({ }, 5,
    function() awful.util.spawn("amixer -q set Master 2-% unmute", false) end)))
volpct:buttons(volicon:buttons())
volspace:buttons(volicon:buttons())
-- }}}

-- {{{ Battery
-- Battery attributes
local bat_state  = ""
local bat_charge = 0
local bat_time   = 0
local blink      = true

-- Icon
baticon = wibox.widget.imagebox()
baticon:set_image("/home/guerre/.config/awesome/icons/bat.png")

-- Charge %
batpct = wibox.widget.textbox()
vicious.register(batpct, vicious.widgets.bat,
  function(widget, args)
    bat_state  = args[1]
    bat_charge = args[2]
    bat_time   = args[3]

    if args[1] == "-" then
      if bat_charge > 70 then
        baticon:set_image("/home/guerre/.config/awesome/icons/bat.png")
      elseif bat_charge > 30 then
        baticon:set_image("/home/guerre/.config/awesome/icons/bat-low.png")
      elseif bat_charge > 10 then
        baticon:set_image("/home/guerre/.config/awesome/icons/bat-empty.png")
      else
        baticon:set_image("/home/guerre/.config/awesome/icons/bat-empty.png")
      end
    else
      baticon:set_image("/home/guerre/.config/awesome/icons/ac.png")
      if args[1] == "+" then
        blink = not blink
        if blink then
          baticon:set_image("/home/guerre/.config/awesome/icons/ac.png")
        end
      end
    end

    return args[2] .. "%" .. " " .. bat_time
  end, nil, "BAT0")

-- Buttons
function popup_bat()
  local state = ""
  if bat_state == "↯" then
    state = "Full"
  elseif bat_state == "↯" then
    state = "Charged"
  elseif bat_state == "+" then
    state = "Charging"
  elseif bat_state == "-" then
    state = "Discharging"
  elseif bat_state == "⌁" then
    state = "Not charging"
  else
    state = "Unknown"
  end

  naughty.notify { text = "Charge : " .. bat_charge .. "%\nState  : " .. state ..
    " (" .. bat_time .. ")", timeout = 5, hover_timeout = 0.5 }
end
batpct:buttons(awful.util.table.join(awful.button({ }, 1, popup_bat)))
baticon:buttons(batpct:buttons())
-- }}}
