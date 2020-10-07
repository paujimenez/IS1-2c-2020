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
	instanceVariableNames: 'stackWithZeroStrings stackWithOneString stackWithTwoStrings stackWithThreeStrings'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PGTA 10/6/2020 20:55:34'!
setUp
	
	stackWithZeroStrings := OOStack new.
	
	stackWithOneString := OOStack new.
	stackWithOneString push: 'Paula'.
	
	stackWithTwoStrings := OOStack new.
	stackWithTwoStrings push: 'Paula'.
	stackWithTwoStrings push: 'Pablo'.
	
	stackWithThreeStrings := OOStack new.
	stackWithThreeStrings push: 'Paula'.
	stackWithThreeStrings push: 'Pablo'.
	stackWithThreeStrings push: 'Juan'.
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PGTA 10/6/2020 21:00:19'!
test01FinderByPrefixReturnsEmptyCollectionIfPrefixNotFound
	
	|finder prefix searchResults|
	
	finder := SentenceFinderByPrefix new.
	prefix := 'Ra'.
	
	searchResults := finder find: prefix in: stackWithThreeStrings.
	
	self assert: searchResults isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PGTA 10/6/2020 21:07:11'!
test02FinderByPrefixReturnsAllStackStringsWithFoundPrefix
	
	|finder prefix searchResults expectedResult|
	
	expectedResult := OrderedCollection with: 'Paula' with: 'Pablo'.
	
	finder := SentenceFinderByPrefix new.
	prefix := 'Pa'.
	
	searchResults := finder find: prefix in: stackWithThreeStrings.
	
	self assert: searchResults = expectedResult.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PGTA 10/6/2020 21:08:01'!
test03FinderByPrefixIsCaseSensitive
	
	|finder prefix searchResults|
	
	finder := SentenceFinderByPrefix new.
	prefix := 'pa'.
	
	searchResults := finder find: prefix in: stackWithThreeStrings.
	
	self assert: searchResults isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PGTA 10/6/2020 21:09:33'!
test04FinderByPrefixLeavesStackUnchanged
	
	|finder prefix searchResults|
	
	finder := SentenceFinderByPrefix new.
	prefix := 'pa'.
	
	searchResults := finder find: prefix in: stackWithThreeStrings.
	
	self assert: searchResults isEmpty.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'stackOperations' stamp: 'PJ 10/5/2020 22:22:53'!
pop

	^elements last popMe: self.! !

!OOStack methodsFor: 'stackOperations' stamp: 'PJ 10/5/2020 22:23:13'!
push: anObject

	elements addLast: (OOStackElementContainer with: anObject).! !

!OOStack methodsFor: 'stackOperations' stamp: 'PJ 10/5/2020 22:30:09'!
top

	^elements last value.! !


!OOStack methodsFor: 'initialization' stamp: 'PJ 10/5/2020 22:28:35'!
initialize
	elements := OrderedCollection with: OOStackBase new.! !


!OOStack methodsFor: 'privateStackOperations' stamp: 'PJ 10/5/2020 22:25:54'!
safeRemoveTop

	^elements removeLast.! !


!OOStack methodsFor: 'comparing' stamp: 'PJ 10/5/2020 22:28:49'!
isEmpty

	^elements size = 1! !

!OOStack methodsFor: 'comparing' stamp: 'PJ 10/5/2020 22:29:20'!
size

	^elements size - 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'PJ 10/4/2020 16:53:28'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #OOStackElements category: 'Stack-Exercise'!
Object subclass: #OOStackElements
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElements methodsFor: 'initialization' stamp: 'PJ 10/5/2020 22:30:45'!
initializeWith: anObject

	self subclassResponsibility ! !


!OOStackElements methodsFor: 'stackElementOperations' stamp: 'PJ 10/5/2020 22:31:26'!
popMe: aStack

	self subclassResponsibility ! !

!OOStackElements methodsFor: 'stackElementOperations' stamp: 'PJ 10/5/2020 22:31:55'!
value

	self subclassResponsibility ! !


!classDefinition: #OOStackBase category: 'Stack-Exercise'!
OOStackElements subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'stackElementOperations' stamp: 'PJ 10/5/2020 17:42:50'!
popMe: aStack

	^self error: OOStack stackEmptyErrorDescription! !

!OOStackBase methodsFor: 'stackElementOperations' stamp: 'PJ 10/4/2020 22:25:22'!
value
	^self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #OOStackElementContainer category: 'Stack-Exercise'!
OOStackElements subclass: #OOStackElementContainer
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElementContainer methodsFor: 'initialization' stamp: 'PJ 10/4/2020 22:28:23'!
initializeWith: anObject
	value := anObject ! !


!OOStackElementContainer methodsFor: 'stackElementOperations' stamp: 'PJ 10/5/2020 22:31:03'!
popMe: aStack

	aStack safeRemoveTop.
	^value! !

!OOStackElementContainer methodsFor: 'stackElementOperations' stamp: 'PJ 10/5/2020 22:31:33'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElementContainer class' category: 'Stack-Exercise'!
OOStackElementContainer class
	instanceVariableNames: ''!

!OOStackElementContainer class methodsFor: 'as yet unclassified' stamp: 'PJ 10/4/2020 22:27:48'!
with: anObject
	^self basicNew initializeWith: anObject ! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'PJ 10/6/2020 20:31:09'!
find: aPrefix in: aStack

	|findResults sentence |
	
	aStack isEmpty ifTrue: [^OrderedCollection new]
		ifFalse: [
			sentence := aStack pop.
			findResults := self find: aPrefix in: aStack.
			(sentence beginsWith: aPrefix) ifTrue: [findResults add: sentence].
			aStack push: sentence.
			^findResults
		]
	
	! !
