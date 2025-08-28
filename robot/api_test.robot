*** Settings ***
Library             RequestsLibrary

Suite Setup         Create Session
...                 alias=${SESSION_ALIAS}
...                 url=${BASE_URL}
...                 verify=True
...                 headers={"Content-Type": "application/json", "Accept": "application/json"}
Suite Teardown      Delete All Sessions

*** Variables ***
${BASE_URL}         https://automationexercise.com/api
${SESSION_ALIAS}    API_SESSION
${TEST_EMAIL}       inji123@gmail.com
${TEST_PASSWORD}    inji00

*** Test Cases ***
Get All Products List
    [Tags]    api    get
    ${response}=    GET On Session    ${SESSION_ALIAS}    /productsList
    Should Be Equal As Integers    ${response.status_code}    200
    Log    ${response.json()}

Get All Brands List
    [Tags]    api    get
    ${response}=    GET On Session    ${SESSION_ALIAS}    /brandsList
    Should Be Equal As Integers    ${response.status_code}    200
    Log    ${response.json()}

Post To All Products List
    [Tags]    api    post    negative
    ${response}=    POST On Session    ${SESSION_ALIAS}    /productsList
    Should Be Equal As Integers    ${response.status_code}    200
    ${body_text}=    Convert To String    ${response.text}
    Should Be Equal    ${body_text}    This request method is not supported
    Log    ${body_text}
    


Search Product With Valid Parameter
    [Tags]    api    post
    ${data}=    Create Dictionary    search_product=jean
    ${response}=    POST On Session    ${SESSION_ALIAS}    /searchProduct    json=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    Log    ${response.json()}

Search Product Without Parameter
    [Tags]    api    post    negative
    ${response}=    POST On Session    ${SESSION_ALIAS}    /searchProduct
    Should Be Equal As Integers    ${response.status_code}    400
    Log    ${response.json()}      

Verify Login With Valid Details
    [Tags]    api    post
    ${data}=    Create Dictionary    email=${TEST_EMAIL}    password=${TEST_PASSWORD}
    ${response}=    POST On Session    ${SESSION_ALIAS}    /verifyLogin    json=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    Log    ${response.json()}       

Verify Login Without Email Parameter
    [Tags]    api    post    negative
    ${data}=    Create Dictionary    password=${TEST_PASSWORD}
    ${response}=    POST On Session    ${SESSION_ALIAS}    /verifyLogin    json=${data}
    Should Be Equal As Integers    ${response.status_code}    400
    Log    ${response.json()}
    
Verify Login With Invalid Details
    [Tags]    api    post
    ${data}=    Create Dictionary    email=invalid@example.com    password=wrongpassword
    ${response}=    POST On Session    ${SESSION_ALIAS}    /verifyLogin    json=${data}
    Should Be Equal As Integers    ${response.status_code}    404
    Log    ${response.json()}


Create User Account
    [Tags]    api    post
    ${data}=    Create Dictionary
    ...    name=Inji Nuraliyeva
    ...    email=${TEST_EMAIL}
    ...    password=${TEST_PASSWORD}
    ...    title=Mrs
    ...    birth_date=12
    ...    birth_month=April
    ...    birth_year=2004
    ...    firstname=Inji
    ...    lastname=Nuraliyeva
    ...    company=Andersen
    ...    country=Azerbaijan
    ...    zipcode=12345
    ...    city=Baku
    ...    mobile_number=1234567890
    ${response}=    POST On Session    ${SESSION_ALIAS}    /createAccount    json=${data}
    Should Be Equal As Integers    ${response.status_code}    201
    Log    ${response.json()}

Update User Account
    [Tags]    api    put
    ${data}=    Create Dictionary
    ...    name=Inji Nuraliyeva
    ...    email=${TEST_EMAIL}
    ...    password=${TEST_PASSWORD}
    ...    title=Mrs
    ...    birth_date=12
    ...    birth_month=April
    ...    birth_year=2004
    ...    firstname=Inji
    ...    lastname=Nuraliyeva
    ...    company=Andersen
    ...    country=Azerbaijan
    ...    zipcode=12345
    ...    city=Baku
    ...    mobile_number=987654321
    ${response}=    PUT On Session    ${SESSION_ALIAS}    /updateAccount    json=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    Log    ${response.json()}

Delete User Account
    [Tags]    api    delete
    ${data}=    Create Dictionary    email=${TEST_EMAIL}    password=${TEST_PASSWORD}
    ${response}=    DELETE On Session    ${SESSION_ALIAS}    /deleteAccount    json=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    Log    ${response.json()}
