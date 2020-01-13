*** Settings ***
Documentation  Testing digipaali device work flows - Scenario: No canbus/weight/ending signal, DM sensor installed
Resource  ../Resources/Common.robot
Resource  ../Resources/DPapp.robot
Resource  ../Resources/MQTT/mqtt.robot
Resource  ../Resources/API/api.robot

Suite Setup  Common.Suite set up
Suite Teardown  Common.Suite tear down

*** Variables ***
${UI_URL} =  http://localhost:5000
${NODERED_URL} =  http://localhost:1880
${BROWSER} =  chrome
${BROKER} =  localhost
${PORT} =  1883
${CLIENT_ID} =  test_client
${PREVIOUS_CONTEXT}
${CURRENT_CONTEXT}

*** Test Cases ***
Nodered starts automatically
    [Documentation]  NodeRED runs
    DPapp.User should be able to access Nodered page

Backend starts automatically
    [Documentation]  Web app and backend runs
    DPapp.User should be able to access landing page

MQTT broker starts automatically
    [Documentation]  MQTT broker runs and can be connected to
    mqtt.Broker runs
    mqtt.Test messages

First bale started
    [Documentation]  System makes a new baleID
    api.Checks if new baleID has been made

Rfid tags are processed correctly
    [Documentation]  Sends a tag id to broker and check if system processes properly
    mqtt.Send rfid tags
    api.Check tags id in "context"

Location path is sent
    [Documentation]  Wait until receiving mqtt msg under topic "outTopic3", checks that it is saved in "context"
    mqtt.Listen for location path msg
    api.Check paths in "context"

"Upload" button sends trigger to backend
    [Documentation]  Simulate button pressing, check if signal is sent, check that arduino sends data
    # fails if websocket not working (prob PWA service worker) or arduino not responding
    DPapp.Press "upload"
    api.Check baleData

System is started over
    [Documentation]  System makes a new baleID
    [Tags]  Current
    api.Check if another baleId has been made