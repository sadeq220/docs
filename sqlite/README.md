### SQLite database    
SQLite is an embedded SQL database engine library.    
SQLite is `serverless`(Classic serverless) meaning the database engine runs within the same process as the application.    
    Thus, there is no message passing and network activity.     
SQLite database is a single compact file(*.sqlite) in a well-defined cross-platform format,     
    it is often used as a container for transferring content from one system to another.        
SQLite works particularly well as a replacement for ad hoc data files.     
    Contrary to intuition, SQLite can be faster than the filesystem for reading and writing content to disk.     
    Think of SQLite not as a replacement for client/server databases(e.g. Oracle or MySQL) but as a replacement for fopen() library call.    
SQLite is **"flexibly typed"(Manifest typing)**.
> In manifest typing, the datatype is a property of the value itself, not of the column in which the value is stored.     
> SQLite thus allows the user to store any value of any datatype into any column regardless of the declared type of that column.    

There is one Byte reserved before any value to store its dataType and length.

### References
- [sqlite home doc](https://www.sqlite.org/docs.html)
- [sqlite serverless](https://www.sqlite.org/serverless.html)
- [sqlite distinctive features](https://www.sqlite.org/different.html)