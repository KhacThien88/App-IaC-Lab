import boto3
import json
import os
from botocore.exceptions import ClientError

# Khởi tạo client cho EC2, RDS và AppConfig
ec2_client = boto3.client('ec2')
rds_client = boto3.client('rds')
appconfig_client = boto3.client('appconfigdata')

def get_appconfig_data():
    application_id = os.environ['APPCONFIG_APPLICATION_ID']
    environment_id = os.environ['APPCONFIG_ENVIRONMENT_ID']
    configuration_profile_id = os.environ['APPCONFIG_PROFILE_ID']

    try:
        session_response = appconfig_client.start_configuration_session(
            ApplicationIdentifier=application_id,
            EnvironmentIdentifier=environment_id,
            ConfigurationProfileIdentifier=configuration_profile_id
        )

        config_response = appconfig_client.get_latest_configuration(
            ConfigurationToken=session_response['InitialConfigurationToken']
        )

        if 'Configuration' in config_response and config_response['Configuration']:
            config_data = json.loads(config_response['Configuration'].read().decode('utf-8'))
            return config_data
        return {
            'allowed_tags': ['bastion-master'],
            'restrict_rds_public_access': true
        }
    except ClientError as e:
        print(f"Error retrieving AppConfig data: {e}")
        return {
            'allowed_tags': ['bastion-master'],
            'restrict_rds_public_access': true
        }
def check_ec2_public_ip(allowed_tags):
    response = ec2_client.describe_instances()
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            instance_id = instance['InstanceId']
            has_public_ip = 'PublicIpAddress' in instance
            tags = {tag['Key']: tag['Value'] for tag in instance.get('Tags', [])}
            is_bastion = any(tag in tags for tag in allowed_tags)

            if not is_bastion and has_public_ip:
                print(f"Instance {instance_id} does not have allowed tag and has public IP. Removing public IP...")
                try:
                    addresses = ec2_client.describe_addresses(PublicIps=[instance['PublicIpAddress']])
                    for address in addresses['Addresses']:
                        if 'AssociationId' in address:
                            ec2_client.disassociate_address(AssociationId=address['AssociationId'])
                            print(f"Disassociated EIP for instance {instance_id}")
                        if 'AllocationId' in address:
                            ec2_client.release_address(AllocationId=address['AllocationId'])
                            print(f"Released EIP for instance {instance_id}")
                except ClientError as e:
                    print(f"Error removing public IP for {instance_id}: {e}")

def check_rds_public_access(restrict_rds_public_access):
    if not restrict_rds_public_access:
        print("RDS public access check is disabled in AppConfig.")
        return

    response = rds_client.describe_db_instances()
    for db_instance in response['DBInstances']:
        db_instance_id = db_instance['DBInstanceIdentifier']
        is_public = db_instance['PubliclyAccessible']

        if is_public:
            print(f"RDS instance {db_instance_id} has public access enabled. Disabling public access...")
            try:
                rds_client.modify_db_instance(
                    DBInstanceIdentifier=db_instance_id,
                    PubliclyAccessible=False,
                    ApplyImmediately=True
                )
                print(f"Disabled public access for RDS instance {db_instance_id}")
            except ClientError as e:
                print(f"Error disabling public access for {db_instance_id}: {e}")

def lambda_handler(event, context):
    config = get_appconfig_data()
    allowed_tags = config.get('allowed_tags', ['bastion-master'])
    restrict_rds_public_access = config.get('restrict_rds_public_access', true)
    check_ec2_public_ip(allowed_tags)
    check_rds_public_access(restrict_rds_public_access)

    return {
        'statusCode': 200,
        'body': json.dumps('EC2 and RDS checks completed')
    }