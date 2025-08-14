print 'github-opener module loaded'
local M = {}

local function get_command_output(cmd)
  local handle = io.popen(cmd .. ' 2>/dev/null')
  if handle then
    local result = handle:read('*a'):gsub('%s+', '')
    handle:close()
    return result
  end
end

local function get_remote_url()
  return get_command_output 'git remote get-url origin'
end

local function get_current_branch()
  return get_command_output 'git branch --show-current'
end

local function get_relative_path()
  local git_root = get_command_output 'git rev-parse --show-toplevel'
  if git_root then
    local current_file = vim.fn.expand '%:p'
    return current_file:sub(#git_root + 2)
  end
end

local function ssh_to_https(url)
  return url:gsub('git@github.com:', 'https://github.com/'):gsub('%.git$', '')
end

local function open_url(url)
  local cmd = vim.fn.has 'mac' == 1 and 'open' or vim.fn.has 'unix' == 1 and 'xdg-open' or vim.fn.has 'win32' == 1 and 'start'
  if cmd then
    os.execute(cmd .. ' "' .. url .. '"')
  end
end

local function is_git_repo()
  return vim.fn.system 'git rev-parse --is-inside-work-tree 2>/dev/null' ~= ''
end

local function get_github_url(remote_url)
  if remote_url:match '^git@' then
    return ssh_to_https(remote_url)
  elseif remote_url:match '^https://' then
    return remote_url:gsub('%.git$', '')
  end
end

function M.open_github()
  if not is_git_repo() then
    print 'Not a git repository'
    return
  end

  local remote_url = get_remote_url()
  if not remote_url then
    print 'Could not get remote URL'
    return
  end

  local github_url = get_github_url(remote_url)
  if not github_url then
    print 'Unsupported remote URL format'
    return
  end

  open_url(github_url)
end

function M.open_github_file()
  if not is_git_repo() then
    print 'Not a git repository'
    return
  end

  local remote_url = get_remote_url()
  if not remote_url then
    print 'Could not get remote URL'
    return
  end

  local branch = get_current_branch()
  if not branch then
    print 'Could not get current branch'
    return
  end

  local relative_path = get_relative_path()
  if not relative_path then
    print 'Could not get relative file path'
    return
  end

  local github_url = get_github_url(remote_url)
  if not github_url then
    print 'Unsupported remote URL format'
    return
  end

  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local file_url = string.format('%s/blob/%s/%s#L%d', github_url, branch, relative_path, line_num)

  open_url(file_url)
end

vim.api.nvim_create_user_command('OpenGitHub', M.open_github, {})
vim.api.nvim_create_user_command('OpenGitHubFile', M.open_github_file, {})

vim.api.nvim_create_user_command('GitHubOpen', M.open_github, {})
vim.api.nvim_create_user_command('GitHubOpenFile', M.open_github_file, {})

return M
