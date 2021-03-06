#!/bin/bash
#
# System Info - The Cat
#

f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done
bld=$'\e[1m'
rst=$'\e[0m'
inv=$'\e[7m'

gtkrc="$HOME/.gtkrc-2.0"
gtktheme=$( grep gtk-theme-name /home/$USER/.gtkrc-2.0 | cut -f2 -d "=" | tr -d '"' | tr -d " ")
gtkicon=$( grep font_icon /home/$USER/.gtkrc-2.0 | cut -f2 -d "=" | tr -d '"' )
gtkfont=$( grep font_name /home/$USER/.gtkrc-2.0 | cut -f2 -d "=" | tr -d '"' )

if [ "$gtktheme" == "" ]; then
    gtktheme="None"
fi

if [ "$gtkicon" == "" ]; then
    gtkicon="None"
fi

if [ "$gtkfont" == "" ]; then
    gtkfont="None"
fi

# Wallpaper set by feh
wallpaper=$(cat /home/$USER/.fehbg | cut -c 63-105 | tr -d "'")

# Settings from ~/.Xresources
xdef="/home/$USER/.Xresources"
termfont="$(grep 'URxvt\*font' $xdef | tail -1 | cut -d\: -f2- | sed -re 's/xft://g; s/:size=(.*):.*/ \1/g; s/^ *//g' | cut -f1 -d ":")"

# Time and date
time=$( date "+%H.%M")
date=$( date "+%a %d %b" )

# OS
distro=$(head -1 /etc/issue | cut -f1 -d '\')
# kernel
kernel=$(uname -r)
# WM version
WinMan=$(i3 -v | awk '{ print $1,$2,$3 }')

# Other
#UPT=`uptime | awk -F'( |,)' '{print $2}' | awk -F ":" '{print $1}'`
#uptime=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')
#uptime2=$(uptime | sed -nr 's/.*\s+([[:digit:]]{1,2}):[[:digit:]]{2},.*/\1/p')
uptime=$(uptime | cut -f2 -d "p" | cut -f1 -d "," | tr -d " ")
load=$(cut -d " " -f1-3 /proc/loadavg)
size=$(df | grep '^/dev/[hs]d' | awk '{s+=$2} END {printf("%.0f\n", s/1048576)}')
use=$(df | grep '^/dev/[hs]d' | awk -M '{s+=$3} END {printf("%.0f\n", s/1048576)}')
gb=$(echo "G")
pac=$(pacman -Qe | wc -l)
pacman=$(pacman -Q | wc -l)
dist=$(cat /etc/issue | sed 's/ /n/')
COUNT=$(cat /proc/cpuinfo | grep 'model name' | sed -e 's/.*: //' | wc -l)
cpu1=$(cat /proc/cpuinfo | grep 'model name' | head -1 | awk '{ print $4,"Inc." }' | sed 's|(R)||')
cpu2=$(cat /proc/cpuinfo | grep 'model name' | head -1 | awk '{ print $5,$6,$8 }' | sed 's|(tm)||')
gpu1=$(lspci | grep VGA | awk '{ print $9 }' | tr -d '[]')
gpu2=$(lspci | grep VGA | awk '{ print $10,$11,$12,$13,$14 }' | tr -d '[]')
audio1=$(lspci | grep -E 'Audio device' | awk '{ print $8 }' | tr -d '[]' | tail -1)
audio2=$(lspci | grep -E 'Audio device' | awk '{ print $9,$10,$11 }' | tail -1)
rigmanu=$(sudo dmidecode -s system-manufacturer | awk '{ print $1 }')
rigprocname=$(sudo dmidecode -s system-product-name)

cat << EOF
$bld
$f7
$f7                    .c0N.   .'c.                  $H    the$f1 cat
$f7         'Okdl:'  ;OMMMMKOKNMMW:;o0l  .'.
$f7         ;MMMMMMWWMMMMMMMMMMMMMMMMMXKWMMK         $H $f4$time$NC - $f7$date
$f7         'MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK         $f6 $USER    $f1@ $f2$HOSTNAME
$f7          NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMO
$f7          dMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:          GTK Theme   $f1»$f4 $gtktheme$NC
$f7          'MMMMMMMMMMMMMMMMMMMMMMMMMMMMM.          GTK Icons   $f1»$f4 $gtkicon$NC
$f7          'MMMMMMMMMMMMMMMMMMMMMMMMMMMMM;          GTK Font    $f1»$f4$gtkfont$NC
$f7          lMMMMM  MMMMMMMMMM  MMMMMMMMMM,          Term Font   $f1»$f4 $termfont$NC
$f7          KMMMMM  MMMMMMMMMM  MMMMMMMMMM.          Uptime      $f1»$f4 $uptime
$f7         ;WMMMMMkNMMMMMMMMMMONMMMMMMMMMW:          Load        $f1»$f4 $load
$f7       oNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMO         HDD         $f1»$f4 $use$gb$f2/$f4$size$gb
$f7      .,cxKWMMMMMMMMMMMMMMMMMMMMMMMMMMMXdxo        Packages    $f1»$f4 $pacman
$f7         ;kWMMMMMMMMMMMMMMMMMMMMMMMMMMMM:          Wallpaper   $f1»$f4 $wallpaper$NC
$f7         '::'  .;ok0NMMMMWNK0kdoc;'  '::'          Distro $NC     $f1»$f4 $distro
$f8                   .:cc:;;.$NC                       $f7 WM     $NC     $f1»$f4 $WinMan
$f8                   .o0MMMK'$NC                       $f7 Kernel $NC     $f1»$f4 $kernel
$f1                     xMMM: $NC                       $f7 $rigmanu    $f1»$f4 $rigprocname
$f1                     KMMMl$NC                        $f7 $cpu1    $f1»$f4 $cpu2
$f1                    .MMMMo$NC                        $f7 $gpu1     $f1»$f4 $gpu2
$f1                    ,MMMMx$NC                        $f7 $audio1     $f1»$f4 $audio2
$f1                    oMMMMx$NC
$f1                    OMMMMO                        $f7"And you can go fuck yourself, bitch"
$f1                    .OMMMd                                                     $f7 the$f1 cat
$f1                      :Nl

EOF
