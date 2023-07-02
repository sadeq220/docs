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
In the following code we retrieve the root object field value called "id"   
Using the `EvaluationContext` is the mechanism to use if the root object is unlikely to change, it can simply be set once in the evaluation context.
>The more common usage of SpEL is to provide an expression string that is evaluated against a specific object instance (called the root object).
```java
public class SpELTest {
    @Test
    public void Test_SpEL_Against_Context() {
        Integer testingId = 99;
        SpELContextModel spELContextModel = new SpELContextModel(testingId, "Sadeq Safdari", null); // context model field may be public or has a getter to work
        StandardEvaluationContext standardEvaluationContext = new StandardEvaluationContext(spELContextModel);

        SpelExpressionParser spelExpressionParser = new SpelExpressionParser();
        Expression expression = spelExpressionParser.parseExpression("id");
        Object expressionResult = expression.getValue(standardEvaluationContext);

        Assertions.assertEquals(expressionResult, testingId);
    }

    private static class SpELContextModel {
        private Integer id;
        public String name;
        public Long code;

        public SpELContextModel(Integer id, String name, Long code) {
            this.id = id;
            this.name = name;
            this.code = code;
        }

        public Integer getId() {
            return id;
        }
    }
}
```
By default, SpEL uses the conversion service available in Spring core (org.springframework.core.convert.ConversionService) .
ConversionService is a spring replacement of legacy PropertyEditors from Java EE specification.

