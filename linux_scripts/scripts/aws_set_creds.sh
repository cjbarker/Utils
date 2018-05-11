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
CRED_FILE=~/.aws/credentials

if [ ! -f ${CONFIG_FILE} -a ! -f ${CRED_FILE} ]; then
    return
fi

if [ -z ${AWS_PROFILE} ]; then
    return
fi

PROFILE="profile ${AWS_PROFILE}"
REGION=`cat ${CONFIG_FILE} | grep "${PROFILE}" -A 3 | grep "region" | cut -d'=' -f2 | tr -d '[:space:]'` 

PROFILE="${AWS_PROFILE}"
ACCESS_KEY_ID=`cat ${CRED_FILE} | grep "${PROFILE}" -A 3 | grep "aws_access_key_id" | cut -d'=' -f2 | tr -d '[:space:]'`
SECRET_ACCESS_KEY=`cat ${CRED_FILE} | grep "${PROFILE}" -A 3 | grep "aws_secret_access_key" | cut -d'=' -f2 | tr -d '[:space:]'`

if [ -z ${ACCESS_KEY_ID} -a -z ${SECRET_ACCESS_KEY} ]; then
    return
fi

export AWS_ACCESS_KEY_ID="${ACCESS_KEY_ID}"
export AWS_SECRET_ACCESS_KEY="${SECRET_ACCESS_KEY}"
export AWS_DEFAULT_REGION="${REGION}"
