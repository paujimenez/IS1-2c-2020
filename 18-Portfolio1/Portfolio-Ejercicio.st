!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'portfolio-balance' stamp: 'PJ 11/2/2020 20:36:31'!
test01NewPortfolioHasBalanceZero
	|portfolio|
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'portfolio-balance' stamp: 'PJ 11/2/2020 20:48:54'!
test02BalanceOfPortfolioWithOneAccountEqualsBalanceOfTheAccount
	|portfolio account|
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 15 on: account.
	
	portfolio add: account.
	
	self assert: account balance equals: portfolio balance.! !

!PortfolioTest methodsFor: 'portfolio-balance' stamp: 'PJ 11/2/2020 21:01:11'!
test03BalanceOfPortfolioWithManyAccountsEqualsTheSumOfBalancesOfTheAccounts
	|portfolio account account2 account3| 
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 15 on: account.
	
	account2 := ReceptiveAccount new.
	Deposit register: 60 on: account2.
	Withdraw register: 10 on: account2.
	
	account3 := ReceptiveAccount new.
	Deposit register: 20 on: account3.
	Withdraw register: 5 on: account3.
	
	portfolio add: account.
	portfolio add: account2.
	portfolio add: account3.
	
	self assert: 150 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'portfolio-balance' stamp: 'PJ 11/3/2020 20:43:04'!
test04BalanceOfPortfolioWithOnePortfolioEqualsTheBalanceOfTheChildPortfolio
	|portfolioPadre portfolioHijo account|
	
	portfolioPadre := Portfolio new.
	
	portfolioHijo := Portfolio new.
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 15 on: account.
	
	portfolioHijo add: account.
	
	portfolioPadre add: portfolioHijo.
	
	self assert: portfolioHijo balance equals: portfolioPadre balance.! !


!PortfolioTest methodsFor: 'portfolio-consistency' stamp: 'PJ 11/6/2020 20:58:56'!
test09CanNotAddAnAccountThatIsAlreadyInThePortfolio
	|portfolio account|
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	Deposit  register: 100 on: account.
	Withdraw register: 50 on: account.
	portfolio add: account.
	
	self should: [portfolio add: account]
		raise: Error
		withMessageText: portfolio class accountAlreadyInPortfolioTreeErrorDescription.! !

!PortfolioTest methodsFor: 'portfolio-consistency' stamp: 'PJ 11/6/2020 21:08:39'!
test10CanNotAddAPortfolioWithAnAlreadyIncludedAccountInThePortfolio
	|portfolio account portfolio2|
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.
	Deposit  register: 100 on: account.
	Withdraw register: 50 on: account.
	
	portfolio add: account.
	portfolio2 add: account.
	
	self should: [portfolio add: portfolio2]
		raise: Error
		withMessageText: portfolio class accountAlreadyInPortfolioTreeErrorDescription.! !

!PortfolioTest methodsFor: 'portfolio-consistency' stamp: 'PJ 11/6/2020 21:42:08'!
test11CanNotAddAnAccountWithAnAlreadyIncludedAccountInTheIncludedPortfolio
	|portfolio account portfolio2|
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.
	Deposit  register: 100 on: account.
	Withdraw register: 50 on: account.
	
	portfolio add: portfolio2.
	portfolio2 add: account.
	
	self should: [portfolio add: account]
		raise: Error
		withMessageText: portfolio class accountAlreadyInPortfolioTreeErrorDescription.! !


!PortfolioTest methodsFor: 'portfolio-transactions' stamp: 'PJ 11/3/2020 23:45:53'!
test07NewPortfolioHasNoTransaction
	|portfolio|
	
	portfolio := Portfolio new.
	
	self assert: (portfolio transactions isEmpty).! !

!PortfolioTest methodsFor: 'portfolio-transactions' stamp: 'PJ 11/3/2020 23:55:49'!
test08PortfolioWithTransactionsReturnsAllTransactions
	|portfolio portfolio2 account account2 deposit withdraw deposit2 transactions|
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit := Deposit  register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	portfolio add: account.
	
	portfolio2 := Portfolio new.
	portfolio add: portfolio2.
		
	account2 := ReceptiveAccount new.
	deposit2 := Deposit  register: 100 on: account2.
	portfolio2 add: account2.
	
	transactions := portfolio transactions.
	
	self assert: 3 equals: transactions size.
	self assert: true equals: (transactions includes: deposit).
	self assert: true equals: (transactions includes: withdraw).
	self assert: true equals: (transactions includes: deposit2).! !


!PortfolioTest methodsFor: 'portfolio-hasRegistered' stamp: 'PJ 11/3/2020 22:41:51'!
test05NewPortfolioHasNoRegisteredTransaction
	|portfolio deposit withdraw|
	
	portfolio := Portfolio new.
	
	deposit := Deposit  for: 100.
	withdraw := Withdraw for: 50.
	
	self assert: false equals: (portfolio hasRegistered: deposit).
	self assert: false equals: (portfolio hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'portfolio-hasRegistered' stamp: 'PJ 11/3/2020 23:28:32'!
test06PortfolioWithWithTransactionsHasRegisteredTransactions
	|portfolio portfolio2 account account2 deposit withdraw deposit2 withdrawNew|
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit := Deposit  register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	portfolio add: account.
	
	portfolio2 := Portfolio new.
	portfolio add: portfolio2.
		
	account2 := ReceptiveAccount new.
	deposit2 := Deposit  register: 100 on: account2.
	portfolio2 add: account2.
	
	withdrawNew := Withdraw for: 50.
	
	self assert: true equals: (portfolio hasRegistered: deposit).
	self assert: true equals: (portfolio hasRegistered: withdraw).
	self assert: true equals: (portfolio hasRegistered: deposit2).
	
	self assert: false equals: (portfolio hasRegistered: withdrawNew).! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'PJ 11/2/2020 19:54:10'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'PJ 11/2/2020 19:22:17'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:15'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'PJ 11/2/2020 19:23:23'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'PJ 11/2/2020 19:56:34'!
aggregateTo: aBalance
	^aBalance + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'PJ 11/2/2020 19:56:51'!
aggregateTo: aBalance
	^aBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'assets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'PJ 11/6/2020 21:44:34'!
add: anAsset
	(assets anySatisfy: [:each | (each = anAsset) 
		or: [(anAsset isKindOf: self class) ifTrue: [anAsset containsAsset: each ] ifFalse: [false]]
		or: [(each isKindOf: self class) ifTrue: [each containsAsset: anAsset ] ifFalse: [false]]])
		ifTrue: [^self error: self class accountAlreadyInPortfolioTreeErrorDescription].
	assets add: anAsset.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'PJ 11/3/2020 20:47:30'!
balance
	^assets sum: [:anAsset | anAsset balance] ifEmpty: [0].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'PJ 11/6/2020 21:39:34'!
containsAsset: anAsset
	^assets includes: anAsset.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'PJ 11/3/2020 23:10:47'!
hasRegistered: aTransaction
	^assets anySatisfy: [:anAsset | anAsset hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'PJ 11/3/2020 20:47:45'!
initialize
	assets := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'PJ 11/6/2020 19:58:06'!
transactions
	|transactions|
	transactions := OrderedCollection new.
	assets do: [:anAsset | transactions addAll: (anAsset transactions)].
	^transactions! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'PJ 11/6/2020 20:42:40'!
accountAlreadyInPortfolioTreeErrorDescription
	^'Account Already In Portfolio Tree Error Description'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'PJ 11/2/2020 19:57:25'!
balance
	|sum|
	sum := 0.
	transactions do: [ :aTransaction | 	sum := 	aTransaction aggregateTo: sum].
	^sum! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'PJ 11/3/2020 20:49:25'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
