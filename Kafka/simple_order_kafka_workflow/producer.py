import json
import uuid

from confluent_kafka import Producer

# track message state
def delivery_report(err, msg):
    if err:
        print('Message delivery failed: {}'.format(err))
    else:
        print('Message delivery succeeded: {}'.format(msg.value().decode('utf-8')))
        print(f"Delivered to {msg.topic()}")

producer = Producer({'bootstrap.servers': 'localhost:9092'})

order = {
    "order_id": str(uuid.uuid4()),
    "user": "eunhye",
    "item": "hermes kelly bag",
    "quantity": 2
}

value = json.dumps(order).encode("utf-8")

producer.produce(topic='orders', value=value, callback=delivery_report)
producer.flush()


# get orders topic info
#  docker exec -it kafka kafka-topics --bootstrap-server localhost:9092 --describe --topic orders

# list all topics in the kafka container
#  docker exec -it kafka kafka-topics --list --bootstrap-server localhost:9092