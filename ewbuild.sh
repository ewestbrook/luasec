#!/bin/bash -x

set -e

[[ -n $LUAINC ]] || {
  for i in /usr{local/,}/include{,/lua{,{,/}5.1}} ; do
    [[ -e $i/lua.h ]] && {
      LUAINC="$i"; break; }; done; }
echo "LUAINC=$LUAINC" >&2

[[ -n $LUAINC ]] || {
  echo "No lua inc dir found" >&2
  exit 1; }

make clean
make INC_PATH="-I$LUAINC" linux
sudo make LUAPATH=/usr/local/share/lua/5.1 LUACPATH=/usr/local/lib/lua/5.1 install
