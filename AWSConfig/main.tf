# Rule EC2 không có public IP
resource "aws_config_config_rule" "ec2_no_public_ip" {
  name = "ec2-no-public-ip"

  source {
    owner             = "AWS"
    source_identifier = "EC2_INSTANCE_NO_PUBLIC_IP"
  }

  scope {
    compliance_resource_types = ["AWS::EC2::Instance"]
  }

  maximum_execution_frequency = "TwentyFour_Hours"
}

resource "aws_config_config_rule" "rds_no_public_access" {
  name = "rds-no-public-access"

  source {
    owner             = "AWS"
    source_identifier = "RDS_INSTANCE_PUBLIC_ACCESS_CHECK"
  }

  scope {
    compliance_resource_types = ["AWS::RDS::DBInstance"]
  }

  maximum_execution_frequency = "TwentyFour_Hours"
}
