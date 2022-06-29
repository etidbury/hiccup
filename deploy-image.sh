#!/bin/bash
set -exo pipefail


aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/d9d2k9d8

docker build -t hiccup .

docker tag hiccup:latest public.ecr.aws/d9d2k9d8/hiccup:latest


docker push public.ecr.aws/d9d2k9d8/hiccup:latest
