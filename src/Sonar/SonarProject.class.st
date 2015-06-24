Class {
	#name : #SonarProject,
	#superclass : #SonarEntity,
	#instVars : [
		'id',
		'scope',
		'qualifier',
		'lang',
		'version',
		'date',
		'creationDate',
		'metrics'
	],
	#category : #'Sonar-Core'
}

{ #category : #accessing }
SonarProject >> creationDate [
	<MSEProperty: #creationDate type: #String>
	<MSEComment: 'Please put a comment'>
	^ creationDate
]

{ #category : #accessing }
SonarProject >> creationDate: anObject [
	creationDate := anObject
]

{ #category : #accessing }
SonarProject >> date [
	<MSEProperty: #date type: #String>
	<MSEComment: 'Please put a comment'>
	^ date
]

{ #category : #accessing }
SonarProject >> date: anObject [
	date := anObject
]

{ #category : #accessing }
SonarProject >> id [
	<MSEProperty: #id type: #Number>
	<MSEComment: 'Please put a comment'>
	^ id
]

{ #category : #accessing }
SonarProject >> id: anObject [
	id := anObject
]

{ #category : #accessing }
SonarProject >> initialize [
	super initialize.
	metrics := Dictionary new.
]

{ #category : #accessing }
SonarProject >> lang [
	<MSEProperty: #lang type: #String>
	<MSEComment: 'Please put a comment'>
	^ lang
]

{ #category : #accessing }
SonarProject >> lang: anObject [
	lang := anObject
]

{ #category : #accessing }
SonarProject >> metrics [
	^ metrics
]

{ #category : #accessing }
SonarProject >> metricsValues [
	<MSEProperty: #metricsValues type: #String>
	<MSEComment: 'Please put a comment'>
	^ self metrics asString
]

{ #category : #accessing }
SonarProject >> mooseNameOn: aStream [
	aStream << self name
]

{ #category : #accessing }
SonarProject >> qualifier [
	<MSEProperty: #qualifier type: #String>
	<MSEComment: 'Please put a comment'>
	^ qualifier
]

{ #category : #accessing }
SonarProject >> qualifier: anObject [
	qualifier := anObject
]

{ #category : #accessing }
SonarProject >> scope [
	<MSEProperty: #scope type: #String>
	<MSEComment: 'Please put a comment'>
	^ scope
]

{ #category : #accessing }
SonarProject >> scope: anObject [
	scope := anObject
]

{ #category : #accessing }
SonarProject >> version [
	<MSEProperty: #version type: #String>
	<MSEComment: 'Please put a comment'>
	^ version
]

{ #category : #accessing }
SonarProject >> version: anObject [
	version := anObject
]
