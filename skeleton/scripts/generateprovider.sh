#!/bin/bash

accountrole=$1
accountNumber=$2
region=$3
ENV=$4
PROJECT=$5
# COST_CENTER=$6
# PROJECT_OWNER=$7
userinput() {

    # echo -n "Please enter target account number: "
    # echo -n "Please enter your role: [Developer/DevOp/Master]: "
    # read accountrole

    # echo -n "Please enter your region: "
    # read region
    echo "$accountNumber"
    echo "$ENV"
    # echo "$PROJECT_OWNER"
   
    # sed -i "s/projectvariable/$PROJECT/g" ./terraform.tfvars
    # sed -i "s/env_variable/$ENV/g" ./variables.tf
    # sed -i "s/cost_center_8/$COST_CENTER/g" ./terraform.tfvars
    # sed -i "s/project_owner_9/$PROJECT_OWNER/g" ./terraform.tfvars

        
    if [ "$1" == Developer ] || [ "$1" == DevOp ] || [ "$1" == Master ] || [ "$1" == CICD ]
    then
        echo "Profile for $accountrole role on $accountNumber getting generated"    
    else
        echo "$accountrole is not a valied role. Please choose between Developer/DevOp/Master"
    fi
}


generateconfigfile(){
cat >./provider.tf <<EOF
provider "aws" {
    region = "$region"
    assume_role {
        role_arn = "arn:aws:iam::$accountNumber:role/$accountrole"
    }
}

terraform {
   backend "s3" {
     bucket         = "syngenta-terraform-state-artifacts"
     key            = "$PROJECT/$ENV/terraform.tfstate"
     region         = "us-east-2"
     dynamodb_table = "cicd-terraform-state-artifact-locks"
   }
 }
EOF
}

userinput $accountrole $accountNumber $PROJECT $ENV
generateconfigfile $accountrole $accountNumber $region $PROJECT $ENV