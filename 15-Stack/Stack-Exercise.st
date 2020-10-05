!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'PJ 10/4/2020 16:50:14'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'PJ 10/4/2020 16:50:20'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'PJ 10/4/2020 17:57:12'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'PJ 10/4/2020 20:22:27'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'PJ 10/4/2020 16:52:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'PJ 10/4/2020 17:32:15'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'PJ 10/4/2020 17:53:15'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'PJ 10/4/2020 18:15:00'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'PJ 10/4/2020 18:01:56'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'stackOperations' stamp: 'PJ 10/4/2020 18:41:21'!
pop
	self subclassResponsibility ! !

!OOStack methodsFor: 'stackOperations' stamp: 'PJ 10/4/2020 18:42:15'!
push: anObject
	self subclassResponsibility ! !

!OOStack methodsFor: 'stackOperations' stamp: 'PJ 10/4/2020 18:49:11'!
top
	self subclassResponsibility ! !



!OOStack methodsFor: 'comparing' stamp: 'PJ 10/4/2020 18:29:45'!
isEmpty
	self subclassResponsibility! !

!OOStack methodsFor: 'comparing' stamp: 'PJ 10/4/2020 18:45:39'!
size
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'PJ 10/4/2020 19:52:31'!
new
	^EmptyOOStack basicNew! !

!OOStack class methodsFor: 'error descriptions' stamp: 'PJ 10/4/2020 16:53:28'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #EmptyOOStack category: 'Stack-Exercise'!
OOStack subclass: #EmptyOOStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyOOStack methodsFor: 'as yet unclassified' stamp: 'PJ 10/4/2020 18:30:03'!
isEmpty
	^true! !

!EmptyOOStack methodsFor: 'as yet unclassified' stamp: 'PJ 10/4/2020 18:40:36'!
pop
	^self error: self class stackEmptyErrorDescription! !

!EmptyOOStack methodsFor: 'as yet unclassified' stamp: 'PJ 10/4/2020 20:53:53'!
push: anObject
	
	^OOStackWithAtLeastOneElement with: anObject.! !

!EmptyOOStack methodsFor: 'as yet unclassified' stamp: 'PJ 10/4/2020 18:45:57'!
size
	^0.! !

!EmptyOOStack methodsFor: 'as yet unclassified' stamp: 'PJ 10/4/2020 18:49:30'!
top
	^self error: self class stackEmptyErrorDescription! !


!classDefinition: #OOStackWithAtLeastOneElement category: 'Stack-Exercise'!
OOStack subclass: #OOStackWithAtLeastOneElement
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackWithAtLeastOneElement methodsFor: 'initialization' stamp: 'PJ 10/4/2020 18:59:19'!
initializeWith: anObject
	elements := OrderedCollection with: anObject.! !


!OOStackWithAtLeastOneElement methodsFor: 'as yet unclassified' stamp: 'PJ 10/4/2020 18:32:26'!
isEmpty
	^elements isEmpty! !

!OOStackWithAtLeastOneElement methodsFor: 'as yet unclassified' stamp: 'PJ 10/4/2020 18:40:52'!
pop
	^elements removeLast.! !

!OOStackWithAtLeastOneElement methodsFor: 'as yet unclassified' stamp: 'PJ 10/4/2020 18:44:49'!
push: anObject
	elements addLast: anObject! !

!OOStackWithAtLeastOneElement methodsFor: 'as yet unclassified' stamp: 'PJ 10/4/2020 18:46:11'!
size
	^elements size.! !

!OOStackWithAtLeastOneElement methodsFor: 'as yet unclassified' stamp: 'PJ 10/4/2020 18:49:46'!
top
	^elements last! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackWithAtLeastOneElement class' category: 'Stack-Exercise'!
OOStackWithAtLeastOneElement class
	instanceVariableNames: ''!

!OOStackWithAtLeastOneElement class methodsFor: 'initialization' stamp: 'PJ 10/4/2020 20:19:52'!
with: anObject
	^self basicNew initializeWith: anObject ! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
