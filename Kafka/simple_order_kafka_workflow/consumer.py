from confluent_kafka import Consumer
import json

consumer = Consumer({'bootstrap.servers': 'localhost:9092',
                     'group.id': 'order-tracker',
                     'auto.offset.reset': 'earliest'})

consumer.subscribe(["orders"])

print(f"Consumer is running and subscribed to topic 'orders'")

try:
    while True:
        msg = consumer.poll(1.0)
        if msg is None:
            continue
        if msg.error():
            print(f"Consumer error: {msg.error()}")
            continue

        value = msg.value().decode("utf-8")
        order = json.loads(value)
        print(f"Value: {order}")
except KeyboardInterrupt:
    print("Stopping consumer")
finally:
    consumer.close()

