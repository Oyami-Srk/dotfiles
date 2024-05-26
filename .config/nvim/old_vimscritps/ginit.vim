function! Merge_gui_specified_keybindings(trail)
    let kbd_fn = "~/.config/nvim/keybindings_" . a:trail . ".json"
    if filereadable(expand(kbd_fn))
        let kbd_data = Read_json_file(expand(kbd_fn))
        call extend(g:which_key_map, kbd_data)
    else
        echo kbd_fn . ' Cannot be found.'
    endif
endfunction
