import boto3
import os

def lambda_handler(event, context):
    sns = boto3.client('sns')
    topic_arn = os.environ['SNS_TOPIC_ARN']
    
    build_id = event['detail']['build-id']
    project_name = build_id.split(':')[-2].split('/')[-1]
    build_status = event['detail']['build-status']
    
    message = f"""
    CodePipeline Failure Detected!
    Project: {project_name}
    Build ID: {build_id}
    Status: {build_status}
    
    Check CloudWatch Logs for more details.
    """

    sns.publish(
        TopicArn=topic_arn,
        Message=message,
        Subject=f"CodeBuild Failure: {project_name}"
    )
    
    return {
        'statusCode': 200,
        'body': 'Notification sent successfully'
    }