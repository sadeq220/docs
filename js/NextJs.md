## App router and Pages router
Next.js uses a file-system based router where directories are used to define URL path.      
By default, components inside app directory are `React Server Components`.    
and by Next.js special file convention, a directory's UI is rendered as a hierarchy of components:
```
parent directory layout.js   
    parent directory template.js 
        parent directory error, loading, not-found  
            layout.js
                template.js
                    error.js react boundary
                        loading.js react suspense boundary
                            not-found.js react error boundary
                                page.js
                            
```
![nested components](./nextjs-nested-file-conventions-component-hierarchy.jpg)
> Next.js uses a file-system based router where folders are used to define routes.     
> A special page.js file is used to make route segments publicly accessible.     
> A layout file to show UI that is shared across multiple routes.

`layout.js`:      
> A layout is UI that is shared between multiple routes.      
> On navigation, layouts preserve state, remain interactive, and do not re-render.      

`template.js`:     
> Templates are similar to layouts in that they wrap a child layout or page.       
> Unlike layouts that persist across routes and maintain state, templates create a new instance for each of their children on navigation.   


## References
- [define route](https://nextjs.org/docs/app/building-your-application/routing/defining-routes)
- [app router](https://nextjs.org/docs/app/building-your-application/routing)