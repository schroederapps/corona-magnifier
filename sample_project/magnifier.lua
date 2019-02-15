local _M = {}

-- specify path to mask file & image dimensions
local mask_file_path = 'mask.png'
local mask_w, mask_h = 2048, 2048

function _M.new(params)
  -- set default params
  local params = params or {}
  local diameter = params.diameter or display.contentWidth * .3
  local radius = diameter * .5
  local zoom = params.zoom or 1.2
  local bulge = params.bulge or 1

  -- create magnifier display group
  local g = display.newGroup()

  local bg = display.newRect(g, 0, 0, diameter * 2, diameter * 2)
  bg.isVisible = false
  bg.isHitTestable = true

  local border = display.newCircle(g, 0, 0, radius)
  border:setFillColor(1, 1, 1, 0)
  border:setStrokeColor(0)
  border.strokeWidth = 10

  local mask = graphics.newMask(mask_file_path)
  g:setMask(mask)
  g.maskScaleX = diameter * 2 / mask_w
  g.maskScaleY = diameter * 2 / mask_h

  -- update magnification on enterFrame
  function g.enterFrame(event)
    g.isVisible = false
    display.remove(g.zoom_image)
    g.zoom_image = nil
    local x, y = g:localToContent(0, 0)
    local bounds = {
      xMin = x - radius,
      xMax = x + radius,
      yMin = y - radius,
      yMax = y + radius
    }
    g.zoom_image = display.captureBounds(bounds)
    if not g.zoom_image then return true end
    local dx = (diameter - g.zoom_image.width) *.5
    local dy = (diameter - g.zoom_image.height) *.5
    g:insert(1, g.zoom_image)
    g.zoom_image:scale(zoom, zoom)
    if bulge > 1 then
      g.zoom_image.fill.effect = 'filter.bulge'
      g.zoom_image.fill.effect.intensity = bulge
    end
    if dx > 0 then
      if g.x > display.contentCenterX then
        g.zoom_image.x = -dx
      else
        g.zoom_image.x = dx
      end
    end
    if dy > 0 then
      if g.y > display.contentCenterY then
        g.zoom_image.y = -dy
      else
        g.zoom_image.y = dy
      end
    end
    g.isVisible = true
  end
  Runtime:addEventListener('enterFrame', g)

  -- remove enterFrame listener when destroyed
  function g.finalize()
    Runtime:removeEventListener('enterFrame', g)
  end
  g:addEventListener('finalize')

  return g
end


return _M
