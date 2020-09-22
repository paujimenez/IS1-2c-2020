!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'pj 9/21/2020 21:33:23'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| differenceInMilliseconds customerBookTest |
	customerBookTest := CustomerBook new.
	
	differenceInMilliseconds := self measureCustomerBookTimeFrom: customerBookTest byDoingAction: [:customerBook | customerBook addCustomerNamed: 'John Lennon'.].
	 
	self assert: differenceInMilliseconds < (50 * millisecond)
	
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pj 9/21/2020 21:34:20'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| differenceInMilliseconds paulMcCartney customerBookTest |
	
	paulMcCartney  := 'Paul McCartney'.
	customerBookTest := self createCustomerBookAndAddActiveClient: paulMcCartney.
	
	differenceInMilliseconds := self measureCustomerBookTimeFrom: customerBookTest byDoingAction: [:customerBook | customerBook removeCustomerNamed: paulMcCartney.].
	
	self assert: differenceInMilliseconds < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pj 9/21/2020 19:51:05'!
test03CanNotAddACustomerWithEmptyName 
	| customerBook |
	customerBook := CustomerBook new.
	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pj 9/21/2020 21:37:19'!
test04CanNotRemoveAnInvalidCustomer

	| customerBook johnLennon |
	johnLennon := 'John Lennon'.
	customerBook := self createCustomerBookAndAddActiveClient: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pj 9/21/2020 19:33:42'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self createCustomerBookAndAddActiveClient: paulMcCartney .
	
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pj 9/21/2020 19:34:28'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self createCustomerBookAndAddActiveClient: paulMcCartney .
	
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pj 9/21/2020 19:35:31'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.		
	customerBook := self createCustomerBookAndAddActiveClient: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'George Harrison'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'pj 9/21/2020 19:36:10'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.		
	customerBook := self createCustomerBookAndAddActiveClient: johnLennon.
	
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'helperMethods' stamp: 'pj 9/21/2020 19:28:06'!
createCustomerBookAndAddActiveClient: aName

	| customerBook |
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aName.
	^customerBook ! !

!CustomerBookTest methodsFor: 'helperMethods' stamp: 'pj 9/21/2020 21:31:06'!
measureCustomerBookTimeFrom: customerBook byDoingAction: actionToPerform

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	actionToPerform value: customerBook.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning)! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'pj 9/21/2020 20:27:25'!
customerCanBeSuspended: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].! !

!CustomerBook methodsFor: 'testing' stamp: 'pj 9/21/2020 20:28:02'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'pj 9/21/2020 20:31:00'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !

!CustomerBook methodsFor: 'testing' stamp: 'pj 9/21/2020 20:20:26'!
validateIsNotInCustomerBook: aName
	(self includesCustomerNamed: aName ) ifTrue: [ self signalCustomerAlreadyExists ].! !

!CustomerBook methodsFor: 'testing' stamp: 'pj 9/21/2020 20:16:14'!
validateNameIsNotEmpty: aName
	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].! !

!CustomerBook methodsFor: 'testing' stamp: 'pj 9/21/2020 20:23:05'!
validateNewCustomerName: aName
	self validateNameIsNotEmpty: aName.
	self validateIsNotInCustomerBook: aName.! !


!CustomerBook methodsFor: 'initialization' stamp: 'pj 9/21/2020 20:30:34'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'signals' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signals' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !


!CustomerBook methodsFor: 'customer management' stamp: 'pj 9/21/2020 20:22:34'!
addCustomerNamed: aName

	self validateNewCustomerName: aName.
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'pj 9/21/2020 20:32:13'!
removeCustomerFrom: aCollection customerNamed: aName 
 
	1 to: aCollection size do: 
	[ :index |
		aName = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				^true 
			] 
	].
	
	^false! !

!CustomerBook methodsFor: 'customer management' stamp: 'pj 9/21/2020 20:57:44'!
removeCustomerNamed: aName 

 	| activeRemoveSuccess suspendedRemoveSuccess |
	
	activeRemoveSuccess := self removeCustomerFrom: active customerNamed: aName.
	activeRemoveSuccess ifTrue:[^aName].
	
	suspendedRemoveSuccess := self removeCustomerFrom: suspended customerNamed: aName.
	suspendedRemoveSuccess ifTrue:[^aName].
	
	^ NotFound signal.! !

!CustomerBook methodsFor: 'customer management' stamp: 'pj 9/21/2020 21:24:39'!
suspendCustomerNamed: aName 

	self customerCanBeSuspended: aName.
	self suspendExistentCustomerNamed: aName.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'pj 9/21/2020 21:24:17'!
suspendExistentCustomerNamed: aName 
	
	active remove: aName.
	suspended add: aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:01:49'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:02:05'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'! !
