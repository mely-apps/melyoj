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

build_style() {
  echo "Creating $1 style..."
  cp resources/vars-$1.scss css/vars.scss
  sass resources:css
  postcss css/style.css css/martor-description.css css/select2-dmoj.css --verbose -d $2
}

build_style 'default' 'css'
build_style 'dark' 'css/dark'

echo yes | python3 manage.py collectstatic
