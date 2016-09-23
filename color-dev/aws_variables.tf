#####################################
# Variable Settings
#####################################
#AWS Settings
variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "s3_bucket_name" {}

#KeyPair Settings
variable "ssh_key_file" {}
variable "key_name" {}

#App Name
variable "app_name" {}

#Segment Settings
variable "root_segment" {}
variable "public_segment" {}
variable "private_segment" {}

#AZ Settings
variable "public_segment_az" {}
variable "private_segment_az" {}
