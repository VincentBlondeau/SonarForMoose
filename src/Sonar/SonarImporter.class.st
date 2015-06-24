"
I am an importer of data of Sonar www.sonarqube.org. works with Version 3.7.2

For the Responsibility part: 
I extract the data from the REST api provided by Sonar and I instanciate a Moose Model with them. I extract independently the projects and the metrics available o the sonar repository. See subclass to load the metrics values

For the Collaborators Part:
I interact with an HttpClient for the Sonar API and with the NeoJSON parser to treat the result of the request. I use the SonarEntity subclasses to fill the MooseModel.

Public API and Key Messages : see class side
- runOn: aModel * to run the importer. You can set your own httpClient to pass through authentifications.

[ [ [ 
model:=MooseModel new name: 'Sonar import'; yourself.
PAIASonarImporter runOn: model.
PAIASonarMetricImporter runOn: model withMetricsToImport: #(#ncloc #major_violations #minor_violations #critical_violations #blocker_violations #info_violations #coverage #violations_density #tests).
model install.
 ] ] ]
 
Internal Representation and Key Implementation Points.

    Instance Variables
	container:		aSonarContainer
	httpClient:		the httpClient that can be already set



"
Class {
	#name : #SonarImporter,
	#superclass : #MooseOperator,
	#instVars : [
		'container',
		'httpClient',
		'sonarStringApiUrl'
	],
	#category : #'Sonar-Importer'
}

{ #category : #running }
SonarImporter class >> on: aMooseModel sonarUrl: aUrlString [
	^ (self on: aMooseModel)
		sonarUrl: aUrlString
		
]

{ #category : #running }
SonarImporter class >> on: aMooseModel sonarUrl: aUrlString httpClient: anHttpClient [
	^ (self on: aMooseModel sonarUrl: aUrlString) httpClient: anHttpClient
]

{ #category : #running }
SonarImporter class >> runOn: aMooseModel [
	self shouldNotImplement
]

{ #category : #running }
SonarImporter class >> runOn: aMooseModel sonarUrl: aUrlString [
	^ (self on: aMooseModel sonarUrl: aUrlString) run
]

{ #category : #running }
SonarImporter class >> runOn: aMooseModel sonarUrl: aUrlString httpClient: anHttpClient [
	^ (self on: aMooseModel sonarUrl: aUrlString httpClient: anHttpClient) run
]

{ #category : #private }
SonarImporter >> basicRun [
	self importMetrics.
	self importProjects
]

{ #category : #accessing }
SonarImporter >> description [
	^ 'Sonar Data Importing'
]

{ #category : #accessing }
SonarImporter >> httpClient [
	^ httpClient
]

{ #category : #accessing }
SonarImporter >> httpClient: anObject [
	httpClient := anObject
]

{ #category : #importing }
SonarImporter >> importMetrics [
	| mapper metrics |
	mapper := self jsonMapperOnRessourceNamed: 'metrics'.
	self map: mapper forClass: SonarMetric.
	self map: mapper collectionNamed: #OrderedCollectionOfMetrics withElement: SonarMetric.
	metrics := mapper nextAs: #OrderedCollectionOfMetrics.
	metrics do: [ :metric | self model add: metric ].
	container metrics: metrics
]

{ #category : #importing }
SonarImporter >> importProjects [
	| mapper projects |
	mapper := self jsonMapperOnRessourceNamed: 'resources'.
	self map: mapper forClass: SonarProject.
	self map: mapper collectionNamed: #OrderedCollectionOfProjects withElement: SonarProject.
	projects := mapper nextAs: #OrderedCollectionOfProjects.
	projects do: [ :project | self model add: project ].
	container projects: projects
]

{ #category : #mapping }
SonarImporter >> jsonMapperOnRessourceNamed: aString [
	^ self jsonMapperOnUrl: self sonarApiUrl / aString
]

{ #category : #mapping }
SonarImporter >> jsonMapperOnUrl: anUrl [
	| json |
	json := httpClient
		accept: ZnMimeType applicationJson;
		url: anUrl;
		get.
	^ self parser on: json readStream
]

{ #category : #accessing }
SonarImporter >> length [
	^ container rules size
]

{ #category : #mapping }
SonarImporter >> map: aMapper collectionNamed: aSymbol withElement: aClass [
	aMapper
		for: aSymbol
		customDo: [ :mapping | mapping listOfType: OrderedCollection andElementSchema: aClass ]
]

{ #category : #mapping }
SonarImporter >> map: mapper forClass: aClass [
	mapper for: aClass do: [ :mapping | mapping mapAllInstVars ]
]

{ #category : #accessing }
SonarImporter >> parser [
	^ NeoJSONReader
]

{ #category : #private }
SonarImporter >> setUp [
	httpClient := httpClient ifNil: [ ZnClient new ].
	container := SonarContainer new.
	self model add: container
]

{ #category : #accessing }
SonarImporter >> sonarApiUrl [
	^ sonarStringApiUrl asZnUrl
]

{ #category : #accessing }
SonarImporter >> sonarUrl: aString [
	sonarStringApiUrl := aString
]
