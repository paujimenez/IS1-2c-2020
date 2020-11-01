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

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:22:17'!
test05AfterPlayerXTurnIsPlayerOTurn
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'centro'.
	
	self assert: terni isPlayingX not.
	self assert: terni isPlayingO! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:22:17'!
test06XCanPutAPieceInXTurn
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'centro'.
	
	self assert: 1 equals: terni piecesInPlay.
	self assert: (terni hasAnXPieceIn: 'centro').! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:22:17'!
test07OCanPutAPieceInOTurn
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'centro'.
	terni placePieceIn: 'arribaCentro'.
	
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

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:22:17'!
test10ABoardWithAPieceInArribaCentroDoesNotHaveAnXOrAnOPieceInCentro
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaCentro'.	
	self assert: false equals: (terni hasAnOPieceIn: 'centro').
	self assert: false equals: (terni hasAnXPieceIn: 'centro').	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:22:17'!
test11TwoPiecesCanNotBePlacedInTheSamePositionAfterThatOCanPlayInADifferentPosition
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaCentro'.	
	
	self should: [terni placePieceIn: 'arribaCentro'.	]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli canNotPutAPieceInAnOccupiedPositionErrorDescription.
	
	self assert: terni isPlayingO.
	
	terni placePieceIn: 'centro'.	
	
	self assert: (terni hasAnOPieceIn: 'centro').	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:22:17'!
test12TerniLapilliAssertsWithAnInvalidPosition
	
	|terni|
	terni := TerniLapilli new.
	
	self should: [terni placePieceIn: 'arribaDerechaCentro'.	]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli invalidPositionErrorDescription.
	
	self assert: terni isPlayingX.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 22:47:58'!
test13NonOfThePlayersCanPutMoreThanTheMaxAmountOfPiecesPerPlayer
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'izquierda'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'derecha'.	
	
	self should: [terni placePieceIn: 'abajoIzquierda'.	]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli noMorePiecesAvailableErrorDescription.
	
	self assert: terni isPlayingX.	
	terni movePieceFrom: 'centro' to: 'abajoCentro'.
	
	self should: [terni placePieceIn: 'abajoDerecha'.	]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli noMorePiecesAvailableErrorDescription.
	
	self assert: terni isPlayingO.		! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:50:55'!
test14CannotMoveAPieceFromAnEmptyPosition
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'izquierda'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'derecha'.	
	
	self should: [terni movePieceFrom: 'abajoIzquierda' to: 'abajoDerecha'.]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli canNotMoveAPieceFromAnEmptyPositionErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:51:09'!
test15CannotMoveAPieceIntoATakenPosition
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'izquierda'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'derecha'.	
	
	self should: [terni movePieceFrom: 'arribaIzquierda' to: 'izquierda'.]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli canNotPutAPieceInAnOccupiedPositionErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 22:01:04'!
test16CannotMoveAPieceBeforeAllPiecesAreInGame
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'izquierda'.	
	
	self should: [terni movePieceFrom: 'arribaIzquierda' to: 'izquierda'.]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli canNotMoveAPieceBeforeAllPiecesAreInGameErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 22:18:33'!
test17XCannotMoveAnOPiece
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'izquierda'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'derecha'.	
	
	self should: [terni movePieceFrom: 'arribaCentro' to: 'abajoCentro'.]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli canNotMoveAPieceFromAnotherPlayerErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 22:41:53'!
test18CannotMoveAPieceJumpingPositions
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'izquierda'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'derecha'.	
	
	self should: [terni movePieceFrom: 'arribaIzquierda' to: 'abajoCentro'.]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli canNotMoveAPieceJumpingPositionsErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 22:51:21'!
test19CannotMoveAPieceIntoTheSamePosition
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'izquierda'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'derecha'.	
	
	self should: [terni movePieceFrom: 'arribaIzquierda' to: 'arribaIzquierda'.]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli canNotMoveAPieceIntoTheSamePositionErrorDescription.! !


!classDefinition: #Posiciones category: 'TerniLapilli'!
Object subclass: #Posiciones
	instanceVariableNames: 'valor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Posiciones methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:10:39'!
canHandle: aPositionIdentifier
	self subclassResponsibility ! !

!Posiciones methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 21:17:18'!
freePosition
	valor := ''! !

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

!Posiciones methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 23:03:54'!
isNeighbourOf: aPosition 
	self subclassResponsibility ! !

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

!AbajoCentro methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 22:59:23'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: AbajoIzquierda ) or: (aPosition isKindOf: AbajoDerecha ) or: (aPosition isKindOf: Centro).! !


!classDefinition: #AbajoDerecha category: 'TerniLapilli'!
Posiciones subclass: #AbajoDerecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!AbajoDerecha methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:11:44'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'abajoDerecha'! !

!AbajoDerecha methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 22:59:59'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: AbajoCentro ) or: (aPosition isKindOf: Derecha ) or: (aPosition isKindOf: Centro).! !


!classDefinition: #AbajoIzquierda category: 'TerniLapilli'!
Posiciones subclass: #AbajoIzquierda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!AbajoIzquierda methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:12:00'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'abajoIzquierda'! !

!AbajoIzquierda methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 23:00:33'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: AbajoCentro) or: (aPosition isKindOf: Izquierda) or: (aPosition isKindOf: Centro).! !


!classDefinition: #ArribaCentro category: 'TerniLapilli'!
Posiciones subclass: #ArribaCentro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!ArribaCentro methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:12:24'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'arribaCentro'! !

!ArribaCentro methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 23:01:11'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: ArribaIzquierda ) or: (aPosition isKindOf: ArribaDerecha) or: (aPosition isKindOf: Centro).! !


!classDefinition: #ArribaDerecha category: 'TerniLapilli'!
Posiciones subclass: #ArribaDerecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!ArribaDerecha methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:12:36'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'arribaDerecha'! !

!ArribaDerecha methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 23:01:50'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: ArribaCentro) or: (aPosition isKindOf: Derecha) or: (aPosition isKindOf: Centro).! !


!classDefinition: #ArribaIzquierda category: 'TerniLapilli'!
Posiciones subclass: #ArribaIzquierda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!ArribaIzquierda methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:12:47'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'arribaIzquierda'! !

!ArribaIzquierda methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 22:45:07'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: ArribaCentro) or: (aPosition isKindOf: Izquierda) or: (aPosition isKindOf: Centro).! !


!classDefinition: #Centro category: 'TerniLapilli'!
Posiciones subclass: #Centro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Centro methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:13:24'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'centro'! !

!Centro methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 22:49:24'!
isNeighbourOf: aPosition 
	^true.! !


!classDefinition: #Derecha category: 'TerniLapilli'!
Posiciones subclass: #Derecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Derecha methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:13:15'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'derecha'! !

!Derecha methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 23:02:44'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: ArribaDerecha ) or: (aPosition isKindOf: AbajoDerecha) or: (aPosition isKindOf: Centro).! !


!classDefinition: #Izquierda category: 'TerniLapilli'!
Posiciones subclass: #Izquierda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Izquierda methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 18:13:37'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'izquierda'! !

!Izquierda methodsFor: 'as yet unclassified' stamp: 'PJ 10/31/2020 23:03:15'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: ArribaIzquierda) or: (aPosition isKindOf: AbajoIzquierda) or: (aPosition isKindOf: Centro).! !


!classDefinition: #TerniLapilli category: 'TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'isXTurn piecesInPlay board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'game actions' stamp: 'PJ 10/31/2020 22:57:03'!
movePieceFrom: aTakenPosition to: anEmptyPosition 
	|boardTakenPosition boardEmptyPosition|
	self areAllPiecesInGame ifFalse: [^self error: self class canNotMoveAPieceBeforeAllPiecesAreInGameErrorDescription].
	(aTakenPosition = anEmptyPosition ) ifTrue: [^self error: self class canNotMoveAPieceIntoTheSamePositionErrorDescription].
	
	boardTakenPosition := self getBoardPositionFor: aTakenPosition.
	(self isPositionEmpty: boardTakenPosition ) ifTrue: [^self error: self class canNotMoveAPieceFromAnEmptyPositionErrorDescription].
	
	boardEmptyPosition := self getBoardPositionFor: anEmptyPosition.
	(self isPositionTaken: boardEmptyPosition) ifTrue: [^self error: self class canNotPutAPieceInAnOccupiedPositionErrorDescription].
	
	(self isPositionTakenByAnotherPlayer: boardTakenPosition) ifTrue: [^self error: self class canNotMoveAPieceFromAnotherPlayerErrorDescription].
	
	(boardTakenPosition isNeighbourOf: boardTakenPosition) ifTrue: [
		boardTakenPosition freePosition.
		self placePieceInBoard: boardEmptyPosition.
	
		self alternateTurn.
	]
	ifFalse: [^self error: self class canNotMoveAPieceJumpingPositionsErrorDescription].! !

!TerniLapilli methodsFor: 'game actions' stamp: 'PJ 10/31/2020 21:32:49'!
placePieceIn: aPositionIdentifier 
	
	|boardPosition|
	self playerHasAvailablePiecesToPlay ifFalse: [^self error: self class noMorePiecesAvailableErrorDescription].
	
	boardPosition := self getBoardPositionFor: aPositionIdentifier.
	(self isPositionTaken: boardPosition) ifTrue: [^self error: self class canNotPutAPieceInAnOccupiedPositionErrorDescription].
	 
	self placePieceInBoard: boardPosition.
	self alternateTurn.
	piecesInPlay := piecesInPlay + 1.! !


!TerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 20:03:09'!
alternateTurn
	isXTurn := isXTurn not.! !

!TerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 22:07:51'!
areAllPiecesInGame
	^self playerHasAvailablePiecesToPlay not! !

!TerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 20:26:58'!
getBoardPositionFor: aPositionIdentifier 
	
	^board  detect: [:aBoardPosition | aBoardPosition canHandle: aPositionIdentifier]
		ifNone: [^self error: self class invalidPositionErrorDescription].! !

!TerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 21:55:01'!
isPositionEmpty: aBoardPosition
	^aBoardPosition isEmpty! !

!TerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 20:00:23'!
isPositionTaken: aBoardPosition 
	^aBoardPosition isEmpty not! !

!TerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 22:29:14'!
isPositionTakenByAnotherPlayer: aBoardPosition 
	^(self isPlayingX and: [aBoardPosition hasAnO]) or: [self isPlayingO and: [aBoardPosition hasAnX]].! !

!TerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 21:33:37'!
placePieceInBoard: aBoardPosition.
	isXTurn ifTrue: [aBoardPosition storeAnX] ifFalse: [aBoardPosition storeAnO]! !

!TerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 21:07:01'!
playerHasAvailablePiecesToPlay
	^piecesInPlay < 6! !


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

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 22:01:59'!
canNotMoveAPieceBeforeAllPiecesAreInGameErrorDescription
	^'cannot Move A Piece Before All Pieces Are In Game'! !

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 21:52:07'!
canNotMoveAPieceFromAnEmptyPositionErrorDescription
	^'cannot Move A Piece From An Empty Position'! !

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 22:20:03'!
canNotMoveAPieceFromAnotherPlayerErrorDescription
	^'cannot Move A Piece From Another Player'! !

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 22:52:20'!
canNotMoveAPieceIntoTheSamePositionErrorDescription
	^'cannot Move A Piece Into The Same Position' ! !

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 22:33:44'!
canNotMoveAPieceJumpingPositionsErrorDescription
	^'cannot Move A Piece Jumping Positions'! !

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 20:07:17'!
canNotPutAPieceInAnOccupiedPositionErrorDescription
	^'cannot Put A Piece In An Occupied Position'.! !

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 20:24:17'!
invalidPositionErrorDescription
	^'Invalid Position'! !

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 20:53:50'!
noMorePiecesAvailableErrorDescription
	^'No More Pieces Available'! !
