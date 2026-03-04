Feature: Create posts data driven

Scenario Outline: Create post with Data Driven Test

Given url baseUrl + '/posts'
And request { title: '<title>', body: '<body>', userId: <userId> }
When method POST
Then status 201

Examples:
| read('classpath:data/postData.json') |