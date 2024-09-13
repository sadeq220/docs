## JS and Node.js      
topics
- ECMAScript
- Node.js
- JS prototype chain
- JavaScript modules
- npm packages and modules
- package.json structure
- bundling


## Node.js
Node.js is a JRE(JavaScript Runtime Environment), it embeds the V8(chrome JavaScript Engine)

## JS prototype chain
> All objects in JavaScript inherit from at least one other object.       
> The object being inherited from is known as the prototype,       
> and the inherited properties can be found in the prototype object of the constructor.      

Wiki: In JavaScript, an object is an associative array, augmented with a prototype;      
each key provides the name for an object property, and there are two ways to access the object property
```js
obj.x // dot notation
obj['x'] // bracket notation
```
The root prototype of all js objects is `Object.prototype` and its own prototype is null.       
The `Object.create()` method creates a new object and allows you to specify an object that will be used as the new object's prototype.       
```js
const personPrototype = {
  greet() {
    console.log("hello!");
  },
};

const carl = Object.create(personPrototype);
carl.greet(); // hello!
```
> In JavaScript, all functions have a property named prototype.      
> When you call a function as a constructor, this property is set as the prototype of the newly constructed object (by convention, in the property named __proto__).

```js
const personPrototype = {
  greet() {
    console.log(`hello, my name is ${this.name}!`);
  },
};

function Person(name) {
  this.name = name;
}

Object.assign(Person.prototype, personPrototype);
// or
// Person.prototype.greet = personPrototype.greet;
```

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
> in HTML file you need to include type="module" in the \<script\> element

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

## npm packages and modules
The npm registry contains packages, many of which are also Node modules, or contain Node modules.     
npm registry is a hub to share packages. its URL is configured in `npm config` as follows:    
```.npmrc
registry = "https://registry.npmjs.org/"
```
npm package:     
> A package is a file or directory that is described by a package.json file.     
> A package must contain a package.json file in order to be published to the npm registry.

npm module:    
> A module is any file or directory in the node_modules directory that can be loaded by the Node.js require() function.

To be loaded by the Node.js require() function, a module must be one of the following:    
- A folder with a package.json file containing a "main" field.
- A JavaScript file(so not all modules are packages).

To install a npm package:    
```shell
# scope is a namespace for specific organization or user 
npm install @<scope>/<package-name>
# public packages are always unscoped
npm install <package-name>
```
## package.json structure
> You can add a package.json file to your package to make it easy for others to manage and install.      
> Packages published to the registry must contain a package.json file.    

package.json file lists the packages your project depends on.     
A package.json file must contain "name" and "version" fields.     
To initialize a package.json file, execute `npm init`    

There is also an automatically generated file called *package-lock.json*, that represents *node_modules* directory exact dependency tree.     
by "exact" it means dependency versions don't include "* ^ ~".     
this file can make the subsequent installs similar to current one by using `npm ci`(npm clean-install)     
npm clean-install used in CI/CD context to achieve reproducible builds.    
this file also helps npm to skip repeated metadata resolutions for previously-installed packages.    

## JS bundling
bundling in JS refers to: arranging and merging multiple JS files into a single unified JS file.     
This process is important for browsers as it's not possible to initiate an HTTP request for every JS module.       
Bundler is a tool that generates dependency graph and create single bundle or multiple chunk files.    

## React
React is a library to build UI with use of Components.     
React separates concerns with loosely coupled units called “components” that contain both **rendering logic** and **UI logic**.     
React components are JavaScript functions that return markup.     

JSX is a syntax extension for JavaScript that lets you write HTML-like markup inside a JavaScript file.     
Embedding expressions in JSX: in *JSX* curly braces are used to escape back into JS.      
```jsx
const user = {
    imageUrl: 'http://localhost/q23err',
    name: 'sadeq',
    imageSize: 220
}
const element = <h1>Hello, world!</h1>;
const myUI = (
<>
<h2>{2+user.imageSize}</h2>
<img
    className="avatar"
    src={user.imageUrl}
    alt={'Photo of ' + user.name}
    style={{
        width: user.imageSize,
        height: user.imageSize
    }}
/>
</>
)
```

Babel compiles JSX down to React.createElement() calls.     
JSX turns into JavaScript and attributes written in JSX become keys of JavaScript objects.     
that's why we should use *className* instead of *class*.     
```js
const element = React.createElement(
  'h1',
  {className: 'greeting'},
  'Hello, world!'
);
```
These objects are called “React elements”.
React considers `false`, `null`, `undefined` as a “hole” in the JSX tree, and doesn’t render anything in its place.

**Props** are React Components' inputs. *props* are like HTML attributes, but you can pass any JavaScript value through them, including objects, arrays, and functions.[^1]     
> When React sees an element representing a user-defined component,     
> it passes JSX attributes and children to this component as a single object.     
> We call this object “props”.

```jsx
// the following function input syntax is called destructuring
function MyButton({prop1,prop2}){
    return (
        <button name={prop2('f')} />
    )
}
export default function Component(props){
    return (
        <MyButton prop1={2+2} prop2={(s)=> props.name+s} />
    );
}
```

> [!WARNING]
> Note: Always start component names with a capital letter.     
> React treats components starting with lowercase letters as DOM tags.

In legacy React, Components could also be an ES6 class.     
```jsx
class Welcome extends React.Component {
  render() {
    return <h1>Hello, {this.props.name}</h1>;
  }
}
```

**React Hooks**     
Functions starting with `use` are called Hooks. `useState` and `useEffect` are built-in Hooks provided by React.       
You can only call Hooks at the top of your components (or other Hooks).
> Hooks let you use more of React’s features without classes.



## References
- [node.js modules support](https://nodejs.org/api/esm.html)
- [node.js commonjs module](https://nodejs.org/api/modules.html)
- [native ES modules](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules)
- [node.js module wrapper](https://nodejs.org/api/modules.html#the-module-wrapper)
- [npm packages and modules](https://docs.npmjs.com/about-packages-and-modules)
- [npm package json](https://docs.npmjs.com/creating-a-package-json-file)
- [npm package-lock](https://docs.npmjs.com/cli/v10/configuring-npm/package-lock-json)
- [js prototype](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/Object_prototypes)
- [webpack bundler github](https://github.com/webpack/webpack)
- [react legacy jsx](https://legacy.reactjs.org/docs/introducing-jsx.html)
- [react jsx](https://react.dev/learn/writing-markup-with-jsx)
- [react doc](https://react.dev/learn)
- [react props](https://legacy.reactjs.org/docs/components-and-props.html)
- [react hooks](https://legacy.reactjs.org/docs/hooks-overview.html)
- [js destructuring](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment#Unpacking_fields_from_objects_passed_as_a_function_parameter)

[1^]: The destructuring assignment syntax is a JavaScript expression that makes it possible     
to unpack values from arrays, or properties from objects, into distinct variables.