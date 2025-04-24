### Cache definition
Caching is a system design concept that involves storing frequently accessed data in a location that is easily and quickly accessible.    
The main reason why caching was born is that accessing data from persistent memories takes a considerable amount of time.      

### Cache vs ConcurrentMap
A Cache is similar to ConcurrentMap, but not quite the same.      
The most fundamental difference is that a ConcurrentMap persists all elements that are added to it until they are explicitly removed.      
A Cache on the other hand is generally configured to evict entries automatically, in order to constrain its memory footprint.     

### References
- [Caffeine cache](https://github.com/ben-manes/caffeine/wiki)
- [Auth0 caching](https://auth0.com/blog/what-is-caching-and-how-it-works/)