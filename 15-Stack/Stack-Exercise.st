!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'PGTA 10/8/2020 14:49:23'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'PGTA 10/8/2020 14:49:27'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'PGTA 10/8/2020 14:49:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'PGTA 10/8/2020 14:49:35'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'PGTA 10/8/2020 14:49:39'!
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

!OOStackTest methodsFor: 'test' stamp: 'PGTA 10/8/2020 14:49:44'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'PGTA 10/8/2020 14:49:48'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'PGTA 10/8/2020 14:49:52'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'PGTA 10/8/2020 14:49:56'!
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

!OOStackTest methodsFor: 'test' stamp: 'PGTA 10/8/2020 14:49:59'!
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
	instanceVariableNames: 'emptyStack stackWithOneString stackWithThreeStrings stackWithSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PGTA 10/8/2020 16:48:27'!
setUp
	
	emptyStack := OOStack new.
	
	stackWithOneString := OOStack new.
	stackWithOneString push: 'Paula'.
	
	stackWithThreeStrings := OOStack new.
	stackWithThreeStrings push: 'Paula'.
	stackWithThreeStrings push: 'Pablo'.
	stackWithThreeStrings push: 'Juan'.
	
	stackWithSentences := OOStack new.
	stackWithSentences push: 'winter is coming'.
	stackWithSentences push: 'winning is everything'.
	stackWithSentences push: 'The winds of Winter'.
	stackWithSentences push: 'Winter is here'.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PGTA 10/8/2020 14:50:14'!
test01FinderByPrefixReturnsEmptyCollectionIfPrefixNotFound
	
	|finder prefix searchResults|
	
	finder := SentenceFinderByPrefix new.
	prefix := 'Ra'.
	
	searchResults := finder find: prefix in: stackWithThreeStrings.
	
	self assert: searchResults isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PGTA 10/8/2020 14:50:18'!
test02FinderByPrefixReturnsAllStackStringsWithFoundPrefix
	
	|finder prefix searchResults expectedResult|
	
	expectedResult := OrderedCollection with: 'Paula' with: 'Pablo'.
	
	finder := SentenceFinderByPrefix new.
	prefix := 'Pa'.
	
	searchResults := finder find: prefix in: stackWithThreeStrings.
	
	self assert: searchResults = expectedResult.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PJ 10/8/2020 13:30:18'!
test03FinderByPrefixIsCaseSensitive
	
	|finder prefix searchResults|
	
	finder := SentenceFinderByPrefix new.
	prefix := 'pa'.
	
	searchResults := finder find: prefix in: stackWithThreeStrings.
	
	self assert: searchResults isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PJ 10/7/2020 20:00:42'!
test04FinderByPrefixLeavesStackUnchanged
	
	|finder prefix originalStackTop originalStackSize|
	
	originalStackTop := stackWithThreeStrings top.
	originalStackSize := stackWithThreeStrings size.
	
	finder := SentenceFinderByPrefix new.
	prefix := 'pa'.
	
	finder find: prefix in: stackWithThreeStrings.
	
	self assert: stackWithThreeStrings size = originalStackSize.
	self assert: stackWithThreeStrings top = originalStackTop.
	self assert: stackWithThreeStrings pop = 'Juan'.
	self assert: stackWithThreeStrings pop = 'Pablo'.
	self assert: stackWithThreeStrings pop = 'Paula'.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PJ 10/7/2020 20:19:57'!
test05FinderByPrefixReturnsAnErrorWhenPrefixIsNotAString
	
	|finder prefix|
	
	finder := SentenceFinderByPrefix new.
	prefix := 458.
	
	self should: [ finder find: prefix in: stackWithThreeStrings ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PJ 10/7/2020 20:25:44'!
test06FinderByPrefixReturnsAnErrorWhenPrefixIsEmpty
	
	|finder prefix|
	
	finder := SentenceFinderByPrefix new.
	prefix := ''.
	
	self should: [ finder find: prefix in: stackWithThreeStrings ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PJ 10/7/2020 20:26:50'!
test07FinderByPrefixReturnsAnErrorWhenPrefixHasSpaces
	
	|finder prefix|
	
	finder := SentenceFinderByPrefix new.
	prefix := 'J ua   n'.
	
	self should: [ finder find: prefix in: stackWithThreeStrings ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PJ 10/7/2020 20:41:23'!
test08FinderByPrefixReturnsEmptyCollectionIfPrefixIsSubstringButNotPrefix
	
	|finder prefix searchResults|
	
	finder := SentenceFinderByPrefix new.
	prefix := 'aula'.
	
	searchResults := finder find: prefix in: stackWithOneString.
	
	self assert: searchResults isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PJ 10/7/2020 21:02:46'!
test09FinderByPrefixReturnsAnErrorWhenTheInputIsNotAStack
	
	|finder prefix|
	
	finder := SentenceFinderByPrefix new.
	prefix := 'hola'.
	
	self should: [ finder find: prefix in: OrderedCollection new]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix notStackErrorDescription]! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PGTA 10/8/2020 16:48:19'!
test10FinderByPrefixReturnsEmptyCollectionIfStackIsEmpty
	
	|finder prefix searchResults|
	
	finder := SentenceFinderByPrefix new.
	prefix := 'Pa'.
	
	searchResults := finder find: prefix in: emptyStack.
	
	self assert: searchResults isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PJ 10/7/2020 21:53:35'!
test11FinderByPrefixReturnSentencesInWhichPrefixIsOnlyPrefixOfTheFirstWord
	
	|finder prefix searchResults|
	
	finder := SentenceFinderByPrefix new.
	prefix := 'Wint'.
	
	searchResults := finder find: prefix in: stackWithSentences.
	
	self assert: searchResults size = 1.
	self assert: searchResults last = 'Winter is here'.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'PJ 10/8/2020 13:45:28'!
test12FinderByPrefixReturnTheCollectionEvenIfTheStackContainsNonStringObjects
	
	|finder prefix searchResults|
	
	stackWithThreeStrings push: 4856.
	stackWithThreeStrings push: OOStack new.
	stackWithThreeStrings push: false.
	
	finder := SentenceFinderByPrefix new.
	prefix := 'Ju'.
	
	searchResults := finder find: prefix in: stackWithThreeStrings.
	
	self assert: searchResults size = 1.
	self assert: searchResults last = 'Juan'.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'stackOperations' stamp: 'PGTA 10/8/2020 14:58:26'!
pop

	^elements last popMeFrom: self.! !

!OOStack methodsFor: 'stackOperations' stamp: 'PGTA 10/8/2020 14:42:16'!
push: anObject

	elements addLast: (OOStackElementContainer with: anObject).! !

!OOStack methodsFor: 'stackOperations' stamp: 'PGTA 10/8/2020 15:46:50'!
top

	^elements last containedObject.! !


!OOStack methodsFor: 'initialization' stamp: 'PGTA 10/8/2020 15:45:03'!
initialize

	elements := OrderedCollection with: OOStackBase new.! !


!OOStack methodsFor: 'privateStackOperations' stamp: 'PGTA 10/8/2020 14:48:15'!
safeRemoveTop

	^elements removeLast.! !


!OOStack methodsFor: 'comparing' stamp: 'PJ 10/7/2020 19:07:40'!
isEmpty

	^self size = 0! !

!OOStack methodsFor: 'comparing' stamp: 'PJ 10/7/2020 19:13:00'!
size
	"elements always contains the base element which doesn't count as an element in the stack"
	^elements size - 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'PGTA 10/8/2020 14:44:27'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #OOStackElements category: 'Stack-Exercise'!
Object subclass: #OOStackElements
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!OOStackElements methodsFor: 'stackElementOperations' stamp: 'PGTA 10/8/2020 15:46:50'!
containedObject

	self subclassResponsibility ! !

!OOStackElements methodsFor: 'stackElementOperations' stamp: 'PGTA 10/8/2020 14:58:26'!
popMeFrom: aStack

	self subclassResponsibility ! !


!classDefinition: #OOStackBase category: 'Stack-Exercise'!
OOStackElements subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'stackElementOperations' stamp: 'PGTA 10/8/2020 15:46:50'!
containedObject

	^self error: OOStack stackEmptyErrorDescription! !

!OOStackBase methodsFor: 'stackElementOperations' stamp: 'PGTA 10/8/2020 14:58:26'!
popMeFrom: aStack

	^self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #OOStackElementContainer category: 'Stack-Exercise'!
OOStackElements subclass: #OOStackElementContainer
	instanceVariableNames: 'objectInside'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElementContainer methodsFor: 'initialization' stamp: 'PGTA 10/8/2020 15:48:27'!
initializeWith: anObject

	objectInside := anObject ! !


!OOStackElementContainer methodsFor: 'stackElementOperations' stamp: 'PGTA 10/8/2020 15:48:20'!
containedObject

	^objectInside ! !

!OOStackElementContainer methodsFor: 'stackElementOperations' stamp: 'PGTA 10/8/2020 15:48:16'!
popMeFrom: aStack

	aStack safeRemoveTop.
	^objectInside ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElementContainer class' category: 'Stack-Exercise'!
OOStackElementContainer class
	instanceVariableNames: ''!

!OOStackElementContainer class methodsFor: 'instance creation' stamp: 'PGTA 10/8/2020 15:38:42'!
with: anObject
	^self new initializeWith: anObject! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'privateFinderOperations' stamp: 'PJ 10/8/2020 13:36:53'!
validateAndCheck: aSentence against: aPrefix thenDo: aBlockToExecute

	(aSentence isString and: [aSentence beginsWith: aPrefix]) ifTrue: aBlockToExecute.
	
	! !

!SentenceFinderByPrefix methodsFor: 'privateFinderOperations' stamp: 'PGTA 10/8/2020 16:05:02'!
validatedInputFind: aPrefix in: aStringStack

	|findResults sentence|
	
	aStringStack isEmpty ifTrue: [^OrderedCollection new].
	
	sentence := aStringStack pop.
	findResults := self validatedInputFind: aPrefix in: aStringStack.
	
	self validateAndCheck: sentence against: aPrefix thenDo: [findResults add: sentence].
	aStringStack push: sentence.
	
	^findResults
	
	! !


!SentenceFinderByPrefix methodsFor: 'finderOperations' stamp: 'PGTA 10/8/2020 15:59:19'!
find: aPrefix in: aStringStack

	
	self validate: aPrefix and: aStringStack.
	
	^self validatedInputFind: aPrefix in: aStringStack.! !


!SentenceFinderByPrefix methodsFor: 'validations' stamp: 'PJ 10/8/2020 13:31:10'!
isValidPrefix: aPrefix

	
	^aPrefix isString and: [aPrefix isEmpty not and: [(aPrefix includesSubString: ' ') not]].
	
	! !

!SentenceFinderByPrefix methodsFor: 'validations' stamp: 'PJ 10/7/2020 21:13:47'!
validate: aPrefix and: aStringStack

	(self isValidPrefix: aPrefix) ifFalse: [^self error: self class invalidPrefixErrorDescription].
	(aStringStack isKindOf: OOStack) ifFalse: [^self error: self class notStackErrorDescription].	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'PJ 10/7/2020 19:51:43'!
invalidPrefixErrorDescription
	^'Invalid prefix'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'PJ 10/7/2020 20:55:50'!
notStackErrorDescription
	^'not an stack'! !
