## Apache Maven
- Has a three built-in biuld lifecycles 
	- default
	- clean
	- site
- each life-cycle comprises sequence of phases.
- for example default build lifecycle phases:
	- validate
	- compile
	- test
	- package
	- verify
	- install
	- deploy
- each phase bundled with zero or more goals
- in maven goal is a smallest unit of work
- each goal belong to one plugin which illustrated as bellow
```
plugin:goal
e.g.
mvn help:effective-pom
mvn clean dependency:copy-dependencies
``` 
### POM
##### POM stands for "Project Object Model" .It is an XML representation of a `Maven project` held in a file named *pom.xml* .It is an XML file that contains information about the project and configuration details used by Maven to build the project. like OOP , pom files support inheritance . the parent of all pom files is `super-pom` which has a default configurations .
>*maven project* could be a single pom.xml file without any other file
> e.g parent-pom that has a packaging type *pom*


> Each packaging ( "jar","war","ear","pom" )  contains a list of goals to bind to a particular phase
> For example A project that is purely metadata (packaging value is pom) only binds goals to the `install` and `deploy` phases 

- super-pom
- effective-pom
- parent-pom
- aggregate-pom
