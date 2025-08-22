*** Settings ***
Library    Browser
Variables    ../data/locators/auth_locators.py
Variables    ../data/constants/auth_constants.py
Resource   ../resources/login.resource
Suite Setup    Open SauceDemo On Browser
Suite Teardown    Close Browser


*** Test Cases ***
Standard User Should Be Able To Login
    Log In    
    Wait For Elements State    ${INVENTORY_LIST}    visible    5s

