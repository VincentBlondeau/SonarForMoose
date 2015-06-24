"
Import metrics once the metrics an project are imported on the moose model

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State the name of the class with one line description: For example, I'm xxx the root of the hierarchy of visitor objects.

For the Responsibility part: Three sentences about my main responsibility, what I'm doing, what services do I offer.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- what is the way to create instances is a plus.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	container:		<Object>
	httpClient:		<Object>


    Implementation Points
"
Class {
	#name : #SonarMetricImporter,
	#superclass : #SonarImporter,
	#instVars : [
		'metrics'
	],
	#category : #'Sonar-Importer'
}

{ #category : #running }
SonarMetricImporter class >> runOn: aMooseModel sonarUrl: aStringUrl httpclient: anHttpClient metricsToImport: aCollectionOfMetricIds [
	^ (self on: aMooseModel sonarUrl: aStringUrl httpClient: anHttpClient)
		metrics: aCollectionOfMetricIds;
		run
]

{ #category : #running }
SonarMetricImporter class >> runOn: aMooseModel sonarUrl: aStringUrl metricsToImport: aCollectionOfMetricIds [
	^ (self on: aMooseModel sonarUrl: aStringUrl)
		metrics: aCollectionOfMetricIds;
		run
]

{ #category : #private }
SonarMetricImporter >> basicRun [
	self checkMetrics.
	self importMetricsForEachProject
]

{ #category : #checking }
SonarMetricImporter >> checkMetrics [
	| modelMetrics |
	self assert: (self metrics isCollection and: [ self metrics isNotEmpty ]).
	modelMetrics := self model allSonarMetrics collect: #key.
	(modelMetrics includesAll: self metrics)
		ifFalse: [ NotFound signalFor: self metrics in: modelMetrics ]
]

{ #category : #importing }
SonarMetricImporter >> importMetricValue: aCollection inProject: aSonarProject [
	| key value |
	key := aCollection at: 'key'.
	value := aCollection
		at:
			(key = 'profile'
				ifTrue: [ 'data' ]
				ifFalse: [ 'val' ]). "hack with profile data field"
	aSonarProject metrics at: key put: value
]

{ #category : #importing }
SonarMetricImporter >> importMetricsForAProject: aSonarProject [
	| metricsQuery jsonMapper |
	metricsQuery := ',' join: self metrics.
	jsonMapper := self
		jsonMapperOnUrl: self sonarApiUrl / 'resources' ? ('resource' -> aSonarProject id) & ('metrics' -> metricsQuery).
	self map: jsonMapper collectionNamed: #CollectionOfRessources withElement: #Ressource.
	jsonMapper
		for: #Ressource
		customDo: [ :mapping | 
			mapping
				decoder: [ :string | (string at: 'msr') do: [ :dict | self importMetricValue: dict inProject: aSonarProject ] ] ].
	jsonMapper nextAs: #CollectionOfRessources
]

{ #category : #importing }
SonarMetricImporter >> importMetricsForEachProject [
	self model allSonarProjects do: [ :aProject | self importMetricsForAProject: aProject ]
]

{ #category : #accessing }
SonarMetricImporter >> metrics [
	^ metrics
]

{ #category : #accessing }
SonarMetricImporter >> metrics: aCollectionOfMetricIds [
	metrics := aCollectionOfMetricIds 
	
]
