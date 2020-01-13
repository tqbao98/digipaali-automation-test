*** Settings ***
Resource  ./PO/Landing.robot
Resource  ./PO/NodeRed.robot

*** Variables ***


*** Keywords ***
User should be able to access Nodered page
    NodeRed.Navigate to Nodered
    NodeRed.is accesible

User should be able to access landing page
    Landing.Navigate to UI
    Landing.is accesible

Press "upload"
    Landing.Press "upload" button