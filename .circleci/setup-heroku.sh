#!/bin/bash
set -e

git remote add heroku https://git.heroku.com/${APP_NAME}.git
wget https://cli-assets.heroku.com/branches/stable/heroku-linux-amd64.tar.gz
mkdir -p ${HOME}/lib ${HOME}/bin && chmod u+x ${HOME}/bin && chmod u+x ${HOME}/lib
tar -xvzf heroku-linux-amd64.tar.gz -C ${HOME}/lib
ln -s ${HOME}/lib/heroku/bin/heroku ${HOME}/bin/heroku
export PATH=$PATH:${HOME}/bin

cat > ~/.netrc << EOF
machine api.heroku.com
  login $HEROKU_LOGIN
  password $HEROKU_API_KEY
machine git.heroku.com
  login $HEROKU_LOGIN
  password $HEROKU_API_KEY
EOF
