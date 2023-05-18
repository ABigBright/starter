return {
    {
        'folke/todo-comments.nvim',
        lazy = true,
        -- event = 'VeryLazy',
        cmd = { 
            "TodoTrouble", 
            "TodoTelescope", 
            "TodoLocList", 
            "TodoQuickFix" 
        },
        dependencies = {
        },
        init = function()
        end,
        opts = {
        },
        config = true,
        keys = {
        }
    }
}
