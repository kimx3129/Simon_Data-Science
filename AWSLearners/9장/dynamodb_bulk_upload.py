### 다이나모디비 실습 Lambda Function 코드 ###


# 코드 - 다이나모디비 다량의 데이터 업로드
import boto3
 
def lambda_handler(event, context):
   client = boto3.resource('dynamodb')
   table = client.Table('aws-learner-customer-transaction-table')
  
   with table.batch_writer() as batch:
       batch.put_item(
           Item={
               'customer_id': '95IUZ',
               'transaction_date': '2020-10-24',
               'item_category': 'Desk',
               'price': 120000
           }
       )
      
       batch.put_item(
           Item={
               'customer_id': '72MUE',
               'transaction_date': '2020-10-28',
               'item_category': 'Chair',
               'price': 250000
           }
       )
      
       batch.put_item(
           Item={
               'customer_id': '28POR',
               'transaction_date': '2020-11-05',
               'item_category': 'Shampoo',
               'price': 50000
           }
       )
      
       batch.put_item(
           Item={
               'customer_id': '43NCH',
               'transaction_date': '2020-10-12',
               'item_category': 'Pulse',
               'price': 320000
           }
       )
