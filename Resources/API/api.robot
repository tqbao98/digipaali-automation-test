*** Settings ***
Library  RequestsLibrary

*** Variables ***


*** Keywords ***
Checks if new baleID has been made
    ${res} =  GET request and verify response  test  200
    should not be empty  ${res}[timenow]
    set global variable  ${PREVIOUS_CONTEXT}  ${res}

Check tags id in "context"
    Check array increments  arr  2

Check paths in "context"
    Check array increments  arr2  1

Check baleData
    ${res} =  GET request and verify response  baleData  200
    #log  ${res}[data][baleId][0]
    #log  ${PREVIOUS_CONTEXT}[timenow]
    should be equal as strings  ${PREVIOUS_CONTEXT}[timenow]  ${res}[data][baleId][0]

Check if another baleId has been made
    ${res} =  GET request and verify response  test  200
    should not be empty  ${res}[timenow]
    should not be equal as strings  ${PREVIOUS_CONTEXT}[timenow]  ${res}[timenow]
    log  ${PREVIOUS_CONTEXT}[timenow]
    log  ${res}[timenow]
    set global variable  ${PREVIOUS_CONTEXT}  ${res}

GET request and verify response
    [Arguments]  ${uri}  ${status_code}
    create session  my_session  ${UI_URL}
    ${res} =  get request  my_session  ${uri}
    should be equal as strings  ${res.status_code}  ${status_code}
    ${json} =  set variable  ${res.json()}
    return from keyword  ${json}

Check array increments
    [Arguments]  ${array}  ${starting_number}
    ${res} =  GET request and verify response  test  200
    ${res_length} =  get length  ${res}[${array}]
    ${pre_length} =  run keyword and ignore error  get length  ${PREVIOUS_CONTEXT}[${array}]
    run keyword unless  '${pre_length[0]}' == 'PASS'  should be true  ${res_length}>=${starting_number}
    run keyword if  '${pre_length[0]}' == 'PASS'  should be true  ${res_length}>=${pre_length[1]+1}
    set global variable  ${PREVIOUS_CONTEXT}  ${res}
