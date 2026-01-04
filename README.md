# README

Things you may want to cover:

* Ruby version: 3.1.6

* Rails Version: 7.2.3

STEPS

1. CLone the project.

2. run 'bundle i' to install the gems.

3. run 'rails db:create db:migrate db:seed' to setup the database.

4. run 'rails s' to start the server.

NOTES:

* For Mailer to work please create .env file and add credentials in development.rb(local server).

* If your project is in 'OneDrive/' directory please move the project out of it or run this commands 'rails tem:cache:clear' and 'rails tem:clear' then restart the sever. This PROBLEM occurs because OneDrive tries to constantly sync the file so best practice is to move the project from OneDrive directory.
