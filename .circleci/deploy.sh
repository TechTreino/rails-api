#!/bin/bash
set -e
mkdir -p ${HOME}/lib ${HOME}/bin
curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/utilities/check_url.sh > ${HOME}/bin/check_url && chmod u+x ${HOME}/bin/check_url
export PATH=$PATH:${HOME}/bin

echo "${HEROKU_SSH_KEY}" >> ~/.ssh/known_hosts
echo "${HEROKU_PRIVATE_SSH_KEY}" >> ~/.ssh/id_rsa
echo "${HEROKU_SSH_KEY}" >> ~/.ssh/id_rsa.pub

git push heroku master
# Turn on Heroku maintenance mode and stop workers
heroku maintenance:on --app ${APP_NAME}
# run migrations and update static content
heroku run rake db:migrate --app "${APP_NAME}"
# Turn off Heroku maintenance mode and scale workers back up
heroku maintenance:off --app ${APP_NAME}
# restart dynos
heroku restart --app ${APP_NAME}
# check if the app is up and running
check_url https://techtreino-api.herokuapp.com/
