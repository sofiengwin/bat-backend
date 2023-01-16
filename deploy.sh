# export AWS_PROFILE=terraform
set -x
CLUSTER="demo-ecs-cluster"
SERVICE="bat_backend"
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 955095246916.dkr.ecr.us-east-1.amazonaws.com

docker build -t bat_backend .

docker tag bat_backend:latest 955095246916.dkr.ecr.us-east-1.amazonaws.com/bat_backend:latest
docker push 955095246916.dkr.ecr.us-east-1.amazonaws.com/bat_backend:latest

aws ecs update-service --cluster ${CLUSTER}  --desired-count 1 --service ${SERVICE} --force-new-deployment --enable-execute-command >& /dev/null

# Deploy container
# Get task definitions
# Describe most recent task definition
# Create new task definition using most recent task definition
# Deploy service using the newly created task definition
# Wait for service to stabilize before confirming deployment is complete
