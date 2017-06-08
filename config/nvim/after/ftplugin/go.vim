map <leader>t :GoTest<CR>
map <leader>n <C-X><C-O>

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
