
let g:db_ui_icons = {
    \ 'expanded': '▾',
    \ 'collapsed': '▸',
    \ 'saved_query': '*',
    \ 'new_query': '+',
    \ 'tables': '~',
    \ 'buffers': '»',
    \ 'connection_ok': '✓',
    \ 'connection_error': '✕',
    \ }

let g:dbs = [
\ { 'name': 'dev', 'url': 'postgres://postgres:mypassword@localhost:5432/my-dev-db' },
\ { 'name': 'staging', 'url': 'postgres://postgres:mypassword@localhost:5432/my-staging-db' },
\ { 'name': 'wp', 'url': 'mysql://root@localhost/wp_awesome' },
\ ]
