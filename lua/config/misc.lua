M = {}

M.transparent_enable =  function(en)
  if (en) then
    vim.cmd([[
      highlight  Normal              guibg=NONE   ctermbg=NONE
      highlight  SignColumn          guibg=NONE   ctermbg=NONE
      highlight  DiffAdd             guibg=NONE   ctermbg=NONE
      highlight  DiffDelete          guibg=NONE   ctermbg=NONE
      highlight  DiffChange          guibg=NONE   ctermbg=NONE
      highlight  SignifyLineDelete   guibg=NONE   ctermbg=NONE
      highlight  SignifyLineChange   guibg=NONE   ctermbg=NONE
    ]])
  end
end

return M
