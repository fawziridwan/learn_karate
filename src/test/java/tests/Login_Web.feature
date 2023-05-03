Feature: Sign In HR Attendance


  Background:

    * def serviceURL = 'http://hr-apps-api.smtapps.net/api/v1/auth/login'

  Scenario Outline: Sign In

    Given url serviceURL
    When request {'email': '<email>','password': '<password>'}
    And method post
    And header Content-Type = 'application/json'
    And header platform = 'web'
    Then status 200
    And match responseType == 'json'
    And assert responseTime < 1500
    And print 'Response is: ', response
    And response.message == 'OK - The request was successful'

    Examples:
      |email|password|
      |hr@smooets.com|password|

  Scenario Outline: Sign In with invalid email

    Given url serviceURL
    When request {'email': '<email_invalid>','password': '<password>'}
    And method post
    And header Content-Type = 'application/json'
    And header platform = 'web'
    Then status 401
    And match responseType == 'json'
    And assert responseTime < 1500
    And print 'Response is: ', response
    And response.data.status == '001'
    And response.data.status == 'Email atau password salah'
    Examples:
      |email_invalid|password|
      |fawzi@smt-id.com|lorem|

  Scenario Outline: Sign In with invalid email format

    Given url serviceURL
    When request {'email': '<email_invalid_format>','password': '<password>'}
    And method post
    And header Content-Type = 'application/json'
    And header platform = 'web'
    Then status 400
    And match responseType == 'json'
    And assert responseTime < 1500
    And print 'Response is: ', response
    And response.status == 400
    And response.data.message == 'You must give the valid email'
    Examples:
      |email_invalid_format|password|
      |fawzi.smt-id.com|lorem|