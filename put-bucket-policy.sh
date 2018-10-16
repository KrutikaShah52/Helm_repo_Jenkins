#!/bin/bash
DEFAULT_REGION="us-east-1"
AWS_REGION="${AWS_REGION:-${DEFAULT_REGION}}"

BUCKET="helm-nd5a0qsl"
NODE_ROLE_ARN="arn:aws:iam::454143665149:role/nodes.cluster1.learning-kubernetes.com"

export AWS_REGION

aws s3api put-bucket-policy --bucket ${BUCKET} --policy '{
   "Statement": [
      {
         "Effect": "Allow",
         "Principal": {
            "AWS": "'${NODE_ROLE_ARN}'"
          },
         "Action": [
          "s3:GetObject",
          "s3:PutObject"
          ],
         "Resource": "arn:aws:s3:::'${BUCKET}'/*"
      },
      {
         "Effect": "Allow",
         "Principal": {
            "AWS": "'${NODE_ROLE_ARN}'"
          },
         "Action": "s3:ListBucket",
         "Resource": "arn:aws:s3:::'${BUCKET}'"
      }
  ]
}'
