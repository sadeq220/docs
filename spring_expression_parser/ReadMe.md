# spring expression parsers
every expression used in spring annotations like `@Scheduled(cron='~')` or `@Value("#{~})`
has a corresponding Bean in Ioc container which is responsible for parsing and compiling an expression .

The following code introduces the **SpEL API to evaluate the arithmetic expression.**

```java
class ExpressionParser {
    
    public static void main(String[] args) {
        SpelExpressionParser spelExpressionParser = new SpelExpressionParser();
        SpelExpression spelExpression = spelExpressionParser.parseRaw("5*17");
        spelExpression.compileExpression();
        System.out.println(spelExpression.getValue());
        CronSequenceGenerator cronSequenceGenerator = new CronSequenceGenerator("0 */30 * * * ?");
        Date next = cronSequenceGenerator.next(new Date());
        System.out.println(next);
    }
}
```
SpEL supports a wide range of features, such as calling methods, accessing properties, and calling constructors.
```Java
class SpELParser {

    public static void main(String[] args) {
        ExpressionParser parser = new SpelExpressionParser();
        Expression exp = parser.parseExpression("'Hello World'.concat('!')");
        String message = (String) exp.getValue();
    }
}
```

