# bspwm-resize
#!/usr/bin/env dash
 
#if bspc query -N -n focused.floating > /dev/null; then
 #   step=20
#else
 #   step=100
#fi
 
#case "$1" in
   # west) dir=right; falldir=left; x="-$step"; y=0;;
   # east) dir=right; falldir=left; x="$step"; y=0;;
  #  north) dir=top; falldir=bottom; x=0; y="-$step";;
 #   south) dir=top; falldir=bottom; x=0; y="$step";;
#esac
 
#bspc node -z "$dir" "$x" "$y" || bspc node -z "$falldir" "$x" "$y"



#!/bin/bash

size=${2:-'10'}
dir=$1

# Find current window mode
is_tiled() {
bspc query -T -n | grep -q '"state":"tiled"'
}
# If the window is floating, move it
if ! is_tiled; then
#only parse input if window is floating,tiled windows accept input as is
        case "$dir" in
                west) switch="-w"
                sign="-"
                ;;
                east) switch="-w"
                sign="+"
                ;;
                north) switch="-h"
                sign="-"
                ;;
                south) switch="-h"
                sign="+"
                ;;
                esac
 xdo resize ${switch} ${sign}${size}

# Otherwise, window is tiled: switch with window in given direction
else
     case "$dir" in
                west) bspc node @west -r -$size || bspc node @east -r -${size}
                ;;
                east) bspc node @west -r +$size || bspc node @east -r +${size}
                ;;
                north) bspc node @south -r -$size || bspc node @north -r -${size}
                ;;
                south) bspc node @south -r +$size || bspc node @north -r +${size}
                ;;
                esac
fi
