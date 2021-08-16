Feature: sample karate test script
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  @demo1
  Scenario: create a user and then get it by id
    * def response = call read('classpath:examples/library.feature@getusers')

  @demo2
  Scenario: create a user and then get it by id
    * def response = call read('classpath:examples/library.feature@getusers')

  @demo3
  Scenario: create a user and then get it by id
    * def response = call read('classpath:examples/library.feature@getusers')
