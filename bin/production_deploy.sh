#!/bin/bash

curl -k -XPOST -H "Authorization: Token token="$DEPLOY_BOT_TOKEN $PRODUCTION_DEPLOY_URL
