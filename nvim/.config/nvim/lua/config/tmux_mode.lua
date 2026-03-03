if not vim.env.TMUX then
  return
end

local mode_map = {
  n = { label = "NORMAL",   color = "#89b4fa" }, -- blue
  i = { label = "INSERT",   color = "#a6e3a1" }, -- green
  v = { label = "VISUAL",   color = "#cba6f7" }, -- mauve
  V = { label = "V-LINE",   color = "#cba6f7" },
  ["\22"] = { label = "V-BLOCK", color = "#cba6f7" },
  c = { label = "COMMAND",  color = "#f9e2af" }, -- yellow
  R = { label = "REPLACE",  color = "#f38ba8" }, -- red
  s = { label = "SELECT",   color = "#f5c2e7" }, -- pink
  S = { label = "S-LINE",   color = "#f5c2e7" },
  t = { label = "TERMINAL", color = "#94e2d5" }, -- teal
}

local default = { label = "NORMAL", color = "#89b4fa" }

local function set_tmux_mode()
  local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
  local m = mode_map[mode] or default
  local styled = "#[bg=" .. m.color .. ",fg=#1e2030,bold] " .. m.label .. " #[default]#[fg=" .. m.color .. "]#[default]"
  vim.fn.system('tmux set -g @vim_mode "' .. styled .. '"')
end

local group = vim.api.nvim_create_augroup("TmuxVimMode", { clear = true })

vim.api.nvim_create_autocmd("ModeChanged", {
  group = group,
  pattern = "*",
  callback = set_tmux_mode,
})

vim.api.nvim_create_autocmd("FocusGained", {
  group = group,
  callback = set_tmux_mode,
})

vim.api.nvim_create_autocmd("VimLeave", {
  group = group,
  callback = function()
    vim.fn.system('tmux set -g @vim_mode ""')
  end,
})

-- Set immediately on load
set_tmux_mode()
