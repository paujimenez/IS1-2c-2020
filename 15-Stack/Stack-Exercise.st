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

!OOStackTest methodsFor: 'test' stamp: 'PJ 10/4/2020 23:08:46'!
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

!OOStack class methodsFor: 'error descriptions' stamp: 'PJ 10/5/2020 18:10:57'!
new
	^OOStackElements basicNew initialize! !

!OOStack class methodsFor: 'error descriptions' stamp: 'PJ 10/4/2020 16:53:28'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #OOStackBase category: 'Stack-Exercise'!
OOStack subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'privateStackOperations' stamp: 'PJ 10/5/2020 17:42:50'!
popMe: aStack

	^self error: OOStack stackEmptyErrorDescription! !

!OOStackBase methodsFor: 'privateStackOperations' stamp: 'PJ 10/4/2020 22:25:22'!
value
	^self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #OOStackElementContainer category: 'Stack-Exercise'!
OOStack subclass: #OOStackElementContainer
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElementContainer methodsFor: 'initialization' stamp: 'PJ 10/4/2020 22:28:23'!
initializeWith: anObject
	value := anObject ! !


!OOStackElementContainer methodsFor: 'privateStackOperations' stamp: 'PJ 10/5/2020 17:58:06'!
popMe: aStack

	"|currentTop|
	currentTop := value."
	aStack safeRemoveTop.
	^value! !

!OOStackElementContainer methodsFor: 'privateStackOperations' stamp: 'PJ 10/4/2020 22:23:00'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElementContainer class' category: 'Stack-Exercise'!
OOStackElementContainer class
	instanceVariableNames: ''!

!OOStackElementContainer class methodsFor: 'as yet unclassified' stamp: 'PJ 10/4/2020 22:27:48'!
with: anObject
	^self basicNew initializeWith: anObject ! !


!classDefinition: #OOStackElements category: 'Stack-Exercise'!
OOStack subclass: #OOStackElements
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElements methodsFor: 'initialization' stamp: 'PJ 10/5/2020 18:01:14'!
initialize
	elements := OrderedCollection new.
	elements add: OOStackBase basicNew.! !


!OOStackElements methodsFor: 'stackOperations' stamp: 'PJ 10/5/2020 17:58:54'!
pop

	^elements last popMe: self.! !

!OOStackElements methodsFor: 'stackOperations' stamp: 'PJ 10/5/2020 18:11:39'!
push: anObject

	elements addLast: (OOStackElementContainer with: anObject).! !

!OOStackElements methodsFor: 'stackOperations' stamp: 'PJ 10/5/2020 17:47:16'!
top
	^elements last value.! !


!OOStackElements methodsFor: 'comparing' stamp: 'PJ 10/5/2020 17:36:01'!
isEmpty
	^elements size = 1! !

!OOStackElements methodsFor: 'comparing' stamp: 'PJ 10/5/2020 17:46:39'!
size
	^elements size - 1.! !


!OOStackElements methodsFor: 'privateStackOperations' stamp: 'PJ 10/5/2020 17:44:43'!
safeRemoveTop

	^elements removeLast.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
