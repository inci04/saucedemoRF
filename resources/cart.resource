*** Settings ***    
Library    Browser
Library    String
Variables    ../data/locators/cart_locators.py
Resource   ../resources/add_items.resource



*** Keywords ***
Handle Cart Items By Price
    Log In
    Add All Items To Cart
    Go To Cart
    ${items}=    Get Elements    ${LOCATOR_CART_ITEM}
    ${count}=    Get Length    ${items}
    FOR    ${index}    IN RANGE    ${count}-1    -1    -1
        ${price_text}=    Get Text    ${LOCATOR_CART_ITEM} >> nth=${index} >> ${LOCATOR_CART_ITEM_PRICE}
        ${price_text}=    Replace String    ${price_text}    $    ${EMPTY}
        ${price_text}=    Replace String    ${price_text}    "    ${EMPTY}
        ${price}=    Convert To Number    ${price_text}
        IF    ${price} < 20
            Log To Console    Item price ${price} < 20 -> keeping in cart
        ELSE
            ${remove_btn}=    Get Element    ${LOCATOR_CART_ITEM} >> nth=${index} >> ${LOCATOR_CART_REMOVE_BTN}
            Click    ${remove_btn}
            Log To Console    Item price ${price} > 20 -> removed from cart
        END
    END

