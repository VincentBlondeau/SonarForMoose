Class {
	#name : #SonarMetric,
	#superclass : #SonarEntity,
	#instVars : [
		'description',
		'domain',
		'qualitative',
		'direction',
		'user_managed',
		'val_type',
		'hidden'
	],
	#category : #'Sonar-Core'
}

{ #category : #accessing }
SonarMetric >> description [
	<MSEProperty: #description type: #String> 
	<MSEComment: 'Description of the metric'>
	^ description 
]

{ #category : #accessing }
SonarMetric >> description: anObject [
	description := anObject
]

{ #category : #accessing }
SonarMetric >> direction [
	<MSEProperty: #direction type: #String> 
	<MSEComment: 'Direction?? of the metric'>
	^ direction
]

{ #category : #accessing }
SonarMetric >> direction: anObject [
	direction := anObject
]

{ #category : #accessing }
SonarMetric >> domain [
	<MSEProperty: #direction type: #String> 
	<MSEComment: 'Direction?? of the metric'>
	^ domain
]

{ #category : #accessing }
SonarMetric >> domain: anObject [
	domain := anObject
]

{ #category : #accessing }
SonarMetric >> hidden [
	<MSEProperty: #direction type: #String> 
	<MSEComment: 'Direction?? of the metric'>
	^ hidden
]

{ #category : #accessing }
SonarMetric >> hidden: anObject [
	hidden := anObject
]

{ #category : #printing }
SonarMetric >> mooseNameOn: aStream [
	aStream << self domain.
	aStream << ' - '.
	aStream << self name
]

{ #category : #accessing }
SonarMetric >> qualitative [
	<MSEProperty: #qualitative type: #Boolean> 
	<MSEComment: 'If the metric is qualitative'>
	^ qualitative
]

{ #category : #accessing }
SonarMetric >> qualitative: anObject [
	qualitative := anObject
]

{ #category : #accessing }
SonarMetric >> userManaged [
	<MSEProperty: #userManaged type: #String> 
	<MSEComment: 'Is the metric is user managed'>
	^ user_managed
]

{ #category : #accessing }
SonarMetric >> userManaged: anObject [
	user_managed := anObject
]

{ #category : #accessing }
SonarMetric >> valType [
	<MSEProperty: #valType type: #String> 
	<MSEComment: 'Type of the metric'>
	^ val_type
]

{ #category : #accessing }
SonarMetric >> valType: anObject [
	val_type := anObject
]
