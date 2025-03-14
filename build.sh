aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 715371302281.dkr.ecr.us-east-1.amazonaws.com
docker build --platform linux/amd64 -t ecs-graceful-shutdown .
docker tag ecs-graceful-shutdown:latest 715371302281.dkr.ecr.us-east-1.amazonaws.com/ecs-graceful-shutdown:latest
docker push 715371302281.dkr.ecr.us-east-1.amazonaws.com/ecs-graceful-shutdown:latest