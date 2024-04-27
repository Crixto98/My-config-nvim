----------------------------------
------------ Lazy API-------------
----------------------------------
----------------------------------


local lazypath = vim.fn.stdpath('data') .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazypath, lazyrepo})
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup("plugins")
