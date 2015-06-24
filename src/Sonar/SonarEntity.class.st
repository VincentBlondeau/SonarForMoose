Class {
	#name : #SonarEntity,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'key'
	],
	#category : #'Sonar-Core'
}

{ #category : #accessing }
SonarEntity >> belongsTo [
	self flag: #tofix, 'by implementing the FMMultivalueLinks..'.
	^ nil
]

{ #category : #accessing }
SonarEntity >> key [
	<MSEProperty: #key type: #String> 
	<MSEComment: 'Key value of the metric'>
	^ key
]

{ #category : #accessing }
SonarEntity >> key: anObject [
	key := anObject
]
