### CI/CD (Continuous Integration and Continuous Delivery)     
CI/CD falls under DevOps (the joining of development and operations teams).     

CI/CD is the critical part of TDD(Test Driven Development) and TDD is a core practice of Extreme Programming (XP) [Kent Beck].      
We’ve used TDD on every agile project we’ve been involved in, and have found uses for it in non-agile projects.     
     
CI/CD automates build, test (including integration tests, unit tests, and regression tests), and deploy phases, as well as infrastructure provisioning.     

Continuous Integration: Is the practice of integrating all your code changes into the main branch of a shared source code repository early and often,     
Nowadays, it is typically implemented in such a way that it triggers an automated build with testing.     
- to minimize the possibility of merge conflict     
- to fix bugs early

Continuous Delivery: automate the infrastructure provisioning and application release process.     

### References
- [gitlab ci-cd doc](https://about.gitlab.com/topics/ci-cd/)
- [redhat ci-cd doc](https://www.redhat.com/en/topics/devops/what-is-ci-cd)
- [GOOS book](https://www.amazon.com/Growing-Object-Oriented-Software-Guided-Tests/dp/0321503627)