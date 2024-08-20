## JS and Node.js      
topics
- ECMAScript
- Node.js
- JavaScript modules
- npm packages and modules
- package.json structure


## Node.js
Node.js is a JRE(JavaScript Runtime Environment), it embeds the V8(chrome JavaScript Engine)


## JavaScript Modules
To split functionality in JavaScript, modules have been defined.      
Module refers to one JS file with one specific responsibility. modules may have specific extensions     
For example ES modules have `.mjs` extension, and CommonJs modules have `.cjs` extension.

> Node.js has had this ability for a long time, and there are a number of JavaScript libraries and frameworks that enable module usage     
> (for example, other CommonJS and AMD-based module systems like RequireJS, and more recently Webpack and Babel).

**ECMAScript Modules** are using `export` and `import` keywords.    
For example: moduleA would be
```js
function createCanvas(parent) {
    let htmlCanvasElement = document.createElement('canvas');
    parent.appendChild(htmlCanvasElement);
    htmlCanvasElement.width = 320;
    htmlCanvasElement.height = 320;
    let ctx = htmlCanvasElement.getContext('2d');
    return {
        ctx: ctx,
        id: htmlCanvasElement.id
    };
}

export {createCanvas};
```
and ModuleA could be utilized in main.js file as so
```js
import {createCanvas} from './moduleA.js';
createCanvas(document.body);
```

## References
- [node.js modules support](https://nodejs.org/api/esm.html)
- [JS modules](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules)