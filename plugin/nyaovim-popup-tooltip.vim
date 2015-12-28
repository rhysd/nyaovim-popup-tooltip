if get(g:, 'loaded_nyaovim_popup_tooltip', 0) || !exists('g:nyaovim_version')
    finish
endif

let g:nyaovim_popup_tooltip_default_mapping = get(g:, 'nyaovim_popup_tooltip_default_mapping', 1)

augroup nyaovim-popup-tooltip
    autocmd!
augroup END

function! s:open_popup_tooltip(path, line, col) abort
    call rpcnotify(0, 'popup-tooltip:open', a:path, a:line, a:col)
    augroup nyaovim-popup-tooltip
        autocmd!
        autocmd CursorMoved,CursorMovedI * call rpcnotify(0, 'popup-tooltip:close') | autocmd! nyaovim-popup-tooltip
    augroup END
endfunction

function! TogglePopupTooltip(path, line, col)
    call rpcnotify(0, 'popup-tooltip:toggle', a:path, a:line, a:col)
endfunction
function! OpenPopupTooltip(path, line, col)
    call rpcnotify(0, 'popup-tooltip:open', a:path, a:line, a:col)
endfunction
function! ClosePopupTooltip()
    call rpcnotify(0, 'popup-tooltip:close')
endfunction

function! s:calc_virtline() abort
    if !&l:wrap
        return line('.') - line('w0') + 1
    endif

    let width = winwidth(0)
    let l = 0
    let c = line('w0')
    let end = line('.')

    while c < end
        let l += strdisplaywidth(getline(c)) / width + 1
        let c += 1
    endwhile

    return l + col('.') / width + 1
endfunction

nnoremap <silent><Plug>(nyaovim-popup-tooltip-open) :<C-u>call <SID>open_popup_tooltip('<C-r><C-p>', <SID>calc_virtline(), virtcol('.'))<CR>
vnoremap <silent><Plug>(nyaovim-popup-tooltip-open) y:call <SID>open_popup_tooltip('<C-r>"', <SID>calc_virtline(), virtcol('.'))<CR>
if g:nyaovim_popup_tooltip_default_mapping
    nmap <silent>gi <Plug>(nyaovim-popup-tooltip-open)
    vmap <silent>gi <Plug>(nyaovim-popup-tooltip-open)
endif

let g:loaded_nyaovim_popup_tooltip = 1
