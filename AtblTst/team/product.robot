*** Settings ***
Library                  SeleniumLibrary
Suite Setup              Open Browser                           ${URL}                                     ${Browser}
Suite Teardown           Close Browser
Default Tags             Shafaq

*** Variables ***
${URL}                   http://stage-app.autobill.com/
${Browser}               chrome
&{Credential}            username=implementer@34ded2f8.local    password=implementer@34ded2f8.local
&{LoginElements}         username_field_id=email                password_field_id=password
&{DashboardElement}      quick_link_xpath=/html/body/div[1]/div[2]/div[2]/span/span/img    dashboard_text_xpath=//*[@id="dashboard-graph"]/div[2]/div[1]/div/span[2]    product_list_xpath=/html/body/div[1]/div[2]/div[2]/div/ul/li[2]/span[2]
&{ProductElements}       add_product_button_xpath=//*[@id="tp-product"]/div/div[1]/div[2]/div[2]/span    product_info_text_xpath=//*[@id="tp-createEditProduct39343423482048230"]/div/form/div[1]/div[2]/div[1]/div[1]/span

*** Test Cases ***
CreateStandardProduct
    [Documentation]                        This test case creates a standard product
    Log                                    Shafaq
    Set Selenium Speed                     1 second
    Set Browser Implicit Wait              5
    LoginToAutobillKW
    Set Browser Implicit Wait              5
    Element Text Should Be                 xpath=&{DashboardElement}[dashboard_text_xpath]    Dashboard
    Click Element                          xpath=&{DashboardElement}[quick_link_xpath]
    Click Element                          xpath=&{DashboardElement}[product_list_xpath]
    Click Element                          xpath=&{ProductElements}[add_product_button_xpath]
    Element Text Should Be                 xpath=&{ProductElements}[product_info_text_xpath]    PRODUCT INFORMATION
    Input Text                             name=name                                  Standard Product
    Click Button                           Create Product
    Set Browser Implicit Wait              5

*** Keywords ***
LoginToAutobillKW
    Input Text                             id=&{LoginElements}[username_field_id]     &{Credential}[username]
    Input Text                             id=&{LoginElements}[password_field_id]     &{Credential}[password]
    Click Button                           Login
LogoutFromAutobillKW
    Click Element                          class=place-holder-image
    Click Element                          xpath=//span[contains(text(),'Logout')]