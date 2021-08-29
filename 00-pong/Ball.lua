--[[
  -- BALL CLASS --
  Represents a ball in the game of Pong.
]]

Ball = Class{}

--[[
  Initializes the ball, with a random initial velocity.
]]
function Ball:init(x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height

  self.dy = math.random(2) == 1 and -100 or 100
  self.dx = math.random(-50, 50)
end

--[[
  Resets the ball to the middle of the screen, with a random initial velocity.
]]
function Ball:reset()
  self.x = VIRTUAL_WIDTH / 2 - self.width / 2
  self.y = VIRTUAL_HEIGHT / 2 - self.height / 2
  self.dx = math.random(2) == 1 and 100 or -100
  self.dy = math.random(-50, 50)
end

function Ball:collides(paddle)
  if self.x <= paddle.x + paddle.width and
    self.x + self.width >= paddle.x and
    self.y <= paddle.y + paddle.height and
    self.y + self.height >= paddle.y then
    return true
  else
    return false
  end
end

--[[
  Updates the ball's position.
]]
function Ball:update(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
end

--[[
  Renders the ball.
]]
function Ball:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end