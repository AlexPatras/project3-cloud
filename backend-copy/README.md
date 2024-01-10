# prj3-phone-native-application

To get the backend running on your machine, follow these steps: 

- go to the directory **backend/stalker** in your Terminal. This  can be done by using **'cd'** and then navigating to the correct path 
    >if you're unsure about the path use **'ls'** to see what folders you can navigate to. You can also use **tab** to **autofill** once you start typing the beginning of a path)
    
- once you're in the correct directory use the command **'npm install'**
> make sure you have the correct version of node and loopback4 installed!
- run **'npm install loopback-connector-postgresql -save'**
- after installing use **'npm run build'**
- once that is complete use **'npm run migrate'**
- you should be able to run **'npm start'** once these steps are complete and the server should start without issues.  

## Local Data

### Docker 
Make sure you have a docker container running! To avoid conflicts and having to constantly change the datasources file, use the following command to create your docker container: 

- docker run --name prj3_stalker -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=mypw -d postgres

### Database Management 

Use either DBeaver or pgAdmin to manage and view your database tables locally. 

- for pgAdmin use this [tutorial](https://www.postgresqltutorial.com/postgresql-getting-started/connect-to-postgresql-database/) as a guideline




