### RabbitMQ message broker    
RabbitMQ supports multiple messaging protocols and streaming.    
RabbitMQ is an implementation of multiple standards:
- AMQP 0-9-1
- AMQP 1-0
- MQTT
- STOMP

This document contains `AMQP 0-9-1` messaging protocol specifications.   
AMQP 0-9-1 consist of two parts  **AMQP model** and **AMQP protocol**.     

Terminologies used in this document:
- Broker: An application - implementing the AMQP model - that accepts connections from clients for message routing, queuing etc.
- Message: Content of data transferred / routed including information such as payload and message attributes.

### AMQP protocol
AMQP is an application layer protocol used for over-the-wire communication.     
AMQP is considered a binary protocol.    
AMQP instruction format is: `Class.Method`    
for example `basic.ack` , `basic.nack` , `basic.reject` , `connection.start` , `channel.open`   

**Delivery Tag**:When a consumer (subscription) is registered, messages will be delivered __(pushed)__ by RabbitMQ using the `basic.deliver` method.     
The method carries a delivery tag, which uniquely identifies the delivery on a channel.      
Delivery tags are therefore scoped per channel.    

**basic.ack(delivery-tag delivery-tag, bit multiple)**: if client sends it, it means consumer acknowledgements    
but if broker sends it, it is a protocol extension called *publisher confirms*

### References
- [rabbitmq amqp doc](https://www.rabbitmq.com/tutorials/amqp-concepts.html)
- [rabbitmq classes and methods](https://www.rabbitmq.com/amqp-0-9-1-quickref.html)
- [cloudamqp application layer protocol](https://www.cloudamqp.com/blog/what-is-amqp-and-why-is-it-used-in-rabbitmq.html)
- [rabbitmq publisher confirms](https://www.rabbitmq.com/confirms.html)