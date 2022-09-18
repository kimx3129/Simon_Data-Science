### API Gateway 실습 Lambda Function 코드 ###


# 코드 - 레코드를 다이나모디비에 삽입하는 코드

import boto3
 
resource = boto3.resource('dynamodb')
table = resource.Table('customers')
def lambda_handler(event, context):
   table.put_item(Item=event)
   return {"code":200, "message": "Data Successfully Inserted!"}

