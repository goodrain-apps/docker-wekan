#!/usr/bin/env bash
[[ $DEBUG ]] && set -x

echo "now waiting container net ..."
sleep 10

export MONGODB_HOST=${MONGODB_HOST:-${MONGO_PORT_27017_TCP_ADDR}}
export MONGODB_PORT=${MONGODB_PORT:-${MONGO_PORT_27017_TCP_PORT}}

if [[ -z "${MONGODB_HOST}" ]]; then
    echo "no mongo"
    exit 1
fi

export MONGO_URL="mongodb://${MONGODB_HOST}:${MONGODB_PORT}/wekan"
export ROOT_URL=${SITE_URL:-"http://weikan.goodrain.com"}
export MAIL_FROM=${MAIL_FROM:-"admin@wekan.goodrain.com"}
export MAIL_URL="smtp://127.0.0.1"
export PORT=5000

if [[ ! "$ROOT_URL" =~ "/$" ]]; then
    export ROOT_URL="${ROOT_URL}/"
fi

debconf-set-selections <<< "postfix postfix/mailname text ${ROOT_URL}"
service postfix start

cd /app/bundle

export DEBUG=${DEBUG:-0}

if [[ $1 == "bash" ]]; then
    /bin/bash
else
    node main.js
fi

