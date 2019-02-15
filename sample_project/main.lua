display.setDefault('background', .9, .9, .9)
local magnifier = require('magnifier')

local img = display.newImage('img.jpg')
img.x, img.y = display.contentCenterX, display.contentCenterY

local the_lens = magnifier.new({
  diameter = 300,
  zoom = 1.2,
  bulge = 1
})
the_lens.x, the_lens.y = display.contentCenterX, display.contentCenterY

local function drag(event)
  local target = event.target
  local phase = event.phase
  local x, y = event.x, event.y
  local dx = event.x - event.xStart
  local dy = event.y - event.yStart

  if phase == 'began' then
    display.currentStage:setFocus(target, event.id)
    target.xStart = target.x
    target.yStart = target.y
    target.has_focus = true
  elseif target.has_focus then
    if phase == 'moved' then
      target.x, target.y = target.xStart + dx, target.yStart + dy
    else
      display.currentStage:setFocus(nil, event.id)
      target.has_focus = false
    end
  end
end

the_lens:addEventListener('touch', drag)
