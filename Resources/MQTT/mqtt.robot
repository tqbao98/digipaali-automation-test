*** Settings ***
Library          MQTTLibrary
Library  String

*** Variables ***


*** Keywords ***
Broker runs
    Connect  ${BROKER}  ${PORT}  ${CLIENT_ID}  clean_session=True

Test messages
    publish  hello  world  qos=0  retain=False

Broker stops
    disconnect

Send rfid tags
    ${epc} =  generate random string  24  [NUMBERS][UPPER]
    publish  	nurapisample/epc  {"id":"${epc}"}  qos=0  retain=False

Listen for location path msg
    ${msg} =  subscribe  outTopic3  0  timeout=11  limit=0
    should not be empty  ${msg}
