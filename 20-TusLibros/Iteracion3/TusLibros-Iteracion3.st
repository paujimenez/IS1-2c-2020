!classDefinition: #CartTest category: 'TusLibros-Iteracion3'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'PJ 11/29/2020 18:48:23'!
test09CartDoesntAddAnyItemsIntoTheListWhenItIsEmpty

	| cart cartList|
	
	cart := testObjectsFactory createCart.
	cartList := OrderedCollection new.
	
	cart addItemsWithQuantityTo: cartList.
	self assert: cartList isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'PJ 11/29/2020 19:06:16'!
test10CartAddsItsItemsIntoTheListWhenItIsNotEmpty

	| cart cartList bookIsbn1 bookIsbn2|
	
	cartList := OrderedCollection new.
	cart := testObjectsFactory createCart.
	bookIsbn1 := testObjectsFactory itemSellByTheStore.
	bookIsbn2 := testObjectsFactory secondItemSellByTheStore.
	
	cart add: 3 of: bookIsbn1.
	cart add: 6 of: bookIsbn2.
	cart add: 2 of: bookIsbn1.
	
	cart addItemsWithQuantityTo: cartList.
	
	self assert: 4 equals: cartList size.
	
	self assert: bookIsbn1 equals: (cartList at: 1).
	self assert: 5 equals: (cartList at: 2).
	
	self assert: bookIsbn2 equals: (cartList at: 3).
	self assert: 6 equals: (cartList at: 4).! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros-Iteracion3'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'PJ 11/29/2020 20:05:17'!
test04CheckoutRegistersASale

	| cart cashier salesBook total cartList|

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 	cartList := OrderedCollection new.
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
	cart addItemsWithQuantityTo: cartList.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.
	self assert: salesBook first itemsSold = cartList.
	! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosInterfazTest category: 'TusLibros-Iteracion3'!
TestCase subclass: #TusLibrosInterfazTest
	instanceVariableNames: 'testObjectsFactory authenticateBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!TusLibrosInterfazTest methodsFor: 'setup' stamp: 'PJ 11/28/2020 17:14:04'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	authenticateBehavior := [:aClientId :aPassword|]! !


!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/28/2020 17:21:52'!
authenticate: aClientId password: aPassword 

	^authenticateBehavior value: aClientId value: aPassword ! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 17:45:37'!
test01_CannotCreateCartWithInvalidClient

	|tusLibros|

	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new.
	authenticateBehavior := [:aClientId :aPassword| self error: TusLibrosInterface invalidClientErrorDescription ].
	
	self should: [tusLibros createCartWithClient: '1239' password: 'test1234']
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosInterface invalidClientErrorDescription.! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 17:45:37'!
test02_CannotCreateCartWithInvalidPassword

	|tusLibros|

	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new.
	authenticateBehavior := [:aClientId :aPassword| self error: TusLibrosInterface invalidPasswordErrorDescription].
	
	self should: [tusLibros createCartWithClient: '1239' password: 'invalid']
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosInterface invalidPasswordErrorDescription.! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 17:45:37'!
test03_InterfaceCanCreateACartAndIsEmpty

	|tusLibros cartId cartList| 

	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new.
	
	cartId := tusLibros createCartWithClient: '1239' password: 'test123'.
	cartList := tusLibros 	listCart: cartId.
	
	self assert: cartList isEmpty.
	! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 17:45:37'!
test04_InterfaceCannotListAnInvalidCartId

	|tusLibros cartId invalidCartId| 
	
	invalidCartId := 'invalid'.
	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new.
	
	cartId := tusLibros createCartWithClient: '1239' password: 'test123'.
	
	self assert: (cartId = invalidCartId) not.
	
	self should: [tusLibros 	listCart: invalidCartId]
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosInterface invalidCartIdErrorDescription.
	! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 17:45:37'!
test05_InterfaceCanCreateManyCarts

	|tusLibros cartId1 cartId2| 
	
	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new.
	
	cartId1 := tusLibros createCartWithClient: '1239' password: 'test123'.
	cartId2 := tusLibros createCartWithClient: '1238' password: 'test123'.
	
	self assert: (tusLibros 	listCart: cartId1) isEmpty.
	self assert: (tusLibros 	listCart: cartId2) isEmpty.
	! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 17:45:37'!
test06_InterfaceCanAddBooksIntoACartAndListThem

	|tusLibros cartId cartList bookIsbn| 
	
	bookIsbn := testObjectsFactory itemSellByTheStore.
	
	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new.
	
	cartId := tusLibros createCartWithClient: '1239' password: 'test123'.
	tusLibros addToCart: cartId isbn: bookIsbn quantity: 5.
	
	cartList := tusLibros 	listCart: cartId.
	
	self assert: 2 equals: cartList size.
	self assert: bookIsbn equals: (cartList at: 1).
	self assert: 5 equals: (cartList at: 2).	
	! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 17:45:37'!
test07_InterfaceCannotAddBooksIntoAnInvalidCart

	|tusLibros cartId bookIsbn invalidCartId|
	
	invalidCartId := 'invalid'. 
	
	bookIsbn := testObjectsFactory itemSellByTheStore.
	
	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new.
	
	cartId := tusLibros createCartWithClient: '1239' password: 'test123'.
	
	self assert: (invalidCartId = cartId) not.
	
	self should: [tusLibros addToCart: invalidCartId isbn: bookIsbn quantity: 5]
		raise: Error - MessageNotUnderstood 
		withMessageText: TusLibrosInterface invalidCartIdErrorDescription.
		
	self should: [tusLibros listCart: invalidCartId]
		raise: Error - MessageNotUnderstood 
		withMessageText: TusLibrosInterface invalidCartIdErrorDescription.
	
	! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 17:45:37'!
test08_InterfaceCannotCheckoutAnInvalidCart

	|tusLibros cartId bookIsbn invalidCartId|
	
	invalidCartId := 'invalid'. 
	
	bookIsbn := testObjectsFactory itemSellByTheStore.
	
	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new.
	
	cartId := tusLibros createCartWithClient: '1239' password: 'test123'.
	tusLibros addToCart: cartId isbn: bookIsbn quantity: 2.
	
	self assert: (invalidCartId = cartId) not.
	
	self should: [tusLibros checkoutCart: invalidCartId cardNumeber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez']
		raise: Error - MessageNotUnderstood 
		withMessageText: TusLibrosInterface invalidCartIdErrorDescription.
	
	! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 18:22:02'!
test09_InterfaceCannotCheckoutAnEmptyCart

	|tusLibros cartId|
	
	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new.
	
	cartId := tusLibros createCartWithClient: '1239' password: 'test123'.
	
	self should: [tusLibros checkoutCart: cartId cardNumeber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez']
		raise: Error - MessageNotUnderstood 
		withMessageText: TusLibrosInterface emptyCartErrorDescription.
	
	! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 18:20:55'!
test10_InterfaceSuccessfullyMakesASale

	|tusLibros cartId bookIsbn transactionId|
	
	bookIsbn := testObjectsFactory itemSellByTheStore.
	
	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new setUp.
	
	cartId := tusLibros createCartWithClient: '1239' password: 'test123'.
	tusLibros addToCart: cartId isbn: bookIsbn quantity: 2.
	
	transactionId := tusLibros checkoutCart: cartId cardNumeber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez'.
	
	self assert: transactionId isEmpty not.
	
	! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 20:26:00'!
test11_NewInterfaceHasNoSales

	|tusLibros purchaseList|
	
	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new setUp.
	
	purchaseList := 	tusLibros listPurchasesFor: '1234' password: 'test1234'.
	
	self assert: purchaseList isEmpty.! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 20:32:00'!
test12_CannotListPurchasesForAnInvalidClient

	|tusLibros |
	
	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new setUp.
	authenticateBehavior := [:aClientId :aPassword| self error: TusLibrosInterface invalidClientErrorDescription ].	
	
	self should: [tusLibros listPurchasesFor: '1234' password: 'test1234']
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosInterface invalidClientErrorDescription.! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 20:35:47'!
test13_CannotListPurchasesForAClientWithAnInvalidPassword

	|tusLibros |
	
	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new setUp.
	authenticateBehavior := [:aClientId :aPassword| self error: TusLibrosInterface invalidPasswordErrorDescription].	
	
	self should: [tusLibros listPurchasesFor: '1234' password: 'test1234']
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosInterface invalidPasswordErrorDescription .! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 20:55:17'!
test14_InterfaceCanListOneClientPurchase

	|tusLibros cartId bookIsbn purchaseList clientId password total quantity|
	
	clientId := '1239'.
	password := 'test123'.
	quantity := 2.
	bookIsbn := testObjectsFactory itemSellByTheStore.
	total := testObjectsFactory itemSellByTheStorePrice * quantity.
	
	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new setUp.
	
	cartId := tusLibros createCartWithClient: clientId password: password .
	tusLibros addToCart: cartId isbn: bookIsbn quantity: quantity.
	
	tusLibros checkoutCart: cartId cardNumeber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez'.
	
	purchaseList := tusLibros listPurchasesFor: clientId password: password.
	
	self assert: 3 equals: purchaseList size.
	self assert: bookIsbn equals: (purchaseList at: 1).
	self assert: quantity equals: (purchaseList at: 2).
	self assert: total equals: (purchaseList at: 3).
	! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 20:54:47'!
test15_InterfaceCanListMoreThanOnePurchaseFromAClient

	|tusLibros cartId bookIsbn purchaseList clientId password total quantity|
	
	self shouldBeImplemented.
	
	clientId := '1239'.
	password := 'test123'.
	quantity := 2.
	bookIsbn := testObjectsFactory itemSellByTheStore.
	total := testObjectsFactory itemSellByTheStorePrice * quantity.
	
	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new setUp.
	
	cartId := tusLibros createCartWithClient: clientId password: password .
	tusLibros addToCart: cartId isbn: bookIsbn quantity: quantity.
	
	tusLibros checkoutCart: cartId cardNumeber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez'.
	
	purchaseList := tusLibros listPurchasesFor: clientId password: password.
	
	self assert: 3 equals: purchaseList size.
	self assert: bookIsbn equals: (purchaseList at: 1).
	self assert: quantity equals: (purchaseList at: 2).
	self assert: total equals: (purchaseList at: 3).
	! !

!TusLibrosInterfazTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 20:55:54'!
test16_InterfaceCanListPurchasesFromMoreThanOneClient

	|tusLibros cartId bookIsbn purchaseList clientId password total quantity|
	
	self shouldBeImplemented.
	
	clientId := '1239'.
	password := 'test123'.
	quantity := 2.
	bookIsbn := testObjectsFactory itemSellByTheStore.
	total := testObjectsFactory itemSellByTheStorePrice * quantity.
	
	tusLibros := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new setUp.
	
	cartId := tusLibros createCartWithClient: clientId password: password .
	tusLibros addToCart: cartId isbn: bookIsbn quantity: quantity.
	
	tusLibros checkoutCart: cartId cardNumeber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez'.
	
	purchaseList := tusLibros listPurchasesFor: clientId password: password.
	
	self assert: 3 equals: purchaseList size.
	self assert: bookIsbn equals: (purchaseList at: 1).
	self assert: quantity equals: (purchaseList at: 2).
	self assert: total equals: (purchaseList at: 3).
	! !


!classDefinition: #Cart category: 'TusLibros-Iteracion3'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'PJ 11/28/2020 21:33:58'!
addItemsWithQuantityTo: anItemList
	items do: [:item |
		(anItemList includes: item) ifFalse: [
			anItemList add: item.
			anItemList add: (self occurrencesOf: item)
		]
	] 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Iteracion3'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros-Iteracion3'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'PJ 11/29/2020 20:12:57'!
createSale

	|cartList|
	
	cartList := OrderedCollection new.
	cart addItemsWithQuantityTo: cartList.
	
	^ Sale of: total withItems: cartList.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros-Iteracion3'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros-Iteracion3'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-Iteracion3'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: 'TusLibros-Iteracion3'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'PJ 11/29/2020 20:16:05'!
initializeTotal: aTotal withItems: aSoldItemsList 

	total := aTotal.
	items := aSoldItemsList.! !


!Sale methodsFor: 'as yet unclassified' stamp: 'PJ 11/29/2020 20:06:33'!
itemsSold
	^items copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros-Iteracion3'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'PJ 11/29/2020 20:14:40'!
of: aTotal withItems: aSoldItemsList 

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal withItems: aSoldItemsList ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros-Iteracion3'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'PJ 11/29/2020 19:00:24'!
secondItemSellByTheStore
	
	^ 'validBook2'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'PJ 11/29/2020 19:01:07'!
secondItemSellByTheStorePrice
	
	^25! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'PJ 11/29/2020 19:02:10'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self secondItemSellByTheStore put: self secondItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'interface' stamp: 'PJ 11/29/2020 17:45:46'!
createTusLibrosInterfaceWith: anAuthenticator andMerchant: aMerchantProcessor 
	
	^TusLibrosInterface withCatalog: self defaultCatalog authenticator: anAuthenticator merchantProcessor: aMerchantProcessor! !


!classDefinition: #TusLibrosInterface category: 'TusLibros-Iteracion3'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'catalog authenticator carts cartId salesBook merchantProcessor transactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!TusLibrosInterface methodsFor: 'initialization' stamp: 'PJ 11/29/2020 18:19:49'!
initializeWithCatalog: aCatalog authenticator: anAuthenticator merchantProcessor: aMerchantProcessor  
	
	catalog := aCatalog.
	authenticator := anAuthenticator.
	merchantProcessor := aMerchantProcessor.
	cartId := 0.
	transactionId := 0.
	carts := Dictionary new.
	salesBook := OrderedCollection new.! !


!TusLibrosInterface methodsFor: 'operations' stamp: 'PJ 11/29/2020 15:56:53'!
addToCart: aCartId isbn: aBookIsbn quantity: aBookQuantity
	
	|cart|
	[
		cart := carts at: aCartId.
		cart add: aBookQuantity of: aBookIsbn. 	
	]
	on: Error
 	do: [
		^self error: self class invalidCartIdErrorDescription.
	]
	
	! !

!TusLibrosInterface methodsFor: 'operations' stamp: 'PJ 11/29/2020 18:05:59'!
checkoutCart: aCartId cardNumeber: aCreditCardNumber expDate: anExpDate ownerName: aCreditCardOwner
	
	|cart cashier creditCard today|
	
	[cart := carts at: aCartId ]
	on: Error
	do: [^self error: self class invalidCartIdErrorDescription].
	
	creditCard := CreditCard expiringOn: (Month month: 5 year: 2025) "Change this!! anExpDate".
	
	[
	today := DateAndTime now.
	cashier := Cashier toCheckout: cart charging: creditCard throught: merchantProcessor on: today registeringOn: salesBook.
	]
	on: Error
	do: [^self error: self class emptyCartErrorDescription].
	
	cashier checkOut.
	
	^self transactionId
	! !

!TusLibrosInterface methodsFor: 'operations' stamp: 'PJ 11/28/2020 18:51:06'!
createCartWithClient: aClientId password: aPassword 
	
	|cart cartIdStr|
	authenticator authenticate: aClientId password: aPassword.
	
	cart := Cart acceptingItemsOf: catalog.
	cartId := cartId + 1.
	
	cartIdStr := cartId asString.
	carts at: cartIdStr put: cart.
	
	^cartIdStr.! !

!TusLibrosInterface methodsFor: 'operations' stamp: 'PJ 11/29/2020 16:05:00'!
listCart: aCartId
	|cart|
	
	[cart := carts at: aCartId]
	on: Error
	do: [^self error: self class invalidCartIdErrorDescription].
	
	^self listCartWithQuantity: cart.
	! !

!TusLibrosInterface methodsFor: 'operations' stamp: 'PJ 11/29/2020 20:33:58'!
listPurchasesFor: aClientId password: aPassword
	
	authenticator authenticate: aClientId password: aPassword.
	^OrderedCollection new.! !


!TusLibrosInterface methodsFor: 'private operations' stamp: 'PJ 11/29/2020 16:02:54'!
listCartWithQuantity: aCart
	|cartList|
	
	cartList := OrderedCollection new.
	aCart addItemsWithQuantityTo: cartList.
	^cartList.
	! !

!TusLibrosInterface methodsFor: 'private operations' stamp: 'PJ 11/29/2020 18:18:52'!
transactionId
	transactionId := transactionId + 1.
	^transactionId asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: 'TusLibros-Iteracion3'!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'instance creation' stamp: 'PJ 11/29/2020 18:08:22'!
withCatalog: aCatalog authenticator: anAuthenticator merchantProcessor: aMerchantProcessor 

	^self new initializeWithCatalog: aCatalog authenticator: anAuthenticator merchantProcessor: aMerchantProcessor ! !


!TusLibrosInterface class methodsFor: 'errors' stamp: 'PJ 11/29/2020 17:05:56'!
emptyCartErrorDescription
	^'Your cart is empty'! !

!TusLibrosInterface class methodsFor: 'errors' stamp: 'PJ 11/28/2020 18:19:10'!
invalidCartIdErrorDescription
	^'Invalid CartId'! !

!TusLibrosInterface class methodsFor: 'errors' stamp: 'PJ 11/28/2020 16:54:43'!
invalidClientErrorDescription
	^'Invalid Client'! !

!TusLibrosInterface class methodsFor: 'errors' stamp: 'PJ 11/28/2020 17:00:13'!
invalidPasswordErrorDescription
	^'Invalid Password'! !
