Feature: Create post with transformed data

  @smoke
  Scenario Outline: Create post advance with datatable wint print

    Given url baseUrl + '/posts'
    And request { title: <title>, body: <body>, userId: <userId>, timestamp: <timestamp> }

    * print 'REQUEST:', request

    When method POST

    * print 'RESPONSE:', response

    Then status 201

    Examples:
      | title | body  | userId | timestamp |
      | test1 | body1 | 1      | 123       |