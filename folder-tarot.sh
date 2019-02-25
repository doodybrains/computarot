#!/bin/bash
do_reading() {
  for run in {1..3}
  do
    foo=$(curl 'https://raw.githubusercontent.com/dariusk/corpora/master/data/divination/tarot_interpretations.json')

    x=`echo $foo | jq --arg random $((0 + RANDOM % 78)) '.["tarot_interpretations"] | .[$random|tonumber].name'`

    y=`echo $foo | jq --arg random $((0 + RANDOM % 78)) '.["tarot_interpretations"] | .[$random|tonumber].keywords[0]'`

    mkdir "${x//\"}"
    cd "${x//\"}"
    open .
    mkdir "${y//\"}"
    mdfind "${y//\"}" | head -3 | while IFS= read -r filez; do cp "$filez" "${y//\"}"; done
    cd "${y//\"}"
    open .
    cd ..
    cd ..
  done
}

cd ..

if [ -d "computarot-reading" ]; then
  rm -r computarot-reading

  mkdir computarot-reading

  cd computarot-reading

  do_reading

elif [ ! -d "computarot-reading" ]; then
  mkdir computarot-reading

  cd computarot-reading

  do_reading
fi
