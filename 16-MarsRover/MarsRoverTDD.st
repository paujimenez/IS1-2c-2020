!classDefinition: #MarsRoverTests category: 'MarsRoverTDD'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'PGTA 10/23/2020 19:23:06'!
test01
	| rover initialPoint |
	initialPoint := (1@1).
	rover := MarsRover startPoint: initialPoint initialOrientation: 'N'.
	
	self assert: (rover position) equals: initialPoint.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'PGTA 10/23/2020 19:36:05'!
test02
	| rover initialPoint forwardPoint|
	initialPoint := (0@0).
	forwardPoint := (0@1).
	
	rover := MarsRover startPoint: initialPoint initialOrientation: 'N'.
	rover processCommand: 'f'.
	
	self assert: (rover position) equals: forwardPoint.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'PGTA 10/23/2020 19:42:48'!
test03
	| rover initialPoint |
	initialPoint := (0@0).
	
	rover := MarsRover startPoint: initialPoint initialOrientation: 'N'.
	rover processCommand: 'l'.
	
	self assert: (rover position) equals: initialPoint.
	self assert: (rover orientation) equals: 'O'.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'PGTA 10/23/2020 19:53:19'!
test04
	| rover initialPoint finalPoint|
	initialPoint := (0@0).
	finalPoint := (-1@0).
	
	rover := MarsRover startPoint: initialPoint initialOrientation: 'N'.
	rover processCommand: 'r'.
	rover processCommand: 'b'.
	
	self assert: (rover position) equals: finalPoint.
	self assert: (rover orientation) equals: 'E'.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'PGTA 10/23/2020 20:01:00'!
test05
	| rover initialPoint finalPoint|
	initialPoint := (0@0).
	finalPoint := (1@0).
	
	rover := MarsRover startPoint: initialPoint initialOrientation: 'N'.
	rover processCommand: 'r'.
	rover processCommand: 'f'.
	
	self assert: (rover position) equals: finalPoint.
	self assert: (rover orientation) equals: 'E'.! !


!classDefinition: #MarsRover category: 'MarsRoverTDD'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRover methodsFor: 'initialization' stamp: 'PGTA 10/23/2020 19:30:57'!
initializeStartPoint: aPoint initialOrientation: anOrientation 

	position := aPoint.
	orientation := anOrientation.! !


!MarsRover methodsFor: 'state' stamp: 'PGTA 10/23/2020 19:30:16'!
position
	^position.! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'PGTA 10/23/2020 19:46:37'!
orientation
	^orientation! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PGTA 10/23/2020 20:12:26'!
processCommand: aCommand
	aCommand = 'f'
		ifTrue: [ position := position + (
			orientation = 'N' ifTrue: [0@1]
			ifFalse: [orientation = 'E' ifTrue: [1@0]
			ifFalse: [orientation = 'S' ifTrue: [0@-1]
			ifFalse: [-1@0]]]
			)].
	aCommand = 'b'
		ifTrue: [ position := position + (
			orientation = 'N' ifTrue: [0@-1]
			ifFalse: [orientation = 'E' ifTrue: [-1@0]
			ifFalse: [orientation = 'S' ifTrue: [0@1]
			ifFalse: [1@0]]]
			)].
		
	aCommand = 'l'
		ifTrue: [orientation := 'O'].
	aCommand = 'r'
		ifTrue: [orientation := 'E'].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRoverTDD'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'PGTA 10/23/2020 19:25:35'!
startPoint: aPoint initialOrientation: anOrientation
	
	^self new initializeStartPoint: aPoint initialOrientation: anOrientation! !
