*** Settings ***

Resource  ../../scripts/resource.robot

Test Setup  Open  ${SERVER}
Test Teardown  Close
Default Tags  matejc

*** Variables ***

${SERVER}  http://blog.matejc.com

*** Keywords ***


*** Test cases ***

Blog Home
    Location Should Be  ${SERVER}/
    Title Should Be  Matej Cotman's Blog

Blog Tags
    Click link  link=Tags
    Location Should Be  ${SERVER}/tags/
