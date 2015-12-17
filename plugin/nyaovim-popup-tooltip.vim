" TODO: Check g:nyaovim_running (does not work yet)
if get(g:, 'loaded_nyaovim_popup_tooltip', 0)
    finish
endif

let g:nyaovim_popup_tooltip_default_mapping = get(g:, 'nyaovim_popup_tooltip_default_mapping', 1)

augroup nyaovim-popup-tooltip
    autocmd!
augroup END

function! s:open_popup_tooltip(path, line, col)
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

nnoremap <silent><Plug>(nyaovim-popup-tooltip-toggle) :<C-u>call <SID>open_popup_tooltip('<C-r><C-p>', line('.') - line('w0') + 1, virtcol('.'))<CR>
vnoremap <silent><Plug>(nyaovim-popup-tooltip-toggle) y:call <SID>open_popup_tooltip('<C-r>"', line('.') - line('w0') + 1, virtcol('.'))<CR>
if g:nyaovim_popup_tooltip_default_mapping
    nmap <silent>gi <Plug>(nyaovim-popup-tooltip-toggle)
    vmap <silent>gi <Plug>(nyaovim-popup-tooltip-toggle)
endif

let g:loaded_nyaovim_popup_tooltip = 1
