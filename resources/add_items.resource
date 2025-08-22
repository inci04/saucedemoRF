*** Settings ***    
Library    Browser
Variables    ../data/locators/products_locators.py
Variables    ../data/constants/products_constants.py
Resource   ../resources/login.resource


*** Keywords ***
Add All Items To Cart
    ${buttons}=    Get Elements    ${LOCATOR_ADD_TO_CART_BTN}
    ${count}=    Get Length    ${buttons}
    FOR    ${index}    IN RANGE    ${count}
        Click    ${buttons}[${index}]
        Wait For Elements State    ${LOCATOR_CART_BADGE}    visible    5s
        ${badge}=    Get Text    ${LOCATOR_CART_BADGE}
        Should Be Equal As Integers   ${badge}    ${index + 1}
    END

Go To Cart
    Click    ${LOCATOR_CART_CONTAINER}

Check All Items In Cart
    ${items}=    Get Elements    ${LOCATOR_ITEM_LIST}

  
