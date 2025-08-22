*** Settings ***
Library    Browser
Resource   ../resources/add_items.resource
Suite Setup    Open SauceDemo On Browser
Suite Teardown    Close Browser


*** Test Cases ***
Standard User Should Add All Items To Cart
    Log In
    Add All Items To Cart
    Go To Cart
    Check All Items In Cart


    