" Keybindings by Shiroko <hhx.xxm@gmail.com>

function! Read_json_file(fn)
python3 << EOF
import vim
import json
data = {}
with open(vim.eval('a:fn'), 'r') as f:
    data = json.load(f)
vim.command('let json_data = %s' % str(data))
EOF
    return json_data
endfunction

if filereadable(expand("~/.config/nvim/keybindings.json"))
   let g:which_key_map = Read_json_file(expand("~/.config/nvim/keybindings.json"))
endif
