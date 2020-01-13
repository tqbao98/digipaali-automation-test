*** Settings ***
Library  SeleniumLibrary

*** Variables ***


*** Keywords ***
Suite set up
    Open Browser  about:blank  ${BROWSER}

Suite tear down
    Close Browser