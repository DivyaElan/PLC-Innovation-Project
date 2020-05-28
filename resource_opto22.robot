*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary


*** Variables ***
${SERVER}         plcdemonstrator.spdns.org
${BROWSER}        Chrome
${DELAY}          0
${VALID USER}     admin
${VALID PASSWORD}	password
${LOGIN URL}      https://${SERVER}/
${WELCOME URL}    https://${SERVER}/manage/home
${ERROR URL}      http://${SERVER}/error.html
${NODE-RED PAGE}	https://${SERVER}/manage/local/node-red


*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
	Go to Login Page
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    Login

Go To Login Page
	Delete All Cookies
    Sleep	2s	
    Go To    ${LOGIN URL}
	Click Element	//html/body/div/div[2]/button[3]
	Click Element	//html/body/div/div[3]/p[2]/a
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
	# Click Element 		//html/body/nav/a[3]
	Assign Id To Element	id:uname		Input_Username
    Input Text	Input_Username	${username}

Input Password
    [Arguments]    ${password}
    Input Text	id:pwd  ${password}

Submit Credentials
    Click Button	submitBtn

Welcome Page Should Be Open
	Sleep	3s
    Location Should Be    ${WELCOME URL}
    Title Should Be    groov Manage: Home
	
Go to Node-RED Editor
	Click Element	xpath://span[text()='Node-RED']
	Location Should be	${NODE-RED PAGE}
	Click Element	xpath://span[text()='Open Node-RED Editor']
	Select Window    title=Node-RED : plcdemonstrator.spdns.org
	Title Should be	Node-RED : plcdemonstrator.spdns.org
	
Create Test Flow
	Set Selenium Speed		0.5
	Assign Id To Element	xpath://a[@id='red-ui-header-button-sidemenu']	Node_RED_Menu_Button
	Click Element	Node_RED_Menu_Button
	Assign Id To Element	xpath://span[text()='Import']	Node_RED_Import
	Click Element	Node_RED_Import
	Assign Id To Element	id:red-ui-clipboard-dialog-import-file-upload-btn	Node_RED_Import_File
	Choose File		id=red-ui-clipboard-dialog-import-file-upload		C:/Users/delangov/Documents/Innovation Project/PLC_test/flows.json
	Assign Id To Element	id:red-ui-clipboard-dialog-import-opt-new		new_flow_button
	Click Element	new_flow_button
	Assign Id To Element	id:red-ui-clipboard-dialog-ok	import_OK_button
	Click Element	import_OK_button
	Sleep 	6s
	Assign Id To Element	xpath: //*[contains(text(), "Flow Test")]	flow_test
	Wait Until Element Is Visible	flow_test
	Click Element	flow_test
	Capture Page Screenshot	C:/Users/delangov/Documents/Innovation Project/PLC_test/flowtest.png
	
	
	
Deploy Test Flow
	Sleep	5s
	Assign Id To Element		id:red-ui-header-button-deploy-icon	deploy
	Click Element	deploy
	Capture Page Screenshot
	Sleep	1s
	#	Assign Id to Element class:red-ui-flow-node-button-button send_payload
	#	Click Element	xpath://div[@class='ui-droppable']//*[local-name()='svg']//*[name()='g']//*[name()='g' and contains(@class,'red-ui-wor')]//*[name()='g']//*[name()='g'][1]/*[name()='g' and contains(@class,'red-ui-flo')]//*[name()='rect'][2]	
	Click Element	xpath://div[@class='ui-droppable']//*[local-name()='svg']//*[name()='g']//*[name()='g' and contains(@class,'red-ui-wor')]//*[name()='g']//*[name()='g'][1]/*[name()='g' and contains(@class,'red-ui-flo')[3]]//*[name()='rect'][2]
	Sleep	5s
	Double	Click	Element	xpath://body[1]/div[1]/div[2]/div[1]/div[3]/*[local-name()='svg'][1]/*[name()='g'][1]/*[name()='g'][1]/*[name()='g'][4]/*[name()='g'][2]/*[name()='rect'][1]	
	Sleep	5s
	
Delete Test Flow
	Assign Id To Element	xpath://a[@id='Node_RED_Menu_Button']	Node_RED_Menu_Button
	Click Element	Node_RED_Menu_Button
	Assign Id To Element	id:menu-item-workspace	submenu_flow
	Wait Until Page Contains Element	submenu_flow
	Mouse Over		submenu_flow
	Assign Id To Element	id:menu-item-workspace-delete	delete_flow
	Wait Until Page Contains Element	delete_flow
	Click Element 	delete_flow
	Assign Id To Element	id:red-ui-header-button-deploy	deploy
	#	Assign Id To Element xpath://img[@id='deploy'] deploy
	Click Element	deploy
	Capture Page Screenshot
	
	
	
