#!/bin/bash

if [ ! -d "public" ]
then
rm -rf /symfony/* && rm -rf /symfony/.*
echo "Installation du projet Symfony"
git config --global user.email "${GIT_EMAIL}"
git config --global user.name "${GIT_USER}"
symfony new /symfony --webapp
fi
chown -R ${USER_NAME}:${USER_NAME} /symfony
chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}/.ssh

php -S 0.0.0.0:8000 -t public/
exec "$@" 