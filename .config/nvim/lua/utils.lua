local M = {}

M.wrap = function (func, ...)
  local args = {...}
  return function ()
    func(unpack(args))
  end
end

return M
