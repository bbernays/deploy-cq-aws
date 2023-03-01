# CloudQuery on AWS:

### Note: This template is an Alpha Feature, which means there might be issues but we are interested in your feedback

For fully supported deployment methods check out the Helm Chart and associated Terraform found on our [Documentation Site](https://www.cloudquery.io/docs/deployment/overview)



## Overview
This Cloudformation Template enables users to quickly setup an environment for using CloudQuery fetch functionality. This template creates resources that are not included in the Free tier. 


### Components:
- **Schedule Trigger**: An Eventbridge Rule that triggers periodically based on a schedule. The event contains the url of the configuration file stored in S3 that the fetch task will use. 
- **ECS Service**: ECS task running on top of Fargate



## Capabilities:
- Automate deployment of AWS resources using native tooling
- Fetch resources on a recurring basis

## Running:

1. Clone repo
2. Install aws cli v2
3. Set the name of your stack and the bucket where data will go:
```bash
export STACKNAME=CloudQuery-Deployment
export BUCKET_NAME=<S3 Bucket NAME> 
```
4. Deploy the stack: 
```bash
make deploy
```
5. Update the config file to specify the resources and regions you want to grab (by default it will grab all resources in all enabled regions)

```
This won't work yet, need to call aws ecs start-task directly. Need to ensure, VPC, SGs, Subnets, TaskID, ServiceName are all outputted from CFN
// make run-task
``` 
Note: this assumes that the cloudquery configuration file is located in the s3 bucket that was created by the template `s3://<bucket_name>/cloudquery.yml`

### Current Limitations:
- [ ] Support user defined VPC
- [x] Allow user to specify CQ core version
  - [ ] Needs documentation
- [ ] Enable user to define custom policy
- [ ] Provide way of interacting with external database
- [ ] Support using AWS RDS IAM credentials instead of admin credentials
- [ ] Document how to support multiple parallel cq fetches


## Send us feedback
To post feedback, submit feature ideas, or report bugs, use the Issues section of the GitHub repository or reach out to us on Discord.

