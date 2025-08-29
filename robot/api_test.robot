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

Post To All Product List
   [Tags]    api    post    negative
    ${response}=    POST On Session    ${SESSION_ALIAS}    /productsList
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal    ${response.json()["responseCode"]}    ${405}
    Should Be Equal    ${response.json()["message"]}    This request method is not supported.
    


Search Product With Valid Parameter
    [Tags]    api    post
    ${data}=    Create Dictionary    search_product=jean
    ${response}=    POST On Session    ${SESSION_ALIAS}    /searchProduct    json=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    Log    ${response.json()}

Search Product Without Parameter
    [Tags]    api    post    negative
    ${response}=    POST On Session    ${SESSION_ALIAS}    /searchProduct
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal    ${response.json()["responseCode"]}    ${400}
    Should Be Equal    ${response.json()["message"]}    Bad request, search_product parameter is missing in POST request.  

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
     Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal    ${response.json()["responseCode"]}    ${400}
    Should Be Equal    ${response.json()["message"]}    Bad request, email or password parameter is missing in POST request.


Verify Login With Invalid Details
    [Tags]    api    post
    ${data}=    Create Dictionary    email=inji1@gmail.com    password=98731324
    ${response}=    POST On Session    ${SESSION_ALIAS}    /verifyLogin    json=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal    ${response.json()["responseCode"]}    ${404}
    Should Be Equal    ${response.json()["message"]}    User not found!

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
    ...    address1=Address line 1
    ...    address2=Address line 2
    ...    country=Azerbaijan
    ...    zipcode=12345
    ...    city=Baku
    ...    mobile_number=1234567890
    ${response}=    POST On Session    ${SESSION_ALIAS}    /createAccount    json=${data}
    Should Be Equal     ${response.json()["responseCode"]}    ${201}
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
