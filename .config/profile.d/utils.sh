function scale_window() {
    xdotool selectwindow windowsize 1200 $((800-24)) 
}

alias sw=scale_window

function change_size() {
    for i in $@; do
        convert $i -background transparent -scale 1200x800 -gravity center -extent 1200x800 $i
    done
}

function icon_svg_to_png() {
    W=$(inkscape -W $1)
    H=$(inkscape -H $1)
    if ((W>H)); then
        inkscape --export-png=${1%%.*}.png --export-dpi=200 --export-background-opacity=0 -w 512 ${1}
    else
        inkscape --export-png=${1%%.*}.png --export-dpi=200 --export-background-opacity=0 -h 512 ${1}
    fi
    convert ${1%%.*}.png -background none -scale 512x512 -gravity center -extent 512x512 ${1%%.*}.png
}

alias cs=change_size
alias s2p=icon_svg_to_png

function search_id() {
    find . -type f -name "info.txt" -exec sh -c 'head -2 {} | tail -1' \; | while read line; do; jq ".[] | select(.HOMEPAGE == \"${line}\").id" ~/Projects/WorkScraper/results.json; done | sed 's/"//g'

}

function search_id2() {
    find . -type f -name "build.sh" -not \( -path "*/opt/apps/*" -or -path "*/src/*" \) -exec zsh -c '. {} 2> /dev/null&& echo $HOMEPAGE' \; | while read line; do; jq ".[] | select(.HOMEPAGE == \"${line}\").id" ~/Projects/WorkScraper/results.json; done | sed 's/"//g'
}

