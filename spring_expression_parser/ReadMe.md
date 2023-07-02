# spring expression parsers
every expression used in spring annotations like `@Scheduled(cron="~")` or `@Value("#{~}")`
has a corresponding Bean in Ioc container which is responsible for parsing and compiling an expression .

The following code introduces the **SpEL API to evaluate the arithmetic expression.**

```java
public class SpELTest {
    @Test
    public void Test_SpEL_parser_Bean(){
        SpelExpressionParser spelExpressionParser = new SpelExpressionParser();
        SpelExpression spelExpression = spelExpressionParser.parseRaw("5*12");
        spelExpression.compileExpression();  // SpEL: unable to compile (5 * 12)
        Object resultOfExpression = spelExpression.getValue();
        Assertions.assertEquals(resultOfExpression,Integer.valueOf(60));
    }
}
```
SpEL supports a wide range of features, such as calling methods, accessing properties, and calling constructors.
> The language syntax is similar to Unified EL but offers additional features,   
> most notably method invocation and basic string templating functionality.
```Java
class SpELParser {

    public static void main(String[] args) {
        ExpressionParser parser = new SpelExpressionParser();
        Expression exp = parser.parseExpression("'Hello World'.concat('!')");
        String message = (String) exp.getValue();
    }
}
```

By default, SpEL uses the conversion service available in Spring core (org.springframework.core.convert.ConversionService) .
ConversionService is a spring replacement of legacy PropertyEditors from Java EE specification.

