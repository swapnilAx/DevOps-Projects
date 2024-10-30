#!/bin/bash

#########################################################################
# This script will list all the resources in the AWS account
#
# Author: Name-of-Author
# Version: v0.0.1
# Credit: 

# Script to automate the process of listing all the resources in an AWS account:-
#
# Following are the supported AWS services by the script
# 1. EC2
# 2. S3
# 3. RDS
# 4. DynamoDB
# 5. Lambda
# 6. EBS
# 7. ELB
# 8. CloudFront
# 9. CloudWatch
# 10. SNS
# 11. SQS
# 12. Route53
# 13. VPC
# 14. CloudFormation
# 15. IAM
# 16. *Others*
#
# The Script will prompt the user to enter the AWS region and the service for which the resources need to be listed.
#
# Usage: ./aws_resource_list.sh <aws_region> <aws_service>
# Example: ./aws_resource_list.sh us-east-1 ec2

# Will add more updates to this script in the future.
#########################################################################

echo -e "\n##########:- aws_resource_list.sh Script is running -:##########"

# Check if the required number of the arguments are passed or not
if [ $# -ne 2 ]; then
  echo -e "\nYou didn't provided all the necessary arguments. Refer below statements."
  echo -e "\n# Usage:    ./aws_resource_list.sh <aws_region> <aws_service>"
  echo -e "\n# Example:  ./aws_resource_list.sh us-east-1 ec2"
  echo -e '\n " Provide space between the script file name, aws_region name and aws_service name "'
  exit 1
else
  echo -e "\nAll arguments are provided successfully"
fi

# Assign the arguments to variables and convert the service to lowercase
aws_region=$1
aws_service=$2



# Check if the AWS-cli is installed or not
echo -e "\nChecking if AWS CLI is installed or not...."
if ! command -v aws &> /dev/null; then
  echo -e "\nAWS CLI is not installed, Please install AWS CLI and try running shellscript file again"
  exit 1
else
  echo -e "\nAWS CLI is installed"
fi

# Check if the AWS CLI is configured or not
echo -e "\nChecking if the AWS CLI is configured or not...."
if [ ! -d ~/.aws ]; then
  echo -e "\nAWS CLI is not configured. Please configure the AWS CLI and try again."
  exit 1
else
  echo -e "\nAWS CLI is configured"
fi

echo -e "\nProceeding...\n"
# Execute the AWS CLI command based on the service name ('Using switch case')

case $2 in
  ec2)
    echo -e "\nListing names of the running EC2 instances in $aws_region\n"
    aws ec2 describe-instances --filters Name=instance-state-name,Values=running --query "Reservations[].Instances[].Tags[?Key=='Name'].Value" --output text --region $aws_region
    #echo -e "\nListing EC2 instances in $aws_region\n"
    #aws ec2 describe-instances --region $aws_region
    echo -e "\nDescribing the ec2 instances properties in detail.\n"
    aws ec2 describe-instances --filters Name=instance-state-name,Values=running --query 'Reservations[].Instances[].{Name:Tags[?Key==`Name`].Value, InstanceId:InstanceId, InstanceType:InstanceType, PublicIpAddress:PublicIpAddress, SecurityGroups:SecurityGroups[].GroupName}' --output json --region $aws_region
    ;;
  s3)
    echo "Listing S3 Buckets in $aws_region"
    aws s3api list-buckets --region $aws_region
    ;;
  rds)
    echo "Listing RDS instances in $aws_region"
    aws rds describe-db-instances --region $aws_region
    ;;
  dynamodb)
    echo "Listing DynamoDB Tables in $aws_region"
    aws dynamodb list-tables --region $aws_region
    ;;
  lambda)
    echo "Listing Lambda functions in $aws_region"
    aws lambda list-functions --region $aws_region
    ;;
  ebs)
    echo "Listing EBS volumes in $aws_region"
    aws ec2 describe-vloumes --region $aws_region
    ;;
  elb)
    echo "Listing ELB in $aws_region"
    aws elb describe-load-balancers --region $aws_region
    ;;
  cloudfront)
    echo "Listing cloudfront Distributions in $aws_region"
    aws cloudfront list-distributions --region $aws_region
    ;;
  cloudwatch)
    echo "Listing cloudwatch alarms in $aws_region"
    aws cloudwatch list-metrics --region $aws_region
    ;;
  sns)
    echo "Listing SNS Topics in $aws_region"
    aws sns list-topics --region $aws_region
    ;;
  sqs)
    echo "Listing SQS Queues in $aws_region"
    aws sqs list-queues --region $aws_region
    ;;
  route53)
    echo "Listing Route53 hosted zones in $aws_region"
    aws route53 list-hosted-zones --region $aws_region
    ;;
  vpc)
    echo "Listing VPCs in $aws_region"
    aws ec2 describe-vpcs --region $aws_region
    ;;
  cloudformation)
    echo "Listing Cloudformation Stacks in $aws_region"
    aws cloudformation describe-stacks --region $aws_region
    ;;
  iam)
    echo "Listing IAM Users in $aws_region"
    aws iam list-users  --region $aws_region
    ;;
  *)
    echo "Invalid service. Please enter a valid service."
    exit 1
    ;;
esac
# snippet
# EC2)
#    aws ec2 describe-instances --region $aws_region
#    ;;




