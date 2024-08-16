-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.nu = true
vim.o.relativenumber = true
vim.o.mouse="a"
vim.o.smartindent = true
vim.o.cindent = true
vim.o.autoindent = true
-- vim.o.showcmd
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.wildmenu = true
vim.o.scrolloff=5
vim.o.syntax="ON"
vim.o.background="dark"
vim.o.conceallevel=3
vim.o.list = true
-- vim.o.termguicolors to enable highlight groups
vim.o.termguicolors = true

vim.o.ruler = true
vim.o.cursorline = true
-- vim.o.cursorcolumn
vim.o.hlsearch = true
vim.o.tabstop=4
vim.o.shiftwidth=4
vim.o.expandtab = true
vim.o.encoding="utf-8"
vim.o.modifiable = true
vim.o.fileencoding="utf-8"
vim.o.fileformat="unix"
vim.o.autoread = true
vim.o.backup = false
vim.o.updatetime = 500

if (1 == vim.fn.has("win32")) then
    vim.g.python_host_prog  = 'D:\\Program Files\\Python38\\python.exe'
    vim.g.python3_host_prog = 'D:\\Program Files\\Python38\\python.exe'
elseif (1 == vim.fn.has("mac")) then
    vim.g.python_host_prog  = '/usr/bin/python'
    vim.g.python3_host_prog = '/usr/bin/python3'
    vim.o.guifont="FiraMono Nerd Font Mono:h13"
end
-- script demo
--
-- vim.g.briq_tmp='/lib'
--
-- if '/lib' == g:briq_tmp
--     echo "lksdjlksdjfklj"
--     let mm = 'cd ' . g:briq_tmp
--     echo mm
--     exec('cd ' . g:briq_tmp)
-- endif

-- vim.g.vimcfg_prefix=$HOME . '/.vim'
-- vim.g.mhodddd = g:vimcfg_prefix . "/vimcfg/init/init_init.vim"
-- echo g:mhodddd
-- execute 'source ' . g:mhodddd
--

-- function! g:Source_vims(vims)
--     for i in a:vims
--         echo i
--     endfor
-- endfunction
--
-- let mab=['a', 'b', 'c']
--
-- call g:Source_vims(mab)
--

-- if 1 == &nu && 1 == &rnu
--     echo "---------------------->>>>"
-- endif
--
-- function! g:Nu_toggle()
--     if 1 == &nu && 1 == &rnu
--         echo "---------------------->>>>"
--         vim.o.nonu
--         vim.o.nornu
--     else
--         echo "----------------------<<<<"
--         vim.o.nu
--         vim.o.rnu
--     endif
-- endfunction
