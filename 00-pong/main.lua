--[[
  -- PROJECT 0: PONG --
  By Giantpizzahead
]]

-- Require libraries
push = require 'push'
Class = require 'class'

-- Require classes
require 'Paddle'
require 'Ball'

-- Constants
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

--[[
  Called by LOVE2D when the program starts.
]]
function love.load()
  math.randomseed(os.time())
  love.graphics.setDefaultFilter('nearest', 'nearest')

  love.window.setTitle('Pong')
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  smallFont = love.graphics.newFont('font.ttf', 8)

  scoreFont = love.graphics.newFont('font.ttf', 32)

  player1 = Paddle(10, 30, 5, 20)
  player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)
  
  ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

  gameState = 'start'
end

--[[
  Called by LOVE2D every frame.
  dt is the time in seconds since the last frame.
]]
function love.update(dt)
  if love.keyboard.isDown('w') == love.keyboard.isDown('s') then
    player1.dy = 0
  elseif love.keyboard.isDown('w') then
    player1.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('s') then
    player1.dy = PADDLE_SPEED
  end
  
  if love.keyboard.isDown('up') == love.keyboard.isDown('down') then
    player2.dy = 0
  elseif love.keyboard.isDown('up') then
    player2.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('down') then
    player2.dy = PADDLE_SPEED
  end

  if gameState == 'play' then
    ball:update(dt)
  end

  player1:update(dt)
  player2:update(dt)
end

--[[
  Called by LOVE2D when a key is pressed.
  key contains a string with the key name.
]]
function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'enter' or key == 'return' then
    if gameState == 'start' then
      gameState = 'play'
    else
      gameState = 'start'
      ball:reset()
    end
  end
end

--[[
  Called by LOVE2D every frame, after love.update().
]]
function love.draw()
  push:apply('start')

  love.graphics.clear(40/255, 45/255, 52/255, 255/255)

  love.graphics.setFont(smallFont)
  if gameState == 'start' then
    love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
  else
    love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
  end
  
  player1:render()
  player2:render()
  ball:render()

  displayFPS()

  push:apply('end')
end

--[[
  Displays the current FPS.
]]
function displayFPS()
  love.graphics.setFont(smallFont)
  love.graphics.setColor(0, 255/255, 0, 255/255)
  love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end