Class {
	#name : #SonarTests,
	#superclass : #BabyMock2TestCase,
	#instVars : [
		'httpClient',
		'model',
		'state'
	],
	#category : #'Sonar-Tests'
}

{ #category : #asserts }
SonarTests >> documentationAsserts [
	| m |
	m := model allSonarMetrics entityNamed: 'Documentation - Comments (%)'.
	self assert: (m isKindOf: SonarMetric).
	self assert: m key equals: 'comment_lines_density'.
	self assert: m description equals: 'Comments balanced by ncloc + comment lines'.
	self assert: m domain equals: 'Documentation'.
	self assert: m qualitative equals: true.
	self assert: m userManaged equals: false.
	self assert: m direction equals: 1.
	self assert: m valType equals: 'PERCENT'.
	self assert: m hidden equals: false
]

{ #category : #mocking }
SonarTests >> instanciateRessourcesMocksWithMetricsCombined [
	protocol describe
		allow: httpClient recv: #url:;
		with: 'https://mysonarurl/sonar/api/resources?metrics=ncloc,violations&resource=873243' asZnUrl;
		then: state is: #resources873243;
		allow: httpClient recv: #get;
		=> self jsonProject1WithMetrics;
		when: state is: #resources873243.
	protocol describe
		allow: httpClient recv: #url:;
		with: 'https://mysonarurl/sonar/api/resources?metrics=ncloc,violations&resource=792927' asZnUrl;
		then: state is: #resources792927;
		allow: httpClient recv: #get;
		=> self jsonProject2WithMetrics;
		when: state is: #resources792927
]

{ #category : #running }
SonarTests >> instanciateRessourcesMocksWithMetricsSeparated [
	protocol describe
		allow: httpClient recv: #url:;
		with: 'https://mysonarurl/sonar/api/resources?metrics=ncloc&resource=873243' asZnUrl;
		then: state is: #resources873243nloc;
		allow: httpClient recv: #get;
		=> self jsonProject1WithNlocMetric;
		when: state is: #resources873243nloc.
	protocol describe
		allow: httpClient recv: #url:;
		with: 'https://mysonarurl/sonar/api/resources?metrics=ncloc&resource=792927' asZnUrl;
		then: state is: #resources792927nloc;
		allow: httpClient recv: #get;
		=> self jsonProject2WithNlocMetric;
		when: state is: #resources792927nloc.
	protocol describe
		allow: httpClient recv: #url:;
		with: 'https://mysonarurl/sonar/api/resources?metrics=violations&resource=873243' asZnUrl;
		then: state is: #resources873243Violations;
		allow: httpClient recv: #get;
		=> self jsonProject1WithViolationsMetric;
		when: state is: #resources873243Violations.
	protocol describe
		allow: httpClient recv: #url:;
		with: 'https://mysonarurl/sonar/api/resources?metrics=violations&resource=792927' asZnUrl;
		then: state is: #resources792927Violations;
		allow: httpClient recv: #get;
		=> self jsonProject2WithViolationsMetric;
		when: state is: #resources792927Violations
]

{ #category : #'data mocks' }
SonarTests >> jsonMetrics [
	^ '[
        {
            "key": "comment_lines_density",
            "name": "Comments (%)",
            "description": "Comments balanced by ncloc + comment lines",
            "domain": "Documentation",
            "qualitative": true,
            "user_managed": false,
            "direction": 1,
            "val_type": "PERCENT",
            "hidden": false
        },
        {
            "key": "violations",
            "name": "Issues",
            "description": "Issues",
            "domain": "Issues",
            "qualitative": true,
            "user_managed": false,
            "direction": -1,
            "val_type": "INT",
            "hidden": false
        },
        {
            "key": "branch_coverage",
            "name": "Branch coverage",
            "description": "Branch coverage",
            "domain": "Tests",
            "qualitative": true,
            "user_managed": false,
            "direction": 1,
            "val_type": "PERCENT",
            "hidden": false
        },
        {
            "key": "profile",
            "name": "Profile",
            "description": "Selected quality profile",
            "domain": "General",
            "qualitative": false,
            "user_managed": false,
            "direction": 0,
            "val_type": "DATA",
            "hidden": false
        },
        {
            "key": "violations_density",
            "name": "Rules compliance",
            "description": "Rules compliance",
            "domain": "Issues",
            "qualitative": true,
            "user_managed": false,
            "direction": 1,
            "val_type": "PERCENT",
            "hidden": false
        },
        {
            "key": "ncloc",
            "name": "Lines of code",
            "description": "Non Commenting Lines of Code",
            "domain": "Size",
            "qualitative": false,
            "user_managed": false,
            "direction": -1,
            "val_type": "INT",
            "hidden": false
        },
        {
            "key": "major_violations",
            "name": "Major issues",
            "description": "Major issues",
            "domain": "Issues",
            "qualitative": true,
            "user_managed": false,
            "direction": -1,
            "val_type": "INT",
            "hidden": false
        }
    ]'
]

{ #category : #'data mocks' }
SonarTests >> jsonProject1WithMetrics [
	^ '	[
    {
        "id": 873243,
        "key": "net.proj:project1",
        "name": "project1",
        "scope": "PRJ",
        "qualifier": "TRK",
        "date": "2015-06-24T10:51:15+0200",
        "creationDate": "2015-01-23T18:07:43+0100",
        "lname": "project1",
        "lang": "java",
        "version": "3.0",
        "description": "project1",
        "msr":
        [
            {
                "key": "ncloc",
                "val": 12511,
                "frmt_val": "12,511"
            },
            {
                "key": "violations",
                "val": 685,
                "frmt_val": "685"
            }
        ]
    }]'
]

{ #category : #'data mocks' }
SonarTests >> jsonProject1WithNlocMetric [
	^ '	[
    {
        "id": 873243,
        "key": "net.proj:project1",
        "name": "project1",
        "scope": "PRJ",
        "qualifier": "TRK",
        "date": "2015-06-24T10:51:15+0200",
        "creationDate": "2015-01-23T18:07:43+0100",
        "lname": "project1",
        "lang": "java",
        "version": "3.0",
        "description": "project1",
        "msr":
        [
            {
                "key": "ncloc",
                "val": 12511,
                "frmt_val": "12,511"
            }
        ]
    }]'
]

{ #category : #'data mocks' }
SonarTests >> jsonProject1WithViolationsMetric [
	^ '	[
    {
        "id": 873243,
        "key": "net.proj:project1",
        "name": "project1",
        "scope": "PRJ",
        "qualifier": "TRK",
        "date": "2015-06-24T10:51:15+0200",
        "creationDate": "2015-01-23T18:07:43+0100",
        "lname": "project1",
        "lang": "java",
        "version": "3.0",
        "description": "project1",
        "msr":
        [
            {
                "key": "violations",
                "val": 685,
                "frmt_val": "685"
            }
        ]
    }]'
]

{ #category : #'data mocks' }
SonarTests >> jsonProject2WithMetrics [
	^ '	[
    {
        "id": 792927,
        "key": "net.proj:project2",
        "name": "project2",
        "scope": "PRJ",
        "qualifier": "TRK",
        "date": "2015-06-12T22:18:02+0200",
        "creationDate": "2014-11-13T09:03:56+0100",
        "lname": "project2",
        "lang": "java",
        "version": "1.0",
        "description": "",
        "msr":
        [
            {
                "key": "ncloc",
                "val": 16629,
                "frmt_val": "16,629"
            },
            {
                "key": "violations",
                "val": 3673,
                "frmt_val": "3,673"
            }
        ]
    }]'
]

{ #category : #'data mocks' }
SonarTests >> jsonProject2WithNlocMetric [
	^ '	[
    {
        "id": 792927,
        "key": "net.proj:project2",
        "name": "project2",
        "scope": "PRJ",
        "qualifier": "TRK",
        "date": "2015-06-12T22:18:02+0200",
        "creationDate": "2014-11-13T09:03:56+0100",
        "lname": "project2",
        "lang": "java",
        "version": "1.0",
        "description": "",
        "msr":
        [
            {
                "key": "ncloc",
                "val": 16629,
                "frmt_val": "16,629"
            }
        ]
    }]'
]

{ #category : #'data mocks' }
SonarTests >> jsonProject2WithViolationsMetric [
	^ '	[
    {
        "id": 792927,
        "key": "net.proj:project2",
        "name": "project2",
        "scope": "PRJ",
        "qualifier": "TRK",
        "date": "2015-06-12T22:18:02+0200",
        "creationDate": "2014-11-13T09:03:56+0100",
        "lname": "project2",
        "lang": "java",
        "version": "1.0",
        "description": "",
        "msr":
        [
            {
                "key": "violations",
                "val": 3673,
                "frmt_val": "3,673"
            }
        ]
    }]'
]

{ #category : #'data mocks' }
SonarTests >> jsonProjects [
	^ '	[
    {
        "id": 873243,
        "key": "net.proj:project1",
        "name": "project1",
        "scope": "PRJ",
        "qualifier": "TRK",
        "date": "2015-06-24T10:51:15+0200",
        "creationDate": "2015-01-23T18:07:43+0100",
        "lname": "project1",
        "lang": "java",
        "version": "3.0",
        "description": "project1"
    },
	 {
        "id": 792927,
        "key": "net.proj:project2",
        "name": "project2",
        "scope": "PRJ",
        "qualifier": "TRK",
        "date": "2015-06-12T22:18:02+0200",
        "creationDate": "2014-11-13T09:03:56+0100",
        "lname": "project2",
        "lang": "java",
        "version": "1.0",
        "description": ""
	}]'
]

{ #category : #asserts }
SonarTests >> p1Asserts [
	| p |
	p := model allSonarProjects entityNamed: 'project1'.
	self assert: (p isKindOf: SonarProject).
	self assert: p key equals: 'net.proj:project1'.
	self assert: p lang equals: 'java'.
	self assert: p qualifier equals: 'TRK'.
	self assert: p scope equals: 'PRJ'.
	self assert: p version equals: '3.0'
]

{ #category : #asserts }
SonarTests >> p2Asserts [
	| p |
	p := model allSonarProjects entityNamed: 'project2'.
	self assert: (p isKindOf: SonarProject).
	self assert: p key equals: 'net.proj:project2'.
	self assert: p lang equals: 'java'.
	self assert: p qualifier equals: 'TRK'.
	self assert: p scope equals: 'PRJ'.
	self assert: p version equals: '1.0'
]

{ #category : #running }
SonarTests >> setUp [
	httpClient := protocol mock: 'httpClient'.
	state := protocol states: 'machine state' startsAs: #ready.
	protocol describe allow: httpClient recv: #accept:.
	protocol describe
		allow: httpClient recv: #url:;
		with: 'https://mysonarurl/sonar/api/metrics' asZnUrl;
		then: state is: #metrics;
		allow: httpClient recv: #get;
		=> self jsonMetrics;
		when: state is: #metrics.
	protocol describe
		allow: httpClient recv: #url:;
		with: 'https://mysonarurl/sonar/api/resources' asZnUrl;
		then: state is: #resources;
		allow: httpClient recv: #get;
		=> self jsonProjects;
		when: state is: #resources.
	self instanciateRessourcesMocksWithMetricsCombined.
	self instanciateRessourcesMocksWithMetricsSeparated.
	model := MooseModel new
]

{ #category : #asserts }
SonarTests >> sizeAsserts [
	| m |
	m := model allSonarMetrics entityNamed: 'Size - Lines of code'.
	self assert: (m isKindOf: SonarMetric).
	self assert: m key equals: 'ncloc'.
	self assert: m description equals: 'Non Commenting Lines of Code'.
	self assert: m domain equals: 'Size'.
	self assert: m qualitative equals: false.
	self assert: m userManaged equals: false.
	self assert: m direction equals: -1.
	self assert: m valType equals: 'INT'.
	self assert: m hidden equals: false
]

{ #category : #tests }
SonarTests >> testImportMetricsAndProjects [
	SonarImporter runOn: model sonarUrl: 'https://mysonarUrl/sonar/api' httpClient: httpClient.
	self assert: model allSonarProjects size equals: 2.
	self p1Asserts.
	self p2Asserts.
	self assert: model allSonarMetrics size equals: 7.
	self documentationAsserts.
	self sizeAsserts.
]

{ #category : #tests }
SonarTests >> testImportMetricsAndProjectsAndMetricsInstanciation [
	| p1 p2 |
	SonarImporter runOn: model sonarUrl: 'https://mysonarUrl/sonar/api' httpClient: httpClient.
	SonarMetricImporter
		runOn: model
		sonarUrl: 'https://mysonarUrl/sonar/api'
		httpclient: httpClient
		metricsToImport: #(#ncloc #violations).
	self assert: model allSonarProjects size equals: 2.
	self p1Asserts.
	self p2Asserts.
	self assert: model allSonarMetrics size equals: 7.
	self documentationAsserts.
	self sizeAsserts.
	p1 := model allSonarProjects entityNamed: 'project1'.
	p2 := model allSonarProjects entityNamed: 'project2'.
	self assert: p1 metrics size equals: 2.
	self assert: p2 metrics size equals: 2.
	self assert: (p1 metrics at: 'ncloc') equals: 12511.
	self assert: (p2 metrics at: 'ncloc') equals: 16629.
	self assert: (p1 metrics at: 'violations') equals: 685.
	self assert: (p2 metrics at: 'violations') equals: 3673
]

{ #category : #tests }
SonarTests >> testImportMetricsAndProjectsAndMetricsInstanciationInTwoSteps [
	| p1 p2 |
	SonarImporter runOn: model sonarUrl: 'https://mysonarUrl/sonar/api' httpClient: httpClient.
	p1 := model allSonarProjects entityNamed: 'project1'.
	p2 := model allSonarProjects entityNamed: 'project2'.
	SonarMetricImporter
		runOn: model
		sonarUrl: 'https://mysonarUrl/sonar/api'
		httpclient: httpClient
		metricsToImport: #(#violations).
	self assert: p1 metrics size equals: 1.
	self assert: p2 metrics size equals: 1.
	self assert: (p1 metrics at: 'violations') equals: 685.
	self assert: (p2 metrics at: 'violations') equals: 3673.
	SonarMetricImporter
		runOn: model
		sonarUrl: 'https://mysonarUrl/sonar/api'
		httpclient: httpClient
		metricsToImport: #(#ncloc).
	self assert: model allSonarProjects size equals: 2.
	self p1Asserts.
	self p2Asserts.
	self assert: model allSonarMetrics size equals: 7.
	self documentationAsserts.
	self sizeAsserts.
	self assert: p1 metrics size equals: 2.
	self assert: p2 metrics size equals: 2.
	self assert: (p1 metrics at: 'ncloc') equals: 12511.
	self assert: (p2 metrics at: 'ncloc') equals: 16629.
	self assert: (p1 metrics at: 'violations') equals: 685.
	self assert: (p2 metrics at: 'violations') equals: 3673
]
