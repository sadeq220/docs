### Cache definition
Caching is a system design concept that involves storing frequently accessed data in a location that is easily and quickly accessible.    
The main reason why caching was born is that accessing data from persistent memories takes a considerable amount of time.      
Cache for boosting system’s **performance**,  The intuitive reason why caching works is better `locality`[^1]     
When a data item is accessed, if it already appears in the cache, we say that there is a `cache hit`;     
otherwise, it is a `cache miss`. The ratio between the number of cache hits and     
the total number of data accesses is known as the cache `hit-ratio`.     

### Cache vs ConcurrentMap
A Cache is similar to ConcurrentMap, but not quite the same. Map lacks *eviction policy*.          
The most fundamental difference is that a ConcurrentMap persists all elements that are added to it until they are explicitly removed.      
A Cache on the other hand is generally configured to evict entries automatically, in order to constrain its memory footprint.     

### Eviction Policy
`Least Recently Used` is a popular eviction policy to its simplicity and good `hit rate` in common scenarios.     
`Clock` based policies that trade O(n) worst case time complexity.   
`Least Frequently Used (LFU)` keeps track of number of times an item is retrieved.     
Caffeine uses the `Window TinyLfu` policy due to its high hit rate and low memory footprint.    
**TinyLFU** is a frequency based cache admission policy, meaning when cache is full it decides    
which items should be evicted from the cache.     

### References
- [Caffeine cache](https://github.com/ben-manes/caffeine/wiki)
- [caffeine eviction policies](https://github.com/ben-manes/caffeine/wiki/Efficiency)
- [TinyLFU](https://arxiv.org/pdf/1512.00727)
- [Auth0 caching](https://auth0.com/blog/what-is-caching-and-how-it-works/)


[^1]: better locality, means related data is in a continuous storage space, and data retrieving doesn't entail index lookup.     