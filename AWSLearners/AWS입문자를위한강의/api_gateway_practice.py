import boto3
resource = boto3.resource('dynamodb')
table = resource.Table('customers')
def lambda_handler(event, context):
    table.put_item(Item=event)
    return {"code":200, "message": "Data Successfully Inserted!"}