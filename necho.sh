#!/bin/bash 

# # # # # # # # # # # # # # # # # # # # # #
#                 COLORS                  # 
# # # # # # # # # # # # # # # # # # # # # # 
# Black        0;30    Dark Gray     1;30 #
# Red          0;31    Light Red     1;31 #
# Green        0;32    Light Green   1;32 #
# Brown/Orange 0;33    Yellow        1;33 #
# Blue         0;34    Light Blue    1;34 #
# Purple       0;35    Light Purple  1;35 #
# Cyan         0;36    Light Cyan    1;36 #
# Light Gray   0;37    White         1;37 #
# # # # # # # # # # # # # # # # # # # # # # 

# formats
normal="0;3"
bold="1;3"
underline="4;3"
background="4"
intense="0;9"
boldintense="1;9"
backgroundintense="0;10"

# color bases
base_black="0m"
base_red="1m"
base_green="2m"
base_yellow="3m"
base_blue="4m"
base_purple="5m"
base_cyan="6m"
base_gray="7m"

# base variables  
switch="\033["                    # color switch
nocolor="${switch}${base_black}"  # no color
color=$nocolor                    # set default color to no color

# determine color based on the argument
case "$1" in
  # normal
  black            |                 bk) color="${switch}${normal}${base_black}";;
  red              |                  r) color="${switch}${normal}${base_red}";;
  green            |                  g) color="${switch}${normal}${base_green}";;
  yellow           |                  y) color="${switch}${normal}${base_yellow}";;
  blue             |                  b) color="${switch}${normal}${base_blue}";;
  purple           |                  p) color="${switch}${normal}${base_purple}";;
  cyan             |                  c) color="${switch}${normal}${base_cyan}";;
  gray             |                 gy) color="${switch}${normal}${base_gray}";;
  # bold
  boldblack        | bblack     |   bbk) color="${switch}${bold}${base_black}";;
  boldred          | bred       |    br) color="${switch}${bold}${base_red}";;
  boldgreen        | bgreen     |    bg) color="${switch}${bold}${base_green}";;
  boldyellow       | byellow    |    by) color="${switch}${bold}${base_yellow}";;
  boldblue         | bblue      |    bb) color="${switch}${bold}${base_blue}";;
  boldpurple       | bpurple    |    bp) color="${switch}${bold}${base_purple}";;
  boldcyan         | bcyan      |    bc) color="${switch}${bold}${base_cyan}";;
  boldgray         | bgray       |   bgy) color="${switch}${bold}${base_gray}";;
  # underline
  underblack       | ublack     |   ubk) color="${switch}${underline}${base_black}";;
  underred         | ured       |    ur) color="${switch}${underline}${base_red}";;
  undergreen       | ugreen     |    ug) color="${switch}${underline}${base_green}";;
  underyellow      | uyellow    |    uy) color="${switch}${underline}${base_yellow}";;
  underblue        | ublue      |    ub) color="${switch}${underline}${base_blue}";;
  underpurple      | upurple    |    up) color="${switch}${underline}${base_purple}";;
  undercyan        | ucyan      |    uc) color="${switch}${underline}${base_cyan}";;
  undergray        | uray       |   ugy) color="${switch}${underline}${base_gray}";;
  # background
  bgblack          |               bgbk) color="${switch}${background}${base_black}";;
  bgred            |                bgr) color="${switch}${background}${base_red}";;
  bggreen          |                bgg) color="${switch}${background}${base_green}";;
  bgyellow         |                bgy) color="${switch}${background}${base_yellow}";;
  bgblue           |                bgb) color="${switch}${background}${base_blue}";;
  bgpurple         |                bgp) color="${switch}${background}${base_purple}";;
  bgcyan           |                bgc) color="${switch}${background}${base_cyan}";;
  bggray           |               bggy) color="${switch}${background}${base_gray}";;
  # intense
  intenseblack     | iblack     |   ibk) color="${switch}${intense}${base_black}";;
  intensered       | ired       |    ir) color="${switch}${intense}${base_red}";;
  intensegreen     | igreen     |    ig) color="${switch}${intense}${base_green}";;
  intenseyellow    | iyellow    |    iy) color="${switch}${intense}${base_yellow}";;
  intenseblue      | iblue      |    ib) color="${switch}${intense}${base_blue}";;
  intensepurple    | ipurple    |    ip) color="${switch}${intense}${base_purple}";;
  intensecyan      | icyan      |    ic) color="${switch}${intense}${base_cyan}";;
  intensegray      | iray       |   igy) color="${switch}${intense}${base_gray}";;
  # bold intense
  bintenseblack    | biblack    |  bibk) color="${switch}${boldintense}${base_black}";;
  bintensered      | bired      |   bir) color="${switch}${boldintense}${base_red}";;
  bintensegreen    | bigreen    |   big) color="${switch}${boldintense}${base_green}";;
  bintenseyellow   | biyellow   |   biy) color="${switch}${boldintense}${base_yellow}";;
  bintenseblue     | biblue     |   bib) color="${switch}${boldintense}${base_blue}";;
  bintensepurple   | bipurple   |   bip) color="${switch}${boldintense}${base_purple}";;
  bintensecyan     | bicyan     |   bic) color="${switch}${boldintense}${base_cyan}";;
  bintensegray     | biray      |  bigy) color="${switch}${boldintense}${base_gray}";;
  # bg intense
  bgintenseblack    | bgiblack  | bgibk) color="${switch}${backgroundintense}${base_black}";;
  bgintensered      | bgired    |  bgir) color="${switch}${backgroundintense}${base_red}";;
  bgintensegreen    | bgigreen  |  bgig) color="${switch}${backgroundintense}${base_green}";;
  bgintenseyellow   | bgiyellow |  bgiy) color="${switch}${backgroundintense}${base_yellow}";;
  bgintenseblue     | bgiblue   |  bgib) color="${switch}${backgroundintense}${base_blue}";;
  bgintensepurple   | bgipurple |  bgip) color="${switch}${backgroundintense}${base_purple}";;
  bgintensecyan     | bgicyan   |  bgic) color="${switch}${backgroundintense}${base_cyan}";;
  bgintensegray     | bgiray    | bgigy) color="${switch}${backgroundintense}${base_gray}";;
  *) text="$1"
esac

[ -z "$text" ] && text="${color}$2${nocolor}"

echo -e "$text"