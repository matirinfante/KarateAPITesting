Feature: User is able to book a room

  Background: Setup the base path
    Given url 'https://automationintesting.online'
    * def token = ''
    * def firstName = 'nameParam'
    * def lastName = 'lastParam'
    * def checkIn = '2022-12-15'
    * def checkOut = '2022-12-18'

    Given path '/auth/login/'
    * def body = {username:  "admin", password:  "password"}
    And request body
    When method post
    Then status 200
    And def token = responseCookies.token.value

  Scenario: Get rooms registered
    Given path '/room/'
    When method get
    Then status 200
    And print response


  Scenario: Get rooms registered, pick the first one and book it
    Given path '/room/'
    When method get
    Then status 200
    And def roomId = response.rooms[0].roomid

    Given path '/booking', '/'
    * def body = {bookingdates: { checkin: "2022-12-30", checkout: "2022-12-31" },depositpaid: true,firstname: "TestName",lastname: "TestLast",roomid: "#(roomId)",totalprice: 0}
    And header Accept = 'application/json'
    And request body
    When method post
    Then status 201
    And print response

  Scenario: Get rooms registered, pick the first one and book it with parametrized payload
    Given path '/room/'
    When method get
    Then status 200
    And def roomId = response.rooms[0].roomid

    Given path '/booking', '/'
    * def body = {bookingdates: { checkin: "#(checkIn)", checkout: "#(checkOut)" },depositpaid: true,firstname: "#(firstName)",lastname: "#(lastName)",roomid: "#(roomId)",totalprice: 0}
    And header Accept = 'application/json'
    And request body
    When method post
    Then status 201
    And match response.bookingid == '#number'
    And print response