### 람다함수 실습 Lambda Function 코드 ###


# 코드 - S3버킷에서 파일 업로드 감지 후 읽혀진 온도에 따라 다른 메시지 출력하기

import json
import boto3
from datetime import datetime
 
client = boto3.client('s3')
 
def lambda_handler(event, context):
    what_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    try:
        response = client.get_object(Bucket=bucket, Key=key)
        
        text = response['Body'].read().decode()
        data = json.loads(text)
        
        if data['temperature'] > 40:
            print(f"Temperature detected : {data['temperature']}C at {what_time}")
            print("Be careful! It's getting really hot!!")
        else:
            print("So far so good")
    except Exception as e:
        print(e)
        raise e
