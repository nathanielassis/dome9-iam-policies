{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Dome9ReadOnly",
            "Action": [
                "cloudtrail:LookupEvents",
                "dynamodb:DescribeTable",
                "elasticfilesystem:Describe*",
                "elasticache:ListTagsForResource",
                "firehose:Describe*",
                "firehose:List*",
                "guardduty:Get*",
                "guardduty:List*",
                "kinesis:List*",
                "kinesis:Describe*",
                "kinesisvideo:Describe*",
                "kinesisvideo:List*",
                "logs:Describe*",
                "logs:Get*",
                "logs:FilterLogEvents",
                "lambda:List*",
                "s3:List*",
                "sns:ListSubscriptions",
                "sns:ListSubscriptionsByTopic",
                "waf-regional:ListResourcesForWebACL"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}