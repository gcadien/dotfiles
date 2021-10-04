local M = {}

M.note_link = function()
  local r = require('telescope.builtin').find_files()
  print("R: "..r)
end

M.note_dir = "/home/geoff/NOTES"

vim.cmd('command! -nargs=? NoteNew :execute ":e" note_dir . "/<args>.md"')
vim.cmd('command! NoteEdit :Telescope find_files cwd=' .. M.note_dir)
vim.cmd('command! NoteQuick :e ' .. M.note_dir .. '/unfiled.md')
vim.cmd('command! NoteSearch :Telescope live_grep cwd=' .. M.note_dir)

return M

