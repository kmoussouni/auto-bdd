Feature: Home page
    Scenario: See welcome text
        When I go to "/"
        Then the response status code should be 200
        And the page should contain "Welcome to Auto-BDD"
        And the page should contain "Titre"
