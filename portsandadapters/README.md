### Ports and Adapters architecture

Ports and Adapters architecture(aka Hexagonal architecture) coined by Dr. Alister Cockburn.    
This architecture main idea is to separate `business domain` from its dependencies on `technical infrastructure`.    
As GOOS book clearly defines this architecture:     
> The code for the business domain is isolated from its dependencies on technical infrastructure, such as databases and user interfaces.    
>We don’t want technical concepts to leak into the application model,    
>so we write interfaces to describe its relationships with the outside world in its terminology(Cockburn’s ports).     
>Then we write bridges between the application core and each technical domain (Cockburn’s adapters).      
>This is related to what Eric Evans calls an “anticorruption layer”   

Exercising this architecture leads to `easy to test` and `maintainable` application.    
maintainability: easy to modify and easy to understand.it is a long term concern.     
maintainability is achieved by well-designed classes(**loosely coupled and highly cohesive**)

This architecture utilizes two principal heuristics:   
- Separation of concerns
  - gather together code that will change for the same reason in an isolated package.
- Higher levels of abstraction
    - avoid complexities

This architecture depicts the application as a **closed area**. The closed area is a hexagon(chosen by Alister Cockburn).    
The hexagon is the application core surrounded by ports(**interfaces**) which are facets of the hexagon.    
Ports are the intention of a dialog, and **establish a clear boundary** between application core and its dependencies on technical infrastructure.    

### References
- [GOOS book](https://www.amazon.com/Growing-Object-Oriented-Software-Guided-Tests/dp/0321503627)
- [Alister describing hexagonal architecture](https://www.youtube.com/watch?v=th4AgBcrEHA)
- [summary of Dr. Alister speeches](https://jmgarridopaz.github.io/content/hexagonalarchitecture.html)