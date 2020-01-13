*** Settings ***
Library  SeleniumLibrary

*** Variables ***


*** Keywords ***
Navigate to Nodered
    go to  ${NODERED_URL}

is accesible
    Title Should Be  Node-RED