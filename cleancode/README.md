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