*** Settings ***
Library  SeleniumLibrary

*** Variables ***


*** Keywords ***
Navigate to UI
    go to  ${UI_URL}

is accesible
    Title Should Be  DigiPaali Map

Press "upload" button
    click button  //*[@id="upload"]
    #sleep  3s