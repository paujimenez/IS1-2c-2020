!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'NR 11/9/2020 06:00:12'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'NR 11/9/2020 06:02:30'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
		
	self assert: 1 equals: account transactions size .
	self assert: (account transactions includes: deposit).
! !


!ReceptiveAccountTest methodsFor: 'transfer tests' stamp: 'PJ 11/10/2020 21:16:50'!
test08TransferSenderAccountAcknowledgesTransferTransactions 

	| senderAccount receiverAccount transfer|
	
	senderAccount := ReceptiveAccount new.
	Deposit register: 100 on: senderAccount.
	
	receiverAccount := ReceptiveAccount new.
	
	transfer := Transfer from: senderAccount to: receiverAccount amount: 10.
		
	self assert: 90 equals: senderAccount balance.
	self assert: (senderAccount hasRegistered: (transfer withdraw)).
! !

!ReceptiveAccountTest methodsFor: 'transfer tests' stamp: 'PJ 11/10/2020 21:17:27'!
test09TransferReceiverAccountAcknowledgesTransferTransactions 

	| senderAccount receiverAccount transfer |
	
	senderAccount := ReceptiveAccount new.
	Deposit register: 100 on: senderAccount.
	
	receiverAccount := ReceptiveAccount new.
	
	transfer := Transfer from: senderAccount to: receiverAccount amount: 10.
		
	self assert: 10 equals: receiverAccount balance.
	self assert: (receiverAccount hasRegistered: (transfer deposit) ).
! !

!ReceptiveAccountTest methodsFor: 'transfer tests' stamp: 'PJ 11/10/2020 21:16:10'!
test10TransferDepositAndWithdrawCanNavigateToTransfer

	| senderAccount receiverAccount transfer deposit withdraw |
	
	senderAccount := ReceptiveAccount new.
	Deposit register: 100 on: senderAccount.
	
	receiverAccount := ReceptiveAccount new.
	
	transfer := Transfer from: senderAccount to: receiverAccount amount: 10.
	
	deposit := transfer deposit.
	withdraw  := transfer withdraw.
	
	self assert: transfer equals: deposit transfer.
	self assert: transfer equals: withdraw transfer.
! !

!ReceptiveAccountTest methodsFor: 'transfer tests' stamp: 'PJ 11/10/2020 22:22:28'!
test11TransferDepositAndWithdrawKnowTheTransferAmount

	| senderAccount receiverAccount transfer deposit withdraw |
	
	senderAccount := ReceptiveAccount new.
	Deposit register: 100 on: senderAccount.
	
	receiverAccount := ReceptiveAccount new.
	
	transfer := Transfer from: senderAccount to: receiverAccount amount: 10.
	
	deposit := transfer deposit.
	withdraw  := transfer withdraw.
	
	self assert: 10 equals: deposit value.
	self assert: 10 equals: withdraw value.
! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'transfer net' stamp: 'PJ 11/10/2020 23:08:36'!
test06TransferNetFromANewAccountReturnsZero

	|account report|
	
	account := ReceptiveAccount new.
	report := TransferNet for: account.
	
	self assert: 'Transfer Net: 0' equals: report.! !

!ReportTest methodsFor: 'transfer net' stamp: 'PJ 11/12/2020 22:16:33'!
test07TransferNetReturnsAReportFromAnAccountWithADeposit

	|account report|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	report := TransferNet for: account.
	
	self assert: 'Transfer Net: 0' equals: report.! !

!ReportTest methodsFor: 'transfer net' stamp: 'PJ 11/12/2020 22:30:12'!
test08TransferNetReturnsAReportFromAnAccountWithAWithdraw

	|account report|
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	
	report := TransferNet for: account.
	
	self assert: 'Transfer Net: 0' equals: report.! !

!ReportTest methodsFor: 'transfer net' stamp: 'PJ 11/12/2020 22:28:56'!
test09TransferNetReturnsAReportFromAnAccountWithATransferWithdraw

	|senderAccount receiverAccount report|
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	Transfer from: senderAccount to: receiverAccount amount: 20.
	
	report := TransferNet for: senderAccount.
	
	self assert: 'Transfer Net: -20' equals: report.! !

!ReportTest methodsFor: 'transfer net' stamp: 'PJ 11/12/2020 22:34:36'!
test10TransferNetReturnsAReportFromAnAccountWithATransferDeposit

	|senderAccount receiverAccount report|
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	Transfer from: senderAccount to: receiverAccount amount: 20.
		
	report := TransferNet for: receiverAccount.
	
	self assert: 'Transfer Net: 20' equals: report.! !

!ReportTest methodsFor: 'transfer net' stamp: 'PJ 11/12/2020 23:34:11'!
test11TransferNetWorksWithAPortfolio

	|portfolio account account2 report|
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	Transfer from: account to: account2 amount: 50. 
	Transfer from: account2 to: account amount: 5. 
		
	portfolio := Portfolio with: account.
		
	report := TransferNet for: portfolio .
	
	self assert: 'Transfer Net: -45' equals: report.! !


!ReportTest methodsFor: 'account summary' stamp: 'PJ 11/10/2020 21:47:09'!
test01AccountSummaryFromANewAccountReturnsBalance0

	|account report|
	
	account := ReceptiveAccount new.
	report := AccountSummary for: account.
	
	self assert: 1 equals: report size.
	self assert: 'Balance = 0' equals: report first.! !

!ReportTest methodsFor: 'account summary' stamp: 'PJ 11/10/2020 21:57:55'!
test02AccountSummaryReturnsAReportFromAnAccountWithADeposit

	|account report|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	report := AccountSummary for: account.
	
	self assert: 2 equals: report size.
	self assert: 'Depósito por 100' equals: (report at: 1).
	self assert: 'Balance = 100' equals: (report at: 2).! !

!ReportTest methodsFor: 'account summary' stamp: 'PJ 11/10/2020 22:08:03'!
test03AccountSummaryReturnsAReportFromAnAccountWithAWithdraw

	|account report|
	
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account.
	
	report := AccountSummary for: account.
	
	self assert: 2 equals: report size.
	self assert: 'Extracción por 50' equals: (report at: 1).
	self assert: 'Balance = -50' equals: (report at: 2).! !

!ReportTest methodsFor: 'account summary' stamp: 'PJ 11/10/2020 22:15:11'!
test04AccountSummaryReturnsAReportFromAnAccountWithATransferWithdraw

	|senderAccount receiverAccount report|
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	Transfer from: senderAccount to: receiverAccount amount: 20.
	
	report := AccountSummary for: senderAccount.
	
	self assert: 2 equals: report size.
	self assert: 'Salida por transferencia de 20' equals: (report at: 1).
	self assert: 'Balance = -20' equals: (report at: 2).! !

!ReportTest methodsFor: 'account summary' stamp: 'PJ 11/12/2020 22:19:53'!
test05AccountSummaryReturnsAReportFromAnAccountWithATransferDeposit

	|senderAccount receiverAccount report|
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	Transfer from: senderAccount to: receiverAccount amount: 20.
	
	report := AccountSummary for: receiverAccount.
	
	self assert: 2 equals: report size.
	self assert: 'Entrada por transferencia de 20' equals: (report at: 1).
	self assert: 'Balance = 20' equals: (report at: 2).! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'printing' stamp: 'PJ 11/10/2020 22:44:31'!
balanceDescription
	self subclassResponsibility .! !


!Account methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 23:19:40'!
reportTo: aReport 
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 23:20:04'!
reportTo: aReport 
	self transactions do: [:aTransaction | 	aReport reportTransactionInfo: (aTransaction reportTo: aReport )].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'NR 11/9/2020 05:56:36'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'PGTA 11/9/2020 21:30:32'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]
		! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'printing' stamp: 'PJ 11/10/2020 22:44:58'!
balanceDescription
	^'Balance = ', self balance asString! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 23:11:39'!
reportTo: aReport 
	transactions do: [:aTransaction | 	aReport reportTransactionInfo: (aTransaction reportTo: aReport )].! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'PJ 11/10/2020 22:38:23'!
description
	self subclassResponsibility! !

!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 21:45:00'!
reportTo: anAccountSummary 
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'printing' stamp: 'PJ 11/10/2020 22:39:34'!
description
	^'Depósito por ', value asString ! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 21:51:39'!
reportTo: aReport 
	^aReport reportAsDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransaction methodsFor: 'as yet unclassified' stamp: 'PJ 11/10/2020 21:20:23'!
initializeOn: aReceiverAccount for: aTransfer

	transfer := aTransfer.
	aReceiverAccount register: self.! !

!TransferTransaction methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 22:03:00'!
reportTo: aReport
	self subclassResponsibility.! !

!TransferTransaction methodsFor: 'as yet unclassified' stamp: 'PJ 11/10/2020 21:19:11'!
transfer
	^transfer! !

!TransferTransaction methodsFor: 'as yet unclassified' stamp: 'PJ 11/10/2020 22:23:50'!
value
	^transfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'Portfolio-Solucion'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'as yet unclassified' stamp: 'PGTA 11/9/2020 22:51:15'!
registerOn: aReceiverAccount for: aTransfer
	
	^self new initializeOn: aReceiverAccount for: aTransfer.
	! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'PJ 11/10/2020 21:20:14'!
affectBalance: aBalance

	^aBalance + transfer value.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 22:05:36'!
reportTo: aReport
	^aReport reportAsTransferDeposit: self.! !


!TransferDeposit methodsFor: 'printing' stamp: 'PJ 11/10/2020 22:41:27'!
description
	^'Entrada por transferencia de ', self value asString! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'PJ 11/10/2020 21:19:54'!
affectBalance: aBalance

	^aBalance - transfer value.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 22:02:10'!
reportTo: aReport 
	^aReport reportAsTransferWithdraw: self.! !


!TransferWithdraw methodsFor: 'printing' stamp: 'PJ 11/10/2020 22:41:01'!
description
	^'Salida por transferencia de ', self value asString ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'printing' stamp: 'PJ 11/10/2020 22:40:02'!
description
	^'Extracción por ', value asString ! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 21:54:02'!
reportTo: aReport 
	^aReport reportAsWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'private' stamp: 'PJ 11/10/2020 23:11:11'!
generateReportFor: anAccount
	self subclassResponsibility ! !


!Report methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 21:48:32'!
reportAsDeposit: aDeposit 
	self subclassResponsibility.! !

!Report methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 22:07:39'!
reportAsTransferDeposit: aTransaction
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 22:00:41'!
reportAsTransferWithdraw: aTransaction
	self subclassResponsibility .! !

!Report methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 22:09:57'!
reportAsWithdraw: aWithdraw 
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'PJ 11/10/2020 23:12:22'!
for: anAccount 
	^self new generateReportFor: anAccount ! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'private' stamp: 'PJ 11/12/2020 21:43:54'!
generateReportFor: anAccount 
	
	|report transactions|
	report := OrderedCollection new.
	
	transactions := anAccount transactions.
	transactions do: [:transaction | report add: (transaction reportTo: self)].
	
	report add: anAccount balanceDescription.
	^report ! !


!AccountSummary methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 21:49:45'!
reportAsDeposit: aTransaction 
	^'Depósito por ', aTransaction value asString ! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 22:09:00'!
reportAsTransferDeposit: aTransaction
	^'Entrada por transferencia de ', aTransaction value asString! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 22:02:03'!
reportAsTransferWithdraw: aTransaction 
	^'Salida por transferencia de ', aTransaction value asString ! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 21:57:29'!
reportAsWithdraw: aWithdraw 
	^'Extracción por ', aWithdraw value asString! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'netValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'private' stamp: 'PJ 11/12/2020 23:15:28'!
generateReportFor: anAccount 
	
	netValue := 0.
	
	anAccount reportTo: self.
		
	^'Transfer Net: ', netValue asString. ! !


!TransferNet methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 22:47:38'!
reportAsDeposit: aTransaction 
	^0! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 22:47:56'!
reportAsTransferDeposit: aTransaction 
	^aTransaction affectBalance: 0! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 22:48:13'!
reportAsTransferWithdraw: aTransaction 
	^aTransaction affectBalance: 0! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 22:48:24'!
reportAsWithdraw: aTransaction 
	^0! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'PJ 11/12/2020 23:14:20'!
reportTransactionInfo: aValue 
	netValue := netValue + aValue.! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'deposit withdraw value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'PGTA 11/9/2020 21:31:24'!
deposit
	
	^deposit.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'PGTA 11/9/2020 22:51:42'!
initializeFrom: aSenderAccount to: aReceiverAccount amount: anAmount
	
	value := anAmount.
	deposit := TransferDeposit registerOn: aReceiverAccount for: self.
	withdraw := TransferWithdraw registerOn: aSenderAccount for: self.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'PJ 11/10/2020 22:26:04'!
value
	^value! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'PGTA 11/9/2020 21:31:42'!
withdraw
	
	^withdraw.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'PGTA 11/9/2020 21:21:45'!
from: aSenderAccount to: aReceiverAccount amount: anAmount
	^self new initializeFrom: aSenderAccount to: aReceiverAccount amount: anAmount.
	
	! !
