!classDefinition: #I category: #'Numeros De Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros De Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'Operaciones' stamp: 'PJ 9/16/2020 20:15:51'!
* unNumero 
	^unNumero.! !

!I class methodsFor: 'Operaciones' stamp: 'PJ 9/14/2020 21:19:10'!
+ unNumero 
	^unNumero next.! !

!I class methodsFor: 'Operaciones' stamp: 'PJ 9/16/2020 21:30:21'!
- unNumero 
	^self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'Operaciones' stamp: 'PJ 9/16/2020 21:19:37'!
/ unNumero 
	(unNumero isDescendantOf: self) ifTrue: [^self error: 'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'].
	unNumero = self ifTrue: [^I] ifFalse: [^(self - unNumero / unNumero) + I].! !

!I class methodsFor: 'Operaciones' stamp: 'PJ 9/14/2020 21:54:05'!
next
	^self createChildNamed: self name, 'I'! !


!I class methodsFor: 'as yet unclassified' stamp: 'PJ 9/16/2020 21:31:22'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ self error: 'NoSePuedeDividirPorUnNumeroMayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'PJ 9/16/2020 21:31:34'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ self error: 'NumerosNegativosNoSoportados'! !


!classDefinition: #II category: #'Numeros De Peano'!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros De Peano'!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'as yet unclassified' stamp: 'PJ 9/16/2020 20:17:37'!
* unNumero 
	^(unNumero * self previous) + unNumero.! !

!II class methodsFor: 'as yet unclassified' stamp: 'PJ 9/14/2020 22:02:57'!
+ unNumero 
	^self previous + unNumero next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'PJ 9/16/2020 21:27:55'!
- unNumero 
	(unNumero isDescendantOf: self) ifTrue: [^self descripcionDeErrorDeNumerosNegativosNoSoportados].
	unNumero = I ifTrue: [^self parent] ifFalse: [^self previous - unNumero previous].! !

!II class methodsFor: 'as yet unclassified' stamp: 'PJ 9/14/2020 21:53:29'!
previous
	^self parent! !


!classDefinition: #III category: #'Numeros De Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIII category: #'Numeros De Peano'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIIII category: #'Numeros De Peano'!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIIIII category: #'Numeros De Peano'!
IIIIII subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIIIIII category: #'Numeros De Peano'!
IIIIIII subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIIIIIII category: #'Numeros De Peano'!
IIIIIIII subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIIIIIIII category: #'Numeros De Peano'!
IIIIIIIII subclass: #IIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIIIIIIIII category: #'Numeros De Peano'!
IIIIIIIIII subclass: #IIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!
