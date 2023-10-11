Object subclass: MyClass [
    "Class-side pool declaration and initialization method"
    MyClass class >> initializeMyPool [
        ^MyPool := { 'Item1'. 'Item2'. 'Item3' } asSet.
    ]

    "Instance method to add an item to the pool"
    MyClass >> addItemToPool: newItem [
        MyPool add: newItem.
    ]

    "Instance method to print all items in the pool"
    MyClass >> printPoolItems [
        MyPool do: [ :each | Transcript show: each; cr. ].
    ]


    "MyClass class initialization"
    MyClass class >> initialize [
    self initializeMyPool.
    ]

]
MyClass initialize.
"Usage Example"
| object1 object2 |
object1 := MyClass new.
object1 addItemToPool: 'object1'.
object1 printPoolItems.
Transcript show: '-----------';cr.
object2 := MyClass new.
object2 addItemToPool: 'object2'.
object2 printPoolItems.
