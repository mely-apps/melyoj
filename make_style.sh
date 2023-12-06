#!/bin/sh
if ! [ -x "$(command -v sass)" ]; then
  echo 'Error: sass is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v postcss)" ]; then
  echo 'Error: postcss is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v autoprefixer)" ]; then
  echo 'Error: autoprefixer is not installed.' >&2
  exit 1
fi

cd "$(dirname "$0")" || exit

sass sass/style.scss:resources/style.css sass/martor-description.scss:resources/martor-description.css sass/select2-dmoj.scss:resources/select2-dmoj.css
