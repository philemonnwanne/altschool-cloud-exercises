#!/usr/bin/bash

# Declaring variables
env_file="/var/www/exam/laravel/.env"

# Mod .env file for DB  configuration
_edit_env() {

# Set the search string for APP_NAME
swap_app_name(){
seek=$(sudo grep "^APP_NAME\w*" $env_file)
swap="Exam-Proj"
# Set the swap string
if [[ $seek != "" && $swap != "" ]]; then
  (sudo sed -i "s/$seek/APP_NAME=$swap/" $env_file)
else
   echo "APP_NAME=Exam-Proj" | sudo tee -a ${env_file}
fi
}

# Set the search string for APP_URL
swap_app_url(){
seek=$(sudo grep "^APP_URL" $env_file)
swap="philemonnwanne.me"
# Set the swap string
if [[ $seek != "" && $swap != "" ]]; then
  (sudo sed -i "s/$seek/APP_URL=$swap/" $env_file)
else
  echo "APP_URL=philemonnwanne.me" | sudo tee -a ${env_file}
fi
}

# Set the search string for DB_CONNECTION
swap_db_conn(){
seek=$(sudo grep "^DB_CONNECTION\w*" $env_file)
swap="mysql"
# Set the swap string
if [[ $seek != "" && $swap != "" ]]; then
  (sudo sed -i "s/$seek/DB_CONNECTION=$swap/" $env_file)
else
  echo "DB_CONNECTION=mysql" | sudo tee -a ${env_file}
fi
}

# Set the search string for DB_HOST
swap_db_host(){
seek=$(sudo grep "^DB_HOST\w*" $env_file)
swap="localhost"
# Set the swap string
if [[ $seek != "" && $swap != "" ]]; then
  (sudo sed -i "s/$seek/DB_HOST=$swap/" $env_file)
else
  echo "DB_HOST=localhost" | sudo tee -a ${env_file}
fi
}

# Set the search string for DB_PORT
swap_db_port(){
seek=$(sudo grep "^DB_PORT" $env_file)
swap="3306"
# Set the swap string
if [[ $seek != "" && $swap != "" ]]; then
  (sudo sed -i "s/$seek/DB_PORT=$swap/" $env_file)
else
  echo "DB_PORT=3306" | sudo tee -a ${env_file}
fi
}

# Set the search string for DB_DATABASE
swap_db_database(){
seek=$(sudo grep "^DB_DATABASE\w*" $env_file)
swap="examdb"
# Set the swap string
if [[ $seek != "" && $swap != "" ]]; then
  (sudo sed -i "s/$seek/DB_DATABASE=$swap/" $env_file)
else
  echo "DB_DATABASE=examdb" | sudo tee -a ${env_file}
fi
}

# Set the search string for DB_USERNAME
swap_db_user(){
seek=$(sudo grep "^DB_USERNAME\w*" $env_file)
swap="root"
# Set the swap string
if [[ $seek != "" && $swap != "" ]]; then
  (sudo sed -i "s/$seek/DB_USERNAME=$swap/" $env_file)
else
  echo "DB_USERNAME=root" | sudo tee -a ${env_file}
fi
}


# Set the search string for DB_PASSWORD
swap_db_pass(){
seek=$(sudo grep "^DB_PASSWORD\w*" $env_file)
swap="1234"
# Set the swap string
if [[ $seek != "" && $swap != "" ]]; then
  (sudo sed -i "s/$seek/DB_PASSWORD=$swap/" $env_file)
else
  echo "DB_PASSWORD=1234" | sudo tee -a ${env_file}
fi
}

# Calling all functions in this section
swap_app_name
swap_app_url
swap_db_conn 
swap_db_host
swap_db_port
swap_db_database
swap_db_user
swap_db_pass
}

_edit_env



wget https://raw.githubusercontent.com/philemonnwanne/o0o0o/main/exercises/exe-07/script.sh

chmod u+x script.sh

