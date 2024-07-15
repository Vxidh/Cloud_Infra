import boto3
import json
import logging

iam = boto3.client('iam')
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def rotate_keys(user_name):
    keys = iam.list_access_keys(UserName=user_name)['AccessKeyMetadata']
    
    if len(keys) >= 2:
        oldest_key = min(keys, key=lambda x: x['CreateDate'])
        
        logger.info(f'Oldest access key found: {oldest_key["AccessKeyId"]}')
        iam.update_access_key(
            UserName=user_name,
            AccessKeyId=oldest_key['AccessKeyId'],
            Status='Inactive'
        )
        iam.delete_access_key(
            UserName=user_name,
            AccessKeyId=oldest_key['AccessKeyId']
        )
        
        logger.info(f'Deactivated and deleted old access key: {oldest_key["AccessKeyId"]}')
    new_key = iam.create_access_key(UserName=user_name)
    new_access_key_id = new_key['AccessKey']['AccessKeyId']
    new_secret_access_key = new_key['AccessKey']['SecretAccessKey']
    
    logger.info(f'New access key created: {new_access_key_id}')
    
    return new_access_key_id, new_secret_access_key

def lambda_handler(event, context):
    user_name = event['user_name']
    
    try:
        new_access_key_id, new_secret_access_key = rotate_keys(user_name)
        
        return {
            'statusCode': 200,
            'body': json.dumps({
                'new_access_key_id': new_access_key_id,
                'new_secret_access_key': new_secret_access_key
            })
        }
    except Exception as e:
        logger.error(f'Error rotating keys: {str(e)}')
        return {
            'statusCode': 500,
            'body': json.dumps({
                'error': str(e)
            })
        }

