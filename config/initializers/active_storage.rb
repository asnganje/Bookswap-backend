require "aws-sdk-s3"
Aws.config.update({
  request_checksum_calculation: "WHEN_REQUIRED",
  response_checksum_validation: "WHEN_REQUIRED"
})
