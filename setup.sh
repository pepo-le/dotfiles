#!/bin/bash
for f in .??*
do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue
    [ "$f" = ".desktop" ] && continue

    ln -s "$HOME"/dotfiles/"$f" "$HOME"/"$f"
done
