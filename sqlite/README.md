### SQLite database    
SQLite is an embedded SQL database engine library.    
SQLite is `serverless`(Classic serverless) meaning the database engine runs within the same process as the application.    
    Thus, there is no message passing and network activity.     
SQLite database is a single compact file(*.sqlite) in a well-defined cross-platform format,     
    it is often used as a container for transferring content from one system to another.        
SQLite works particularly well as a replacement for ad hoc data files.     
    Contrary to intuition, SQLite can be faster than the filesystem for reading and writing content to disk.     
    Think of SQLite not as a replacement for client/server databases(e.g. Oracle or MySQL) but as a replacement for fopen() library call.

### References
- [sqlite serverless](https://www.sqlite.org/serverless.html)