#!/bin/bash

UNIQUE_ANIMAL_IDENTIFIER=$1

DOMAIN=$(aws elb describe-load-balancers --query "LoadBalancerDescriptions[?LoadBalancerName == 'playground-${UNIQUE_ANIMAL_IDENTIFIER}'].DNSName" --output text)

echo "Application successfully desployed! Please visit http://$DOMAIN in your browser to view it."