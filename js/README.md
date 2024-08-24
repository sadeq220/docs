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
To split functionality(separate concerns) in JavaScript, modules have been defined.      
Module refers to one JS file with one specific responsibility. modules may have specific extensions     
For example ES modules have `.mjs` extension, and CommonJs modules have `.cjs` extension.

> Node.js has had this ability for a long time, and there are a number of JavaScript libraries and frameworks that enable module usage     
> (for example, other CommonJS and AMD-based module systems like RequireJS, and more recently Webpack and Babel).

Node.js has two module systems: **CommonJS modules** and **ECMAScript modules**.      
Calling require() always use the CommonJS module loader. Calling import() always use the ECMAScript module loader.     

**ECMAScript Modules**(native ES modules) are using `export` and `import` keywords.      
ESmodules is a more modern approach that is currently supported by browser and server-side apps with Node.    

> [!WARNING]  
> set "type" field in package.json: "module"    

> [!NOTE]
> in HTML file you need to include type="module" in the <script> element

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
*default export* vs *named export*      
default export: one default function exported by the module.      
conversely, to named exports, default export don't need curly braces to be exported or imported.
this helps JavaScript modules to interoperate with existing CommonJS and AMD module systems
```js
function hi() {
    console.log("hi");
}
export default hi;
```
```js
import hiLogger from './moduleA.js';
```

**CommonJS modules** are using `module.exports` and `require`.     
CommonJS is mainly used in server-side JS apps with Node, as browsers don't support the use of CommonJS.     
CommonJS modules are the original way to package JavaScript code for Node.js.     

> [!NOTE]     
> set "type" field in package.json: "commonjs"

For example: moduleA file would be     
```js
let hi = () => {
    console.log("HI");
}
function log(text){
    console.log(text);
}
module.exports = {log, hi}
/**
 exports.hi = () =>{
    console.log("HI")
}
*/
```

and ModuleA could be utilized in main.js file as so
```js
const {hi , log} = require('./moduleA.js');
hi()
```

**The module wrapper**     
Before a module's code is executed, Node.js will wrap it with a function wrapper that looks like the following:     
```js
(function(exports, require, module, __filename, __dirname) {
// Module code actually lives in here
});
```
By doing this, Node.js achieves a few things:
- It keeps top-level variables (defined with var, const, or let) scoped to the module rather than the global object.

## References
- [node.js modules support](https://nodejs.org/api/esm.html)
- [node.js commonjs module](https://nodejs.org/api/modules.html)
- [native ES modules](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules)
- [node.js module wrapper](https://nodejs.org/api/modules.html#the-module-wrapper)