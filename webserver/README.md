### web server    
A web server is software[^1] that delivers web pages over a network (wire).   

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
#### nginx configuration file (nginx.conf)      
nginx consists of modules which are controlled by *directives* specified in the configuration file.      
There are two kinds of directives:     
- simple directive
- block directive
    - context (block directive which has other directive inside)

Important *contexts* are **http**, **server**, **location**.      

**http context**:     
Provides the configuration file context in which the HTTP server directives are specified.      
```nginx.conf
http {
  access_log  /var/log/nginx/access.log  main;
  server {
  }
}
```
**server context**:    
Sets configuration for a **virtual server** (provides multi-tenant system). There is no clear separation between IP-based (based on the IP address) and name-based (based on the “Host” request header field) virtual servers.     
```nginx.conf
server {
  server_name   example.com www.example.com;
  listen        80;
  root          /usr/share/nginx/html;
}
```
**location context**:     
Sets configuration depending on a request URI (path).A location can either be defined by a prefix string, or by a regular expression.        
Regular expressions are specified with the preceding “~*” modifier (for case-insensitive matching), or the “~” modifier (for case-sensitive matching).        
Also, using the “=” modifier it is possible to define an exact match of URI and location.     
```nginx.conf
server {
  location /bff {
        proxy_pass https://api-gateway.cloud/;
        rewrite ^/bff/(.*)$ /$1 break;
  }
  location / {
        proxy_pass https://spa.cloud/;
  }
  error_page 500 502 503 504 /50x.html;
  location = /50x.html {
        root /usr/share/nginx/html/error;
  }
}
```
### References
- [mozilla web server definition](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/Web_mechanics/What_is_a_web_server)
- [nginx docs](https://docs.nginx.com/)
- [nginx open source basics](https://nginx.org/en/docs/beginners_guide.html)
- [nginx modules config doc](https://nginx.org/en/docs/http/ngx_http_core_module.html#server)

[^1]: web server can refer to hardware as well