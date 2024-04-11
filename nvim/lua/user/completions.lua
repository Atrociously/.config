local cmp = require('cmp')
local ls = require('luasnip');

local snip = ls.snippet
local t = ls.text_node
local insert = ls.insert_node
local func = ls.function_node

local html_tag_snippet = snip(
    {
        trig = "tag",
        namr = "HtmlTag",
        dscr = "An html element tag"
    },
    {
        t({"<"}), insert(1), t({">"}),
        insert(0, ""),
        t({"</"}), func(function(args) return args[1][1] end, {1}), t({">"}),
    }
)

ls.add_snippets("html", { html_tag_snippet })
ls.add_snippets("htmldjango", { html_tag_snippet })

ls.config.set_config({
    history = true,
    enable_autosnippets = true
})

cmp.setup({
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
        { name = 'path '},
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' }
    })
})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' }
    })
})

local autopairs = require('nvim-autopairs')
autopairs.setup({})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)
