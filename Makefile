PROJECT_ID=terraform-setup
AWS_REGION=us-east-2
ENV=staging

create-tf-backend-bucket:
	aws s3 mb s3://rick-$(PROJECT_ID)-tfstate --region $(AWS_REGION) && \
	aws s3api put-bucket-versioning --bucket rick-$(PROJECT_ID)-tfstate --versioning-configuration Status=Enabled
	aws s3api put-bucket-encryption \
    --bucket rick-$(PROJECT_ID)-tfstate \
    --server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}'

create-tf-backend-dynamodb_tb:
	aws dynamodb create-table --table-name $(PROJECT_ID)-tf-state-lock \
	 --attribute-definitions AttributeName=LockID,AttributeType=S \
	  --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
	   --key-schema AttributeName=LockID,KeyType=HASH --region $(AWS_REGION)

tf-init:
	docker-compose -f deploy/docker-compose.yml run --rm terraform init

tf-fmt:
	docker-compose -f deploy/docker-compose.yml run --rm terraform fmt

tf-validate:
	docker-compose -f deploy/docker-compose.yml run --rm terraform validate

tf-plan:
	docker-compose -f deploy/docker-compose.yml run --rm terraform plan

tf-apply:
	docker-compose -f deploy/docker-compose.yml run --rm terraform apply

tf-destroy:
	docker-compose -f deploy/docker-compose.yml run --rm terraform destroy

tf-workspace-list:
	docker-compose -f deploy/docker-compose.yml run --rm terraform workspace list

tf-workspace-new-dev:
	docker-compose -f deploy/docker-compose.yml run --rm terraform workspace new dev