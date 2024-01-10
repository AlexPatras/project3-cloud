|  Scenario ID: | 01  |   
|---|---|
| Name: |  Create account |
| Actor: |  User | 
| Description:  |  User wants to create an account.  |  
| Pre-condition: |  User doesn’t have an account.   |    
| Scenario: | 1. User tells the app they want to create an account.<br /> 2. App prompts the user to enter user information such as phone number, first and last name, username and password, address and upload profile picture.<br /> 3. User tells the app the +4312345679, Hans Peter, hanspeter, hanspeter123, Hansstr 1, 123456 Hamburg, hans.jpg and confirms.<br /> 4. App shows confirmation and log in view.     |      
| Result:    | The user has successfully created an account.    |   
| Exception:  | Step 2 &#8594; User misses one of the required fields. <br />  2. The app prompts the user to enter user information such as phone number, first and last name, username and password. <br />  2.1. go back to step 1.     |    

|  Scenario ID: | 02 |  
|---|---|
| Name: | log in  |   
| Actor: | User  |     
| Description:  |  User wants to log into their acocunt.  |   
| Pre-condition: | User has an account. |   
| Scenario: | 1. User tells the app they want to log into their account. <br/> 2. App ask the user for login information such as username and password. <br/> 3.The user tells the app the required username hanspeter and password hanspeter123 and confirms.<br/> 4. App shows confirmation of login. |     
| Result:    | User is logged in   |     
| Exception:  | Step 3 &#8594; User does not exist: <br/> 3.1. App tells the user doesn’t exist. <br/> 3.2.  go back to step 2.<br/> Step 3 &#8594; Username and password don’t match. <br/>3.1. App tells the user the password doesn’t match.<br/> 3.2. go back to step 2.   |  

|  Scenario ID: |  03 |  
|---|---|
| Name: |  Edit profile |   
| Actor: |  User |     
| Description:  | User wants to edit their profile.  |   
| Pre-condition: | User has an account and is logged in.  |   
| Scenario: |  1. User tells the app they want to edit their profile. <br/> 2. App displays edit options such as username, first and last name, address, password and <u>profile picture</u>. |     
| Result:    |  User has successfully edited their profile. |     
| Exception:  | //  |  


|  Scenario ID: |   04|  
|---|---|
| Name: |  Upload profile picture |   
| Actor: | User  |     
| Description:  | User wants to upload a profile picture to their profile.  |   
| Pre-condition: |  User has an account and is logged in. |   
| Scenario: |  1. User tells the app they want to upload a profile picture. <br/> 2. App asks the user to upload the picture. <br/> User tells the app they want to upload file hans.jpg and confirms. <br/> 4. App confirms upload. |     
| Result:    |  The user has successfully uploaded the profile picture. |     
| Exception:  |  // |  


|  Scenario ID: |   05|  
|---|---|
| Name: | View profile |   
| Actor: | User |     
| Description:  | User wants to view a profile. |   
| Pre-condition: | User has an account and is logged in. |   
| Scenario: | 1. User tells the app they want to view a profile of Antonia. <br/> 2. The app displays the profile.  |     
| Result:    | The user has successfully viewed the profile information. |     
| Exception:  |  // |  

|  Scenario ID: |   06|  
|---|---|
| Name: | Send friend request |   
| Actor: | User |     
| Description:  | User sends a friend request to another user. |   
| Pre-condition: | User needs to be logged in. |   
| Scenario: | 1. User searches for antonialala they want to add. <br/> 2. App displays search results antonialala. <br/> 3. User tells the app they want to add antonialala in the results. <br/> 4. Friend request is sent to antonialala.   |     
| Result:    | Friend request is sent to another user. |     
| Exception:  |  User was already added <br/> 2. App tells the user the user was already added. |  

|  Scenario ID: |   07|  
|---|---|
| Name: | Search for user |   
| Actor: | User |     
| Description:  | User searches for another user. |   
| Pre-condition: | User needs to be logged in. |   
| Scenario: | 1. User tells the app they want to search for a user. <br/> 2. App asks for user's information such as phone number. <br/> 3. User enters the phone number +4123456789 of another user. <br/> 4. App displays result.  |     
| Result:    | User searched for another user. |     
| Exception:  |  No results found. <br/> 4.1. App tells the user it didn't find any results. |  


