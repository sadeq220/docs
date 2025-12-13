### Cloud-native Observability 
Observability refers to the ability to monitor, measure, and understand the state of a system or application    
by examining its outputs, logs, and performance metrics.        
In modern software systems and cloud computing, observability plays an increasingly crucial role in ensuring the     
`reliability(fault-tolerance patterns)`, `performance(response-time)`, `security(influx of requests)` of applications and infrastructure.     
Observability absorbs and extends classic monitoring systems and helps teams identify the root cause of issues.    

Why Observability Matters?
- to proactively address problems and anomalies before they impact end-users. 
- the rise of `platform engineering(query metrics)` as a discipline    
- the widespread adoption of microservices, and the growing reliance on distributed architectures.    

Observability absorbs and extends classic monitoring systems and helps teams identify the root cause of issues.    

Benefits of observability?    
- Improved reliability 
- Efficient troubleshooting
- Optimized performance
- Data-Driven decision-making

In a nutshell, cloud-native observability is a practice of monitoring, analyzing, and troubleshooting modern,    
cloud-native applications built using microservices architecture and deployed in containers or serverless environments.    

### Observability in DevOps
As observability becomes increasingly important for ensuring the reliability and performance of cloud-native applications,     
there is a greater focus on observability in the DevOps process.    
This includes the integration of observability tools into the DevOps toolchain, such as:    
- Prometheus/Grafana
- Jaeger
- Kafka
- OpenTelemetry

### Metrics, Logs, Traces
Metrics, Logs, and Traces , plus events are types of `Telemetry data`, and are pillars of Observability.   
- Log: timestamped text record
- Trace: the breadcrumb trail a request leaves as it moves through a system
  - the journey of a user transaction flow across different services
  - helps with root cause analysis, and identifying bottlenecks
- Metric: numerical measurement of a system, software, or application captured at runtime.
  - quantity analysis of performance over time, and include things like CPU usage, request rate, error rate, response time, and memory utilization.
  - helps with anomaly detection to things like capacity planning and SLA compliance monitoring

### OpenTelemetry
The open source observability framework that unifies data collection and standardizes telemetry data formats.   
To send your telemetry data. you'll need a transmission protocol.     
This could be HTTPS (or HTTP) for web apps,     
MQTT for IoT devices,     
or even specialized protocols such as OpenTelemetry (OTLP).    


### References
- [redhat observability](https://www.redhat.com/en/topics/devops/what-is-observability)
- [elasticsearch telemetry data](https://www.elastic.co/what-is/telemetry-data)
