Class {
	#name : #SonarContainer,
	#superclass : #SonarEntity,
	#instVars : [
		'issues',
		'rules',
		'metrics',
		'projects'
	],
	#category : #'Sonar-Core'
}

{ #category : #accessing }
SonarContainer >> metrics [
	<MSEProperty: #metrics type: #SonarMetric> <multivalued> 
	<MSEComment: 'List of metrics available in Sonar.'>
	^ metrics asMooseGroup 
]

{ #category : #accessing }
SonarContainer >> metrics: aCollection [ 
	metrics := aCollection
]

{ #category : #accessing }
SonarContainer >> projects [
	<MSEProperty: #projects type: #SonarProject> <multivalued>
	<MSEComment: 'Please put a comment'>
	^ projects asMooseGroup
]

{ #category : #accessing }
SonarContainer >> projects: anObject [
	projects := anObject
]
