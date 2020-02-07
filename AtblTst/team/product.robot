*** Settings ***
Library                SeleniumLibrary

*** Variables ***
${URL}                 http://stage-app.autobill.com/
${Browser}             chrome
&{Credential}          username=implementer@34ded2f8.local                               password=implementer@34ded2f8.local
&{LoginElements}       username_field_id=email                                           password_field_id=password
&{DashboardElement}    quick_link_xpath=/html/body/div[1]/div[2]/div[2]/span/span/img    dashboard_text_xpath=//*[@id="dashboard-graph"]/div[2]/div[1]/div/span[2]    product_list_xpath=/html/body/div[1]/div[2]/div[2]/div/ul/li[2]/span[2]

*** Test Cases ***
CreateStandardProduct
    [Documentation]              This test case creates a standard product
    Log                          Shafaq
    Open Browser                 ${URL}                                             ${Browser}
    Set Browser Implicit Wait    5
    LoginToAutobill
    Set Browser Implicit Wait    5
    Element Text Should Be       xpath=&{DashboardElement}[dashboard_text_xpath]    Dashboard
    Click Element                xpath=&{DashboardElement}[quick_link_xpath]
    Click Element                xpath=&{DashboardElement}[product_list_xpath]
    Set Browser Implicit Wait    5
    Close Browser

*** Keywords ***
LoginToAutobill
    Input Text                   id=&{LoginElements}[username_field_id]             &{Credential}[username]
    Input Text                   id=&{LoginElements}[password_field_id]             &{Credential}[password]
    Click Button                 Login
