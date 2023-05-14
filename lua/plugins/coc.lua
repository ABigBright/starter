return {
    {
        'neoclide/coc.nvim', 
        branch = 'release',
        lazy = true,
        event = {},
        init = function()
        end,
        opts = {},
        config = function()
            vim.g.coc_global_extensions = { 
                "coc-json",
                "coc-lists",
                "coc-marketplace",
                "coc-explorer",
                "coc-snippets",
                "coc-sh",
                "coc-tsserver",
                "coc-vimlsp",
                "coc-actions",
                "coc-tasks",
                "coc-cmake",
                "coc-html",
                "coc-css",
                "coc-pyright",
                "coc-zi",
                "coc-markdownlint"
            }
            -- \ "coc-python",
            -- \ "coc-todolist",

            -- Some servers have issues with backup files, see #649
            vim.opt.backup = false
            vim.opt.writebackup = false

            -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
            -- delays and poor user experience
            vim.opt.updatetime = 300

            -- Always show the signcolumn, otherwise it would shift the text each time
            -- diagnostics appeared/became resolved
            vim.opt.signcolumn = "yes"

            local keyset = vim.keymap.set
            -- Autocomplete
            function _G.check_back_space()
                local col = vim.fn.col('.') - 1
                return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
            end

            -- Use K to show documentation in preview window
            function _G.show_docs()
                local cw = vim.fn.expand('<cword>')
                if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
                    vim.api.nvim_command('h ' .. cw)
                elseif vim.api.nvim_eval('coc#rpc#ready()') then
                    vim.fn.CocActionAsync('doHover')
                else
                    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
                end
            end
            keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

            -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
            vim.api.nvim_create_augroup("CocGroup", {})
            vim.api.nvim_create_autocmd("CursorHold", {
                group = "CocGroup",
                command = "silent call CocActionAsync('highlight')",
                desc = "Highlight symbol under cursor on CursorHold"
            })

            -- Setup formatexpr specified filetype(s)
            vim.api.nvim_create_autocmd("FileType", {
                group = "CocGroup",
                pattern = "typescript,json",
                command = "setl formatexpr=CocAction('formatSelected')",
                desc = "Setup formatexpr specified filetype(s)."
            })

            -- Update signature help on jump placeholder
            vim.api.nvim_create_autocmd("User", {
                group = "CocGroup",
                pattern = "CocJumpPlaceholder",
                command = "call CocActionAsync('showSignatureHelp')",
                desc = "Update signature help on jump placeholder"
            })

            -- Add `:Format` command to format current buffer
            vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

            -- " Add `:Fold` command to fold current buffer
            vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

            -- Add `:OR` command for organize imports of the current buffer
            vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

            -- Add (Neo)Vim's native statusline support
            -- NOTE: Please see `:h coc-status` for integrations with external plugins that
            -- provide custom statusline: lightline.vim, vim-airline
            vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

        end,
        keys = {
            { mode = {"n"}, "K", desc = "which_key_ignore" },
            -- Use Tab for trigger completion with characters ahead and navigate
            -- NOTE: There's always a completion item selected by default, you may want to enable
            -- no select by setting `"suggest.noselect": true` in your configuration file
            -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
            -- other plugins before putting this into your config
            { mode = {"i"}, "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', silent = true, noremap = true, expr = true, replace_keycodes = false },
            { mode = {"i"}, "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], silent = true, noremap = true, expr = true, replace_keycodes = false },

            -- Make <CR> to accept selected completion item or notify coc.nvim to format
            -- <C-g>u breaks current undo, please make your own choice
            { mode = {"i"}, "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], silent = true, noremap = true, expr = true, replace_keycodes = false },

            -- Use <c-j> to trigger snippets
            { mode = {"i"}, "<c-j>", "<Plug>(coc-snippets-expand-jump)", desc = "trigger-snippets" },
            -- Use <c-space> to trigger completion
            { mode = {"i"}, "<c-space>", "coc#refresh()", silent = true, expr = true, desc = "trigger-completion" },

            -- Use `[g` and `]g` to navigate diagnostics
            -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
            { mode = {"n"}, "[g", "<Plug>(coc-diagnostic-prev)", silent = true },
            { mode = {"n"}, "]g", "<Plug>(coc-diagnostic-next)", silent = true },

            -- GoTo code navigation
            { mode = {"n"}, "<leader>jc", "<Plug>(coc-definition)", silent = true, desc = "goto-definition" },
            { mode = {"n"}, "<leader>jg", "<Plug>(coc-type-definition)", silent = true, desc = "goto-type-definition" },
            { mode = {"n"}, "<leader>jI", "<Plug>(coc-implementation)", silent = true, desc = "goto-implementation" },
            { mode = {"n"}, "<leader>jh", "<Plug>(coc-references)", silent = true, desc = "goto-reference" },

            -- Symbol renaming
            { mode = {"n"}, "<leader>er", "<Plug>(coc-rename)", silent = true, desc = "rename-symbol" },

            -- Formatting selected code
            { mode = {"x"}, "<leader>ei", "<Plug>(coc-format-selected)", silent = true, desc = "format-selection" },
            { mode = {"n"}, "<leader>ei", "<Plug>(coc-format-selected)", silent = true, desc = "format-selection" },

            -- Apply codeAction to the selected region
            -- Example: `<leader>aap` for current paragraph
            { mode = {"x"}, "<leader>ec", "<Plug>(coc-codeaction-selected)", silent = true, nowait = true, desc = "codeaction-select"},
            { mode = {"n"}, "<leader>ec", "<Plug>(coc-codeaction-selected)", silent = true, nowait = true, desc = "codeaction-select"},

            -- Remap keys for apply code actions at the cursor position.
            { mode = {"n"}, "<leader>eg", "<Plug>(coc-codeaction-cursor)", silent = true, nowait = true, desc = "codeaction-cursor" },

            -- Remap keys for apply code actions affect whole buffer.
            { mode = {"n"}, "<leader>eh", "<Plug>(coc-codeaction-source)", silent = true, nowait = true, desc = "codeaction-all-buffer" },

            -- Remap keys for applying codeActions to the current buffer
            { mode = {"n"}, "<leader>ec", "<Plug>(coc-codeaction)", silent = true, nowait = true, desc = "codeaction-buffer" },

            -- Apply the most preferred quickfix action on the current line.
            { mode = {"n"}, "<leader>ef", "<Plug>(coc-fix-current)", silent = true, nowait = true, desc = "quickfix-action-to-curr-line" },

            -- Remap keys for apply refactor code actions.
            { mode = {"n"}, "<leader>em", "<Plug>(coc-codeaction-refactor)", silent = true, desc = "codeaction-refactor" },
            { mode = {"x"}, "<leader>en", "<Plug>(coc-codeaction-refactor-selected)", silent = true, desc = "selection-refactor" },
            { mode = {"n"}, "<leader>en", "<Plug>(coc-codeaction-refactor-selected)", silent = true, desc = "selection-refactor" },

            -- Run the Code Lens actions on the current line
            { mode = {"n"}, "<leader>eq", "<Plug>(coc-codelens-action)", silent = true, nowait = true, desc = "code-lens-action-to-curr-line" },

            -- Map function and class text objects
            -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
            { mode = {"x"}, "if", "<Plug>(coc-funcobj-i)", silent = true, nowait = true },
            { mode = {"o"}, "if", "<Plug>(coc-funcobj-i)", silent = true, nowait = true },
            { mode = {"x"}, "af", "<Plug>(coc-funcobj-a)", silent = true, nowait = true },
            { mode = {"o"}, "af", "<Plug>(coc-funcobj-a)", silent = true, nowait = true },
            { mode = {"x"}, "ic", "<Plug>(coc-classobj-i)", silent = true, nowait = true },
            { mode = {"o"}, "ic", "<Plug>(coc-classobj-i)", silent = true, nowait = true },
            { mode = {"x"}, "ac", "<Plug>(coc-classobj-a)", silent = true, nowait = true },
            { mode = {"o"}, "ac", "<Plug>(coc-classobj-a)", silent = true, nowait = true },

            -- Remap <C-f> and <C-b> to scroll float windows/popups
            ---@diagnostic disable-next-line: redefined-local
            { mode = "n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', silent = true, nowait = true, expr = true, desc = "which_key_ignore" },
            { mode = "n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', silent = true, nowait = true, expr = true, desc = "which_key_ignore" },
            { mode = "i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', silent = true, nowait = true, expr = true, desc = "which_key_ignore" },
            { mode = "i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', silent = true, nowait = true, expr = true, desc = "which_key_ignore" },
            { mode = "v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', silent = true, nowait = true, expr = true, desc = "which_key_ignore" },
            { mode = "v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', silent = true, nowait = true, expr = true, desc = "which_key_ignore" },

            -- Use CTRL-S for selections ranges
            -- Requires 'textDocument/selectionRange' support of language server
            { mode = "n", "<C-s>", "<Plug>(coc-range-select)", silent = true, desc = "which_key_ignore"},
            { mode = "x", "<C-s>", "<Plug>(coc-range-select)", silent = true, desc = "which_key_ignore"},


            -- Mappings for CoCList
            -- code actions and coc stuff
            ---@diagnostic disable-next-line: redefined-local
            -- local opts = {silent = true, nowait = true}

            -- Show all diagnostics
            { mode = {"n"}, "<leader>eD", ":<C-u>CocList diagnostics<cr>", silent = true, nowait = true, desc = "show-diagnostics" },

            -- Manage extensions
            { mode = {"n"}, "<leader>eE", ":<C-u>CocList extensions<cr>", silent = true, nowait = true, desc = "show-extension" },

            -- Show commands
            { mode = {"n"}, "<leader>ee", ":<C-u>CocList commands<cr>", silent = true, nowait = true, desc = "show-command" },

            -- Find symbol of current document
            { mode = {"n"}, "<leader>eo", ":<C-u>CocList outline<cr>", silent = true, nowait = true, desc = "symbol-within-curr-file" },

            -- Search workspace symbols
            { mode = {"n"}, "<leader>es", ":<C-u>CocList -I symbols<cr>", silent = true, nowait = true, desc = "symbols-within-workspace" },

            -- Do default action for next item
            { mode = {"n"}, "<leader>ej", ":<C-u>CocNext<cr>", silent = true, nowait = true, desc = "default-action-for-next-item" },

            -- Do default action for previous item
            { mode = {"n"}, "<leader>ek", ":<C-u>CocPrev<cr>", silent = true, nowait = true, desc = "default-action-for-prev-item" },

            -- Resume latest coc list
            { mode = {"n"}, "<leader>ep", ":<C-u>CocListResume<cr>", silent = true, nowait = true, desc = "resume-latest-coclist" },
        }
    }
}
