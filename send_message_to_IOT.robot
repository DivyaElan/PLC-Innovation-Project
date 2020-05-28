*** Settings ***
Documentation     A test suite with a single test for deploying a flow to IoTHub.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource_opto22.robot

*** Test Cases ***
Valid Login
    Open Browser To Login Page
    Input Username    admin
    Input Password    password
    Submit Credentials
    Welcome Page Should Be Open
	Go to Node-RED Editor
	Create Test Flow
	Deploy Test Flow
	#Delete Test Flow
	#[Teardown]    Close Browser
	

