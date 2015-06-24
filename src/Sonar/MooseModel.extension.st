Extension { #name : #MooseModel }

{ #category : #'*Sonar' }
MooseModel >> allSonarMetrics [
	<MSEProperty: #allSonarMetrics type: #SonarMetric> <multivaried>
	<MSEComment: 'All metrics of the Sonar repo'>
	^ self allWithType: SonarMetric
]

{ #category : #'*Sonar' }
MooseModel >> allSonarProjects [
	<MSEProperty: #allSonarProjects type: #SonarProject> <multivaried>
	<MSEComment: 'All projects of the Sonar repo'>
	^ self allWithType: SonarProject
]

{ #category : #'*Sonar' }
MooseModel >> sonarContainer [
	<MSEProperty: #sonarContainer type: #SonarContainer >
	<MSEComment: 'The Sonar elements root'>
	^ self allWithType: SonarContainer
]
