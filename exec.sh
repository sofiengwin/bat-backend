#!/bin/bash

TASK=`aws ecs list-tasks --cluster demo-ecs-cluster --service-name bat_backend | jq '.taskArns[0]'`

echo $TASK
echo "${TASK}"

aws ecs execute-command --cluster demo-ecs-cluster --task "arn:aws:ecs:us-east-1:955095246916:task/demo-ecs-cluster/9a61f5be4af04f1b899b5c5be57b7ac6" --container bat_backend --interactive --command "/bin/sh"