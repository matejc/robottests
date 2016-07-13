*** Settings ***

Library  String
Library  ExtendedSelenium2Library  timeout=5.0  implicit_wait=1.0  run_on_failure=Nothing

*** Variables ***

${BROWSER}  phantomjs

*** Keywords ***

Open
    [Arguments]    ${SERVER}
    Open browser  ${SERVER}  browser=${BROWSER}

Close
    Close all browsers
