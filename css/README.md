### Css and HTML 
CSS building blocks include:    
- normal flow(inline and block display)
  - `display: inline`, `display: block`
- box model(content-box, border-box, padding, margin)
  - `box-sizing: content-box`, `box-sizing: border-box`
- css layout(normal flow, flex, grid)
  -  `display: flex`, `display: grid`
- css cascade layers(wining property value by origin precedence and layer precedence)
  - > cascade layers enable us to create sub-origin level of priority within any of those origins.
  - `@layer at-rule;`
### Css layouts
default layout is normal flow. elements stack on top each other.    
use Flexbox to lay things out in one dimension. `display: flex`         
Grid Layout is designed for two dimensions. `dispaly: grid`    
use Float to wrap an element with text.`float: left`    
> A floated element is taken out of normal flow      
> and the boxes of the following items actually run behind the float

Positioning lets you fix an element position relative to the browser viewport, or other element.`position: fixed`     
Absolute and fixed Positioning remove an element from the normal flow completely.     

### Responsive web design (RWD)
> Responsive web design (RWD) is a web design approach to make web pages render well on all screen sizes and resolutions.

Before RWD, this approach was called mobile web design, mobile web development, or sometimes, mobile-friendly design.    
RWD is a `design approach` that contains best practices to create a layout that can respond to any device screen.    
features to use when creating responsive sites:    
- media query (@media)
  - To conditionally apply styles based on the specific characteristics of a given user agent
- flexible grids
  - to specify columns' properties(e.g. column count, column width)

### References
- [building blocks of CSS](https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks)    
- [CSS layout](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Introduction)
- [CSS layout float](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Floats)
- [mozilla RWD](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design)