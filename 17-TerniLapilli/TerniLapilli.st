!classDefinition: #TerniLapilliTest category: 'TerniLapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 18:15:43'!
test01NewTerniLapilliIsNotOver
	
	|terni|
	terni := TerniLapilli new.
	
	self assert: false equals: terni isOver! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 18:16:24'!
test02InNewTerniLapilliPlayerXHasntWon
	
	|terni|
	terni := TerniLapilli new.
	
	self assert: false equals: terni hasPlayerXWon! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 18:16:43'!
test03InNewTerniLapilliPlayerOHasntWon
	
	|terni|
	terni := TerniLapilli new.
	
	self assert: false equals: terni hasPlayerOWon! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 19:48:57'!
test04InNewTerniLapilliPlayerXStartsPlayingAndTheBoardIsEmpty
	
	|terni|
	terni := TerniLapilli new.
	
	self assert: terni isPlayingX.
	self assert: terni isPlayingO not.
	self assert: 0 equals: terni piecesInPlay.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 20:48:58'!
test05AfterPlayerXTurnIsPlayerOTurn
	
	|terni|
	terni := TerniLapilli new.
	terni playTurnAction: 'centro'.
	
	self assert: terni isPlayingX not.
	self assert: terni isPlayingO! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 20:48:40'!
test06XCanPutAPieceInXTurn
	
	|terni|
	terni := TerniLapilli new.
	terni playTurnAction: 'centro'.
	
	self assert: 1 equals: terni piecesInPlay.
	self assert: (terni hasAnXPieceIn: 'centro').! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 22:06:36'!
test07OCanPutAPieceInOTurn
	
	|terni|
	terni := TerniLapilli new.
	terni playTurnAction: 'centro'.
	terni playTurnAction: 'arribaCentro'.
	
	self assert: 2 equals: terni piecesInPlay.
	self assert: (terni hasAnOPieceIn: 'arribaCentro').! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 21:22:44'!
test08AnEmptyBoardDoesNotHaveAnXPieceInTheCenter
	
	|terni|
	terni := TerniLapilli new.
		
	self assert: false equals: (terni hasAnXPieceIn: 'centro').
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 21:26:28'!
test09AnEmptyBoardDoesNotHaveAnOPieceInTheCenter
	
	|terni|
	terni := TerniLapilli new.
		
	self assert: false equals: (terni hasAnOPieceIn: 'centro').
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 21:54:08'!
test10ABoardWithAPieceInArribaCentroDoesNotHaveAnXOrAnOPieceInCentro
	
	|terni|
	terni := TerniLapilli new.
	terni playTurnAction: 'arribaCentro'.	
	self assert: false equals: (terni hasAnOPieceIn: 'centro').
	self assert: false equals: (terni hasAnXPieceIn: 'centro').	! !


!classDefinition: #Posiciones category: 'TerniLapilli'!
Object subclass: #Posiciones
	instanceVariableNames: 'valor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Posiciones methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:10:39'!
canHandle: aPositionIdentifier
	self subclassResponsibility ! !

!Posiciones methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 17:40:30'!
hasAnO
	^valor = 'O'! !

!Posiciones methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 17:40:23'!
hasAnX
	^valor = 'X'! !

!Posiciones methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:29:17'!
initialize
	valor := ''! !

!Posiciones methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 17:39:56'!
isEmpty
	^valor = ''! !

!Posiciones methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 17:41:01'!
storeAnO
	^valor := 'O'! !

!Posiciones methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 17:41:19'!
storeAnX
	^valor := 'X'! !


!classDefinition: #AbajoCentro category: 'TerniLapilli'!
Posiciones subclass: #AbajoCentro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!AbajoCentro methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:11:25'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'abajoCentro'! !


!classDefinition: #AbajoDerecha category: 'TerniLapilli'!
Posiciones subclass: #AbajoDerecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!AbajoDerecha methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:11:44'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'abajoDerecha'! !


!classDefinition: #AbajoIzquierda category: 'TerniLapilli'!
Posiciones subclass: #AbajoIzquierda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!AbajoIzquierda methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:12:00'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'abajoIzquierda'! !


!classDefinition: #ArribaCentro category: 'TerniLapilli'!
Posiciones subclass: #ArribaCentro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!ArribaCentro methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:12:24'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'arribaCentro'! !


!classDefinition: #ArribaDerecha category: 'TerniLapilli'!
Posiciones subclass: #ArribaDerecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!ArribaDerecha methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:12:36'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'arribaDerecha'! !


!classDefinition: #ArribaIzquierda category: 'TerniLapilli'!
Posiciones subclass: #ArribaIzquierda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!ArribaIzquierda methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:12:47'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'arribaIzquierda'! !


!classDefinition: #Centro category: 'TerniLapilli'!
Posiciones subclass: #Centro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Centro methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:13:24'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'centro'! !


!classDefinition: #Derecha category: 'TerniLapilli'!
Posiciones subclass: #Derecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Derecha methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:13:15'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'derecha'! !


!classDefinition: #Izquierda category: 'TerniLapilli'!
Posiciones subclass: #Izquierda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Izquierda methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:13:37'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'izquierda'! !


!classDefinition: #TerniLapilli category: 'TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'isXTurn piecesInPlay board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'game actions' stamp: 'PJ 10/31/2020 18:39:27'!
playTurnAction: aPositionIdentifier 
	
	"((self hasAnOPieceIn: aPosition) or: [self hasAnXPieceIn: aPosition]) ifTrue: [^self error: self class canNotPutAPieceInAnOccupiedSiteErrorDescription]."
	|boardPosition|
	boardPosition := self getBoardPositionFor: aPositionIdentifier.
	isXTurn ifTrue: [boardPosition storeAnX] ifFalse: [boardPosition storeAnO].
	isXTurn := isXTurn not.
	piecesInPlay := piecesInPlay + 1.! !


!TerniLapilli methodsFor: 'private position management' stamp: 'PJ 10/31/2020 18:37:47'!
getBoardPositionFor: aPositionIdentifier 
	
	^board  detect: [:aBoardPosition | aBoardPosition canHandle: aPositionIdentifier].! !


!TerniLapilli methodsFor: 'game testing' stamp: 'PJ 10/31/2020 18:38:56'!
hasAnOPieceIn: aPositionIdentifier
	|boardPosition|
	boardPosition := self getBoardPositionFor: aPositionIdentifier.
	^boardPosition hasAnO! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PJ 10/31/2020 18:39:11'!
hasAnXPieceIn: aPositionIdentifier
	|boardPosition|
	boardPosition := self getBoardPositionFor: aPositionIdentifier.
	^boardPosition hasAnX! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PJ 10/29/2020 18:21:01'!
hasPlayerOWon
	^false! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PJ 10/29/2020 18:20:34'!
hasPlayerXWon
	^false! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PJ 10/31/2020 18:24:56'!
initialize
	isXTurn := true.
	piecesInPlay := 0.
	board := OrderedCollection new.
	board add: ArribaIzquierda new.
	board add: ArribaCentro new.
	board add: ArribaDerecha new.
	board add: Izquierda new.
	board add: Centro new.
	board add: Derecha new.
	board add: AbajoIzquierda new.
	board add: AbajoCentro new.
	board add: AbajoDerecha new.! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PJ 10/29/2020 18:19:44'!
isOver
	^false! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PJ 10/29/2020 18:55:10'!
isPlayingO
	^isXTurn not! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PJ 10/29/2020 18:55:20'!
isPlayingX
	^isXTurn! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PJ 10/29/2020 20:09:40'!
piecesInPlay
	^piecesInPlay! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/29/2020 21:02:11'!
canNotPutAPieceInAnOccupiedSiteErrorDescription
	^'cannot Put A Piece In An Occupied Site'.! !
