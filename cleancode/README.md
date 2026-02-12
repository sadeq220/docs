## Clean Code
This Document is the aggregation of best practices/principles and standards that are mentioned in reference books such as:    
- Refactoring by *Martin Fowler*
- Clean Code by *Robert C. Martin*
- Effective Java by *Joshua Bloch*

### nested blocks and return early
**Avoid deep nesting**:    
Robert C. Martin repeatedly emphasizes reducing indentation and flattening control structures, which naturally leads to `early returns`.    
Uncle Bob calls this “guard clauses”, which is essentially early return usage.
```Java
/**
 * bad written function with nested blocks and high indentation
 */
private void badProcessUser(User user) {
    if (user != null){
        if (user.isActive())
            process(user);
    }
}
/**
 * clean method with early returns
 */
private void processUser(User user) {
    if (user == null) return;
    if (!user.isActive()) return;
    process(user);
}
```
**Replace Nested Conditional with Guard Clauses**:    
From Refactoring 2nd Edition:   
> Replace Nested Conditional with Guard Clauses.  
> “Use guard clauses for special cases and return early.”

```js
/**
 *  bad written code
 */
if (isValid) {
    if (hasPermission) {
        doWork();
    }
}
/**
 * use early returns and guard cluases
 */
if (!isValid) return;
if (!hasPermission) return;

doWork();

```

### Abstract class as Template Method design pattern
Interface should only define the public surface. And Abstract class should govern and control the rules and policies.    
`protected` and `final` are true powers in Abstract classes to define policy/rule enforcements.    
In a nutshell, Abstract class define a protocol. They can:   
- Control method visibility
- Enforce call order
- Prevent misuse
- Encode invariants

```java
public abstract class AbstractQuoteFetcher {
    /**
     * public accessible api
     * compatible with DIP
     */
    public final QuoteValue fetch(Lead lead) {
        doBefore(lead);
        return doFetch(lead);
    }

    protected void doBefore(Lead lead) {
        // shared logic (logging, validation, auth, metrics, etc.)
    }

    protected abstract QuoteValue doFetch(Lead lead);
}
```

> Interfaces are for variation.     
> Abstract classes are for invariants.    
> Invariants are The parts of the system that must never change if the system is correct.

