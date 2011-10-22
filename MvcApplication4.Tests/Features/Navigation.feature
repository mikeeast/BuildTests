Feature: Navigation
	In order to use the system
	As a user
	I want to see the Home page

@mytag
Scenario: Navigation to the Home page
	When navigating to /
	Then the page title should be Home Page

Scenario: Navigation to the About page
	Given that I am on the Home Page
	When navigating to /Home/About
	Then the page title should be About Us