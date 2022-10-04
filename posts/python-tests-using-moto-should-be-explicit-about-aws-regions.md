---
title: "Python tests using `moto` should be explicit about AWS regions"
date: "2022-10-04T15:42:26+01:00"
tags: ["Testing", "AWS"]
---

Consider this test that creates an S3 bucket using `moto`:

```py
import moto

def test_s3_bucket_creation():
    with moto.mock_s3():
        boto3.client("s3").create_bucket(Bucket="MyBucket")
```

This was failing locally for me with a `botocore.exceptions.ClientError`
exception:

```
An error occurred (IllegalLocationConstraintException) when calling the
CreateBucket operation: The unspecified location constraint is incompatible for
the region specific endpoint this request was sent to.
```

but was passing in a remote CI environment and on other people's machines.

## Why?

The problem is that `boto3` will take its [default AWS region from your
`~/.aws/config` file][boto3_config] and mine was set to Dublin:

```
[default]
region = eu-west-1
```

Remove this and the test passes.

## Default AWS regions

If there is no default region configured then `boto3` will default to
`us-east-1` when creating S3 buckets which, crucially, [allows buckets to be
created in a simpler process][boto3_create_bucket].

For other regions, S3 buckets need to be created with explicit location
constraint configuration:

```py
region = "eu-west-1"
client = boto3.client('s3', region_name=region)
client.create_bucket(
    Bucket="MyBucket",
    CreateBucketConfiguration={"LocationConstraint": region}
)
```

When creating S3 buckets in tests, it's better to use this formulation where the
region is explicitly specified.

## Moral of the story

Beware of `boto3` as it can take configuration from outside of your project
boundaries.

[boto3_config]:
  https://boto3.amazonaws.com/v1/documentation/api/latest/guide/configuration.html#overview
[boto3_create_bucket]:
  https://boto3.amazonaws.com/v1/documentation/api/latest/guide/s3-example-creating-buckets.html#create-an-amazon-s3-bucket
