"
a comment
"
Class {
	#name : #ConfigurationOfSonar,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfSonar
}

{ #category : #'development support' }
ConfigurationOfSonar class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfSonar class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #catalog }
ConfigurationOfSonar class >> catalogChangeLog [
	"Returns a paragraph describing the most important changes in the configuration class."
	^ '- 1.0 - 24/06/2015 - first version
[[[
	ConfigurationOfSonar project version: ''1.0'' ) load					
]]]
'
]

{ #category : #catalog }
ConfigurationOfSonar class >> catalogContactInfo [
	"Returns a paragraph describing contact information such as email, mailing lists and website."
	^ 'Sonar is an amazing project. You can get in contact with our great Sonar programmer at vincent.blondeau@polytech-lille.net'
]

{ #category : #catalog }
ConfigurationOfSonar class >> catalogDescription [
	"Returns a paragraph describing the project"
	^ 'Sonar is a Moose importer of Metrics and projects available on a Sonar instance.'
]

{ #category : #catalog }
ConfigurationOfSonar class >> catalogKeyClassesAndExample [
	"Returns a paragraph or more describing the key classes of your project. You can use Pillar/Pier syntax to layout out the text i.e., ==Code== and - for bullet."
	^ 'Sonar is composed of one major key class named ==SonarImporter==. There is also ==SonarMetricImporter==
- ==SonarImporter== is the responsible for importing the metrics and the projects.
- ==SonarMetricImporter== is comming after ==SonarImporter==, to instanciate the metrics. In this way, we are able to load only the metrics we want. Each call to ==SonarMetricImporter== will add the wanted metric into the model.'
]

{ #category : #catalog }
ConfigurationOfSonar class >> catalogKeywords [
	"Returns an array of symbols"
	^ #(Moose Sonar REST client api importer json) 
]

{ #category : #private }
ConfigurationOfSonar class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfSonar class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfSonar class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfSonar class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfSonar class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfSonar class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfSonar class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfSonar class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfSonar >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec 
			project: 'BabyMock2' with: [
				spec
					className: #ConfigurationOfBabyMock2;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock2/main/' ];
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main/' ].
		spec package: #Sonar with: [
				spec requires: #('BabyMock2' 'NeoJSON' ). ].
		spec group: 'default' with: #('Sonar'). ].

]

{ #category : #accessing }
ConfigurationOfSonar >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfSonar >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.1-baseline'.

]

{ #category : #accessing }
ConfigurationOfSonar >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfSonar >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.0'.

]

{ #category : #versions }
ConfigurationOfSonar >> version10: spec [
	<version: '1.0' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0'.
		spec author: 'VincentBlondeau'.
		spec timestamp: '6/24/2015 18:13'.
		spec 
			project: 'BabyMock2' with: '2.0';
			project: 'NeoJSON' with: '10'.
		spec package: #Sonar with: #Sonar. ].

]
