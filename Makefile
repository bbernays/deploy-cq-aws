

check-env:
ifndef STACKNAME
	$(error STACKNAME is undefined)
endif

.PHONY: deploy
deploy: check-env
	aws cloudformation deploy --template-file template.yml --stack-name $(STACKNAME) --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND
				

.PHONY: store-config
store-config: check-env
	AWS_PAGER="" aws s3 cp ./cloudquery.yml s3://$$(aws cloudformation describe-stacks --stack-name $$STACKNAME --query 'Stacks[0].Outputs[?OutputKey==`s3bucket`].OutputValue' --output text)/cloudquery.yml

.PHONY: run-task
run-task: check-env
	aws stepfunctions start-execution \
		--state-machine-arn $$(aws cloudformation describe-stacks --stack-name $$STACKNAME --query 'Stacks[0].Outputs[?OutputKey==`FetchOrchestrator`].OutputValue' --output text)  \
		--input $$(echo '{"ConfigLocation":"s3://'$$(aws cloudformation describe-stacks --stack-name $$STACKNAME --query 'Stacks[0].Outputs[?OutputKey==`s3bucket`].OutputValue' --output text)'/cloudquery.yml"}')

