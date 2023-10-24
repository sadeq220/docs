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
second argument is for batched acknowledgement used to reduce network traffic.    
>Note: To enable confirms, a client sends the confirm.select method.

**basic.reject Vs basic.nack**: both have a same functionality: delivery negative acknowledgement    
but basic.nack is a protocol extension introduced by RabbitMQ to support batch negative acknowledgement.    

### AMQP model
`Queues`, `exchanges` and `bindings` are collectively referred to as AMQP entities.    
Exchanges are AMQP 0-9-1 entities where messages are sent to.     
Exchanges take a message and route it into zero or more queues.     
The routing algorithm used depends on the exchange type and rules called bindings.     
AMQP 0-9-1 brokers provide four exchange types:
- Direct exchange
  - Ideal for the unicast routing of messages.
- Fanout exchange
  - Route messages to all of the queues that are bound to it.
- Topic exchange
  - Route messages to one or many queues based on matching between a message routing key and the pattern that was used to bind a queue to an exchange.
- Headers exchange
  - The attributes used for routing are taken from the headers attribute
>The default exchange is a direct exchange with no name (empty string) pre-declared by the broker.     
>It has one special property that makes it very useful for simple applications: 
>every queue that is created is automatically bound to it with a routing key which is the same as the queue name.

The default exchange makes it seem like it is possible to deliver messages directly to queues, even though that is not technically what is happening.

### References
- [rabbitmq amqp model doc](https://www.rabbitmq.com/tutorials/amqp-concepts.html)
- [rabbitmq classes and methods](https://www.rabbitmq.com/amqp-0-9-1-quickref.html)
- [cloudamqp application layer protocol](https://www.cloudamqp.com/blog/what-is-amqp-and-why-is-it-used-in-rabbitmq.html)
- [rabbitmq publisher confirms](https://www.rabbitmq.com/confirms.html)