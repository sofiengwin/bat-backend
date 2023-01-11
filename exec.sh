#!/bin/bash
export AWS_PROFILE=terraform
set -xv
echo `aws ecs list-tasks --cluster demo-ecs-cluster --service-name bat_backend --query "taskArns"`
TASK=`aws ecs list-tasks --cluster demo-ecs-cluster --service-name bat_backend --query "taskArns" | jq .[0] | xargs`

echo "TASK1"
echo $TASK
echo "TASK2"
echo "${TASK}"

aws ecs execute-command --cluster demo-ecs-cluster --task "${TASK}" --container bat_backend --interactive --command "/bin/bash"
