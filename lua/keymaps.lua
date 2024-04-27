local keymap = vim.keymap
local opts = { noremap = true, silent = true}


-- Neotree
keymap.set("n", "<C-n>", ":Neotree float toggle<Return>", opts)


--- New tab
keymap.set("n", "<tab>", ":tabnext<Return>", opts)


-- Config basic
keymap.set("n", "<A-q>", ":q<Return>", opts)



-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- LAZY Download
keymap.set("n", "<C-i>", ":Lazy<Return>", opts)


---- TELESCOPE/Trouble
keymap.set('n', '<C-e>', ':TroubleToggle<Return>', opts)
keymap.set("n", "<C-t>", ":Telescope<Return>", opts)
