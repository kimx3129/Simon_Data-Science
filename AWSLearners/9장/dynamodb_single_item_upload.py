### 다이나모디비 실습 Lambda Function 코드 ###


# 코드 - 다이나모디비 하나의 데이터 업로드

import boto3
 
def lambda_handler(event, context):
   client = boto3.resource('dynamodb')
   table = client.Table('aws-learner-customer-transaction-table')
 
   table.put_item(
       Item={
           'customer_id': '12MCX',
           'transaction_date': '2020-08-02',
           'item_category': 'Book',
           'price': 18000
       }
   )
