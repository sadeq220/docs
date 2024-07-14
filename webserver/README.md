### web server    
web server controls how to access hosted files.     
**HTTP server** refers to a web server serving static files, for example:    
- Apache HTTP Server(`httpd`)
- NGINX open source

**application server** refers to a dynamic web server which is built on top of an **HTTP server** , for example servlet containers(**implementation of Jakarta EE platform**):      
- Apache Tomcat
- JBoss Application Server

### NGINX Open Source 
NGINX is a high performance and modular server that you can use, for example, as a:    
- Web server
- Reverse proxy
- Load balancer    

> nginx has one master process and several worker processes.       
> The main purpose of the master process is to read and evaluate configuration, and maintain worker processes.        
> Worker processes do actual processing of requests.      
> nginx employs event-based model and OS-dependent mechanisms to efficiently distribute requests among worker processes.     

There is an Nginx executable file that the systemd unit file uses under the hood.    
```shell
# forceful shutdown of nginx (SIGTERM)
nginx -s stop
# graceful shutdown of nginx (SIGQUIT)
nginx -s quit
```
### References
- [mozilla web server definition](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/Web_mechanics/What_is_a_web_server)
- [nginx docs](https://docs.nginx.com/)
- [nginx open source basics](https://nginx.org/en/docs/beginners_guide.html)