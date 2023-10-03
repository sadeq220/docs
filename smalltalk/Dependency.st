Object subclass: Customer [
    | name |
    
    Customer class >> new: aName [
        ^self new initialize: aName.
    ]
    
    initialize: aName [
        name := aName.
    ]
    
    getName [
        ^name.
    ]
]

Object subclass: Order [
    | orderNumber customer |
    
    Order class >> new: aNumber customer: aCustomer [
        ^self new initialize: aNumber customer: aCustomer.
    ]
    
    initialize: aNumber customer: aCustomer [
        orderNumber := aNumber.
        customer := aCustomer.
    ]
    
    getOrderNumber [
        ^orderNumber.
    ]
    
    getCustomer [
        ^customer.
    ]

    getCustomerName [
	^customer getName.
    ]
    "override printString method inherited from Object class to provide custom string representation"
    printString [
        ^'Order Number: ', orderNumber printString, ', Customer: ', customer getName.
    ]
]

"Usage Example"
| customer order |
customer := Customer new: 'Alan'.
order := Order new: 123 customer: customer.

Transcript show: order printString; cr.
