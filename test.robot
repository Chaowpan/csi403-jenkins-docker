*** Settings ***
Documentation    Go TO WEB
Library    SeleniumLibrary

*** Test Cases ***
START
    Open Browser    http://localhost:5173    Chrome
    Sleep    2
    Capture Page Screenshot
    Click Element    xpath:/html/body/div/div[2]/button
    Sleep    2
    Capture Page Screenshot