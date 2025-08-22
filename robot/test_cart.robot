*** Settings ***
Library    Browser
Resource   ../resources/cart.resource
Suite Setup    Open SauceDemo On Browser
Suite Teardown    Close Browser

*** Test Cases ***
Modify Cart Based On Price
    Handle Cart Items By Price
    Check All Items In Cart
 