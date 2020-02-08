*** Settings ***
Library    SeleniumLibrary 
Library    String       
Suite Setup    Open Browser    ${url}    chrome
Suite Teardown    Close Browser
Default Tags    Wasiqul

*** Variables ***
${url}    http://stage-app.autobill.com/
&{credential}    username=implementer@6e3f9004.local    password=implementer@6e3f9004.local

*** Keywords ***
LoginKW
    Input Text          id=email        &{credential}[username]  
    Input Password      id=password     &{credential}[password]
    Click Button        class=login-button
    
LogoutKW
    Click Element       class=place-holder-image 
    Click Element       xpath=//span[contains(text(),'Logout')]   
    
CreateAccountKW
    ${email-number}     Generate Random String  8  [NUMBERS]
    [Return]            ${email-number}
    
    Click Element       xpath=//span[@class='icon lnr lnr-plus-circle']
    Click Element       xpath=//li[@class='new-item create-new-account-link skip-ajax-validation tab-opener']//span[@class='new-text'][contains(text(),'Account')]   
    Input Text          name=name    WasiqulAutobot    
    Input Text          name=emailAddress    abc${email-number}@yoho.com
    Click Button        xpath=//button[@class='submit-button common-tab-actions']  
    
*** Test Cases ***
    
LoginAutobillTest
    [Documentation]     This is Autobill login test case
    
    Set Browser Implicit Wait        5
    Set Selenium Speed               1 second
    
    LoginKW
    Log    Loging in to Autobill
    
CreateAccountAutobillTest
    [Documentation]     This is Autobill Create Account test case
    
    Set Selenium Speed               2 seconds
    Set Selenium Timeout             10 seconds
    
    CreateAccountKW
    Log    Creating an account
    
LogoutAutobillTest
    [Documentation]     This is Autobill logout test case
    
    Set Selenium Speed               1 second
    
    LogoutKW
    Log    Loging out from Autobill
    