#!/bin/sh

# Changes .md file names to .dita
# fixes links and shortens file names
# usage: cd [bookdirectory]; sh [me]

for i in *.md; do
  f=`echo $i | sed -e 's/\.md$/.dita/'`
  mv $i ${f}
done

for i in *.dita *.ditamap; do
  sed -i -e 's/href="\([^.]*\).md"/href="\1.dita"/g' $i
done
