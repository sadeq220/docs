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
for example `Basic.Ack` , `Basic.Nack` , `Basic.Reject` , `Connection.Start` , `Channel.Open`

### References
- [rabbitmq amqp doc](https://www.rabbitmq.com/tutorials/amqp-concepts.html)
- [cloudamqp application layer protocol](https://www.cloudamqp.com/blog/what-is-amqp-and-why-is-it-used-in-rabbitmq.html)