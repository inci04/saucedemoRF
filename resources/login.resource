
*** Settings ***
Library    Browser
Variables    ../data/constants/auth_constants.py
Variables    ../data/locators/auth_locators.py
Variables    ../data/constants/products_constants.py
Variables    ../data/locators/products_locators.py


*** Keywords ***

Open SauceDemo On Browser
    New Browser    browser=chromium
    ...    headless=False
    ...    slowMo=1s
    ...    timeout=30s
    New Context    tracing=True
    ...    viewport={"width": 1280, "height": 720}
    ...    defaultBrowserType=chromium
    New Page    ${CONSTANTS_START_URL}

Log In
    Fill Text    ${LOCATORS_AUTH_USERNAME}    ${CONSTANTS_USERNAME}
    Fill Text    ${LOCATORS_AUTH_PASSWORD}    ${CONSTANTS_PASSWORD}
    Click        ${LOCATORS_AUTH_LOGIN_BUTTON}
    
