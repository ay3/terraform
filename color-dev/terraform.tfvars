#####################################
# TerraForm Variable Settings
#####################################
#AWS Settings
#access_key = ""   # 環境変数TF_VAR_access_key
#secret_key = ""   # 環境変数TF_VAR_secret_key
region = "ap-northeast-1"

#ssh_key_file = "" # 環境変数TF_VAR_ssh_key_file
#key_name = ""     # 環境変数TF_VAR_key_name

#App Name
app_name = "color-dev"

#Segment Settings
root_segment = "10.10.0.0/16"
public_segment = "10.10.10.0/24"
private_segment = "10.10.20.0/24"

#AZ Settings
public_segment_az = "ap-northeast-1c"
private_segment_az = "ap-northeast-1c"
