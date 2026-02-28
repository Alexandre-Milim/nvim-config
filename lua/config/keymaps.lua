vim.cmd([[map <C-a> ggVG]])

-- buffers
vim.keymap.set("n", "<S-Left>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-Right>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- run c, python c++, js
vim.keymap.set("n", "<leader>r", function()
  vim.cmd("write")

  local ft = vim.bo.filetype
  local file = vim.fn.shellescape(vim.fn.expand("%:p"))
  local filename = vim.fn.expand("%:t:r")
  local cmd = nil

  if ft == "c" then
  local output = vim.fn.shellescape("/tmp/" .. filename)
  cmd = string.format(
    "gcc -Wall -Wextra -std=gnu11 %s -o %s && %s",
    file, output, output
  )
elseif ft == "cpp" then
  local output = vim.fn.shellescape("/tmp/" .. filename)
  cmd = string.format(
    "g++ -Wall -Wextra -std=gnu++17 %s -o %s && %s",
    file, output, output
  )

  elseif ft == "cpp" then
    local output = vim.fn.shellescape("/tmp/" .. filename)
    cmd = string.format(
      "g++ -Wall -Wextra -std=c++17 %s -o %s && %s",
      file, output, output
    )

  elseif ft == "python" then
    cmd = string.format("python3 %s", file)

  elseif ft == "javascript" then
    cmd = string.format("node %s", file)

  else
    print("Filetype não suportado: " .. ft)
    return
  end

  Snacks.terminal({ "bash", "-c", cmd .. "; echo; read -p 'Press Enter...'" }, {
  win = { style = "float" },
  close_on_exit = false,
})
end, { desc = "Run file (safe universal)" })
