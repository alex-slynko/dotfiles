map <leader>t :GoTest<CR>
map <leader>n <C-X><C-O>

let g:go_fmt_autosave = 1
let g:go_mod_fmt_autosave = 1
let g:go_metalinter_autosave = 0
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 0
let g:go_fmt_experimental = 1
let g:go_echo_command_info = 0
let g:go_rename_command = 'gopls'

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '➤'
let g:ale_sign_info = '➟'

let g:ale_echo_cursor = 1
let g:ale_virtualtext_cursor = 0
let g:ale_virtualtext_prefix = '▬▶  '
let g:ale_lint_on_save = 1

highlight link ALEVirtualTextError ErrorMsg
highlight link ALEVirtualTextStyleError ALEVirtualTextError
highlight link ALEVirtualTextWarning WarningMsg
highlight link ALEVirtualTextInfo ALEVirtualTextWarning
highlight link ALEVirtualTextStyleWarning ALEVirtualTextWarning

let g:ale_go_langserver_executable = 'gopls'

let g:ale_linters = {
\   'go': ['golangci-lint', 'gopls'],
\}

" This gets around typecheck errors for types defined in other files in the
" same package
let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = '--fast'

" Enable completion where available.
let g:ale_completion_enabled = 0

let g:projectionist_heuristics = {  
            \ '*.go': {
            \   '*.go': {
            \       'alternate': '{}_test.go',
            \       'type': 'source'
            \   },
            \   '*_test.go': {
            \       'alternate': '{}.go',
            \       'type': 'test'
            \   },
            \ }}

autocmd FileType go compiler go
autocmd! BufEnter *.go setlocal shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab
