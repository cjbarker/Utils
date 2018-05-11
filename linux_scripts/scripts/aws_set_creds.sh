#!/usr/bin/env bash

# #########################################################
# aws_set_creds.sh
#
# Checks if AWS_PROFILE set and will populate appropriate
# AWS environment variables.
#
# Usage: source aws_set_creds.sh
# #########################################################

CONFIG_FILE=~/.aws/config

if [ ! -f ${CONFIG_FILE} ]; then
    exit 1
fi

if [ -z ${AWS_PROFILE} ]; then
    exit 2
fi

PROFILE="profile ${AWS_PROFILE}"
ACCESS_KEY_ID=`cat ${CONFIG_FILE} | grep "${PROFILE}" -A 3 | grep "aws_access_key_id" | cut -d'=' -f2 | tr -d '[:space:]'`
SECRET_ACCESS_KEY=`cat ${CONFIG_FILE} | grep "${PROFILE}" -A 3 | grep "aws_secret_access_key" | cut -d'=' -f2 | tr -d '[:space:]'`
REGION=`cat ${CONFIG_FILE} | grep "${PROFILE}" -A 3 | grep "region" | cut -d'=' -f2 | tr -d '[:space:]'` 

if [ -z ${ACCESS_KEY_ID} -a -z ${SECRET_ACCESS_KEY} ]; then
    exit 3
fi

export AWS_ACCESS_KEY_ID="${ACCESS_KEY_ID}"
export AWS_SECRET_ACCESS_KEY="${SECRET_ACCESS_KEY}"
export AWS_DEFAULT_REGION="${REGION}"

exit 0
