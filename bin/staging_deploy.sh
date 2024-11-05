#!/bin/bash

curl -k -XPOST -H "Authorization: Token token="$DEPLOY_BOT_TOKEN $STAGING_DEPLOY_URL
