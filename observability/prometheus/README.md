### Prometheus, Time Series Database(TSDB)
Prometheus is a metric oriented, multidimensional, pull-based, Time Series DataBase.       
It stores metrics(which might have multiple labels) in a storage efficient manner.   
> An open-source monitoring system with a dimensional data model, 
> flexible query language, 
> efficient time series database and modern alerting approach.

### Prometheus, is not an observability backend
### Prometheus is a monitoring system
Prometheus "scrapes" (pulls) numerical data (metrics) from your services.    
True observability requires "The Three Pillars" (Metrics, Logs, and Traces) to be linked together.    
If you see a spike in Prometheus,    
you can't "click" on that spike to see the specific logs or traces associated with it within Prometheus itself.   
You usually need Grafana to bridge that gap.

### OpenMetrics format
```
float64 value;
EpochMillis timestamp;
metric_name{label_name="label_value", ...} value timestamp
prometheus_build_info{version="3.8.0", goversion="go1.25.4"} 1 1711050000
```
**Label (Dimension)**:    
a Label is a key-value pair attached to a metric.    
Think of it as metadata that turns a single flat number into a multidimensional data point.   
##### Why call it a "Dimension"?
Imagine you are tracking `http_requests_total`.
- Without labels, you only know the total requests for the whole system.
- With labels like `{method="GET", status="200", service="api"}`, you can suddenly "slice" the data:
  *Slice 1: Show me only `GET` requests.
  *Slice 2: Show me only `404` errors across all methods.
  *Slice 3: Compare the performance of `service="api"` vs `service="payment"`.


**Series (Identity)**:   
A Series is the unique identity of a metric. It is defined by the Metric Name + all its Labels.    
In the TSDB, each unique combination is assigned a unique Series ID.   

**Sample**:   
timestamp + value
