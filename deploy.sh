aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 955095246916.dkr.ecr.us-east-1.amazonaws.com

docker build -t bat_backend .

docker tag bat_backend:latest 955095246916.dkr.ecr.us-east-1.amazonaws.com/bat_backend:latest
docker push 955095246916.dkr.ecr.us-east-1.amazonaws.com/bat_backend:latest