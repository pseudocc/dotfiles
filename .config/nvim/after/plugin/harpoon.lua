local harpoon = require 'harpoon'
harpoon.setup {}

local function map(mode, l, r, desc)
  local opts = {
    silent = true,
    remap = false,
    desc = desc and 'harpoon: ' .. desc,
  }
  vim.keymap.set(mode, l, r, opts)
end

local function list(fname, ...)
  local args = {...}
  return function ()
    local l = harpoon:list()
    return l[fname](l, unpack(args))
  end
end

map('n', '<leader>ma', list('append'), 'Add file')
map('n', '<leader>mr', list('remove'), 'Remove file')

map('n', '<leader>(', list('prev'))
map('n', '<leader>)', list('next'))

for i = 1, 9 do
  map('n', '<leader>' .. tostring(i), list('select', i))
end

-- basic telescope configuration
local function harpoon_telescope()
  local conf = require "telescope.config".values
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"

  local files = harpoon:list()
  local file_paths = {}
  for _, item in ipairs(files.items) do
    table.insert(file_paths, item.value)
  end

  pickers.new({}, {
    prompt_title = "Harpoon",
    finder = finders.new_table { results = file_paths },
    previewer = conf.file_previewer {},
    sorter = conf.generic_sorter {},
  }):find()
end

map('n', '<leader>~', harpoon_telescope, 'Telescope')
