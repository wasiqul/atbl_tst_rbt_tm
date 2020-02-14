*** Settings ***
Library                             SeleniumLibrary 
Library                             String       
Suite Setup                         Open Browser    ${url}   ${browser}
Suite Teardown                      Close Browser
Default Tags                        Wasiqul

*** Variables ***
${url}                              http://stage-app.autobill.com/
&{credential}                       username=implementer@6e3f9004.local    password=implementer@6e3f9004.local
${browser}                          chrome

*** Keywords ***
LoginKW
    Input Text                      id=email        &{credential}[username]  
    Input Password                  id=password     &{credential}[password]
    Click Button                    class=login-button  
    Element Text Should Be          xpath=//span[@class='dashboard-title']    Dashboard    
    
LogoutKW
    Click Element                   class=place-holder-image 
    Click Element                   xpath=//span[contains(text(),'Logout')]   
    Element Text Should Be          xpath=//div[@class='admin-login']    Sign In
    
CreateAccountKW
    ${email-number}                 Generate Random String  8  [NUMBERS]
    [Return]                        ${email-number}
    
    Click Element                   xpath=//span[@class='icon lnr lnr-plus-circle']
    Click Element                   xpath=//li[@class='new-item create-new-account-link skip-ajax-validation tab-opener']//span[@class='new-text'][contains(text(),'Account')]   
    Input Text                      name=name    WasiqulAutobot    
    Input Text                      name=emailAddress    abc${email-number}@yopmail.com
    Click Button                    xpath=//button[@class='submit-button common-tab-actions']  
    Element Text Should Be          xpath=//span[@class='name']    WasiqulAutobot 
    
CreateShippingContactKW
    ${email-number}                 Generate Random String  8  [NUMBERS]
    [Return]                        ${email-number}
    
    Scroll Element Into View        xpath=//div[@class='details-block-title account-details-general-info-title']
    Scroll Element Into View        xpath=//div[@class='toggle-item account-toggle contact-viewer active']
    Scroll Element Into View        xpath=//span[@class='only-name'][contains(text(),'Orders')]
    Click Element                   xpath=//span[contains(text(),'+ Add Contact')]  
    Click Element                   xpath=//div[contains(text(),'Shipping Contact')] 
    Input Text                      xpath=//input[@name='contact2.firstName']    AccountShipping    
    Input Text                      xpath=//input[@name='contact2.emailAddress']    cba${email-number}@yopmail.com  
    Click Button                    xpath=//button[@class='submit-button'] 
    Element Text Should Be          xpath=//span[@class='value'][contains(text(),'AccountShipping')]    AccountShipping     
    
CreateContact1KW
    ${email-number}                 Generate Random String  8  [NUMBERS]
    [Return]                        ${email-number}
    
    Click Element                   xpath=//span[contains(text(),'+ Add Contact')]  
    Click Element                   xpath=//div[contains(text(),'Additional Contact 1')]
    Input Text                      xpath=//input[@name='contact3.firstName']    AccountContact1    
    Input Text                      xpath=//input[@name='contact3.emailAddress']    cba${email-number}@yopmail.com 
    Click Element                   xpath=//span[@class='email-section email-receive-or-not email_ask']//span[@class='radio-check-replacement checkbox-input unchecked']     
    Click Button                    xpath=//button[@class='submit-button'] 
    Element Text Should Be          xpath=//span[@class='value'][contains(text(),'AccountContact1')]    AccountContact1     
    
CreateContact2KW
    ${email-number}                 Generate Random String  8  [NUMBERS]
    [Return]                        ${email-number}
    
    Click Element                   xpath=//span[contains(text(),'+ Add Contact')]  
    Click Element                   xpath=//div[contains(text(),'Additional Contact 2')]
    Input Text                      xpath=//input[@name='contact4.firstName']    AccountContact2    
    Input Text                      xpath=//input[@name='contact4.emailAddress']    cba${email-number}@yopmail.com 
    Click Element                   xpath=//span[@class='email-section email-receive-or-not email_ask']//span[@class='radio-check-replacement checkbox-input unchecked']     
    Click Button                    xpath=//button[@class='submit-button'] 
    Element Text Should Be          xpath=//span[@class='value'][contains(text(),'AccountContact2')]    AccountContact2 
    
CreateContact3KW
    ${email-number}                 Generate Random String  8  [NUMBERS]
    [Return]                        ${email-number}
    
    Click Element                   xpath=//span[@class='popup-opener']  
    Input Text                      xpath=//input[@name='contact5.firstName']    AccountContact3    
    Input Text                      xpath=//input[@name='contact5.emailAddress']    cba${email-number}@yopmail.com 
    Click Element                   xpath=//span[@class='email-section email-receive-or-not email_ask']//span[@class='radio-check-replacement checkbox-input unchecked']     
    Click Button                    xpath=//button[@class='submit-button'] 
    Element Text Should Be          xpath=//span[@class='value'][contains(text(),'AccountContact3')]    AccountContact3 
    
    
*** Test Cases ***
LoginAutobillTest
    [Documentation]                 This is Autobill login test case
    
    Set Browser Implicit Wait       5
    Set Selenium Speed              1 second
    
    LoginKW
    Log                             Loging in to Autobill
    
CreateAccountAutobillTest
    [Documentation]                 This is Autobill Create Account test case
    
    Set Selenium Speed              2 seconds
    Set Selenium Timeout            10 seconds
    Set Browser Implicit Wait       5
    
    CreateAccountKW
    Log                             Creating an account
    
CreateContacts
    [Documentation]                 This is Autobill Billing Contact Create test case
 
    Set Selenium Speed              2 seconds
    Set Selenium Timeout            10 seconds
    Set Browser Implicit Wait       5
    
    CreateShippingContactKW
    CreateContact1KW
    CreateContact2KW
    CreateContact3KW
    Log                             Creating a contact
    
LogoutAutobillTest
    [Documentation]                 This is Autobill logout test case
    
    Set Selenium Speed              1 second
    
    LogoutKW
    Log                             Loging out from Autobill
    