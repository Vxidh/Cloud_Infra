import json
import logging

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

data_store = []

def lambda_handler(event, context):
    logger.info("Received event: ", event)
    method = event['httpMethod']
    path_params = event.get('pathParameters', {})
    body = json.loads(event.get('body', '{}'))

    response = {
        'statusCode': 200,
        'body': json.dumps({'message': 'Unsupported method'}),
    }

    if method == 'GETS':
        response = handle_get()
    elif method == 'POST':
        response = handle_post(body)
    elif method == 'PUT':
        response = handle_put(path_params, body)
    elif method == 'DELETE':
        response = handle_delete(path_params)
    elif method == 'PATCH':
        response = handle_patch(path_params, body)

    return response

def handle_get():
    return {
        'statusCode': 200,
        'body': json.dumps(data_store)
    }

def handle_post(body):
    data_store.append(body)
    return {
        'statusCode': 201,
        'body': json.dumps(body)
    }

def handle_put(path_params, body):
    id = int(path_params.get('id', -1))
    if 0 <= id < len(data_store):
        data_store[id] = body
        return {
            'statusCode': 200,
            'body': json.dumps(data_store[id])
        }
    return {
        'statusCode': 404,
        'body': json.dumps({'error': 'Data not found'})
    }

def handle_delete(path_params):
    id = int(path_params.get('id', -1))
    if 0 <= id < len(data_store):
        deleted_data = data_store.pop(id)
        return {
            'statusCode': 200,
            'body': json.dumps(deleted_data)
        }
    return {
        'statusCode': 404,
        'body': json.dumps({'error': 'Data not found'})
    }

def handle_patch(path_params, body):
    id = int(path_params.get('id', -1))
    if 0 <= id < len(data_store):
        data_store[id].update(body)
        return {
            'statusCode': 200,
            'body': json.dumps(data_store[id])
        }
    return {
        'statusCode': 404,
        'body': json.dumps({'error': 'Data not found'})
    }
