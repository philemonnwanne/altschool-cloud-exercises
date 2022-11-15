## THIS PROJECT HAS THE FOLLOWING REQUIREMENTS
- Virtual machine running Debian 11 Server aka (Bullseye)
- Git, Apache, Wget, Curl
- Php 8.1 and it's dependencies
- Mysql/MariaDb Database
- Composer

### SETUP
###### Install LAMP Stack on Debian 11

LAMP Stack comprises of the following open source software applications
```php
Linux – this is the operating system hosting the applications.

Apache – free and open-source cross-platform web server.

MySQL/MariaDB – open source relational database management system.

PHP – programming/scripting language used for developing web applications.
```

### Prerequisites to Install LAMP
- Root access to your server or a sudo user
- Domain pointed to your server's IP

### Update the Package Installer

We will be using the Apt installer to install new packages onto our server. Before we start installing packages, we need to ensure it is up to date.
To do so, we can use the following command:

```php
sudo su
apt update
```

Once the update is done we can go to the next step

### Install the following packages (Apache2, Wget, Git, Curl, unzip)

Now that our installer is up to date, we can now install our web server Apache and the following packages on the server. This will install the Apache webserver package and start the Apache web service automatically

```php
apt install -y wget git apache2 curl unzip
```

> Note: The `-y` is to answer yes to all prompts


### Install PHP

###### Add the SURY PPA for PHP 8.1

```php
apt -y install lsb-release apt-transport-https ca-certificates
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
```

Now you can add the PPA to the server packages using the following command
```php
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
```

Update the packages and install PHP 8.1
```php
apt update
apt install php libapache2-mod-php php8.1-mysql php8.1-common php8.1-mysql 
php8.1-xml php8.1-xmlrpc php8.1-curl php8.1-gd php8.1-imagick php8.1-cli php8.1-dev 
php8.1-imap php8.1-mbstring php8.1-opcache php8.1-soap php8.1-zip php8.1-intl -y
```

Once PHP is installed you can check the version using the following command.
```php
php -v
```


### Install mySQL

The next step is to install our database server on our virtual machine. Follow steps below to Install mySQL 8.0 on your Debian 11 Linux system

Add mySQL Dev apt repository. MySQL 8.0 packages are available on official mySQL Dev apt repository
```
apt update
wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb
```

> Note: If you get any error in this next 👇🏾 step, keep retrying the command until it's all good -- could be network issues 

Install the release package
```
apt update
apt install ./mysql-apt-config_0.8.22-1_all.deb
```

<span>Confirm addition of mySQL 8.0 repository as default when prompted</span>


![mysql-prompt-image](/Mini-Project/images/mysql-prompt.png)

Use the down arrow key to choose OK, then press `Tab` and hit `Enter` (as shown in the image above) - Would be done twice

> Note: If you get any error in this next 👇🏾 step, keep retrying the command until it's all good -- could be network issues 

Now you can install mySQL
```
apt update
apt install mysql-server
```
<samp>When prompted, enter your root password and choose legacy authentication</samp>

we can now exit mySQL using the command `exit;`

To verify that the mySQL server is running, type:
```
service mysql status
```

The output should show that the service is enabled and running


### Create a Database
Login to mySQL  by executing the following command into mySQL:
```
mysql -u root -p
```

Replace the “your password” with the password you had set up during installation. Once we are logged in, we can now create a database using the following command:

```
CREATE DATABASE yourdatabase;
```
> replace `yourdatabase` with your desired database name. Once the database has been created, we can now exit mySQL using the command `exit;`. Also remember to add the semi-colons.


### Install Laravel 8 Using Composer 

Switch to apache's document root
```php
cd /var/www/
```

Create a directory to house your project, for the purpose of this project I will call mine `mini-project`
```php
mkdir mini-project
```

Switch to the directory created in the previous step and clone the [laravel project](https://github.com/f1amy/laravel-realworld-example-app.git) from github

```php
cd mini-project
git clone https://github.com/f1amy/laravel-realworld-example-app.git
```

Rename the cloned git repo to whatever you wish to call your project, for my use case I will name it `laravel`
```php
mv laravel-realworld-example-app laravel
```

Run the following command to edit the `web.php` file in the routes directory
```
nano /var/www/mini-project/laravel/routes/web.php
```

The code block that we want to alter in the file should look similar to what we have below

```php
<?php

/*Route::get('/', function () {
    return view('welcome');
});*/
```

When you are done editing the file it should now look like this 👇🏾

```php
<?php

Route::get('/', function () {
    return view('welcome');
});
```

### Create a copy of your `.env` file

`.env` files are not generally committed to source control for security reasons. But there is a `.env.example` which is a template of the `.env` file that the project expects us to have. So we will make a copy of the `.env.example` file and create a `.env` file that we can start to fill out to do things like database configuration in the next few steps.

Switch to your projects directory
```php
cd /var/www/mini-project/laravel 
```

```php
cp .env.example .env
```

> This will create a copy of the `.env.example` file in your project and name the copy simply `.env`

Next, edit the `.env` file and define your database:
```
nano .env
```

`Note:` Configure your `.env` file just as it is in the output below, only make changes to the `DB_DATABASE` and `DB_PASSWORD` lines

```php
APP_NAME="your app name" (call it anything you wish)
APP_URL=your machine's IP addr eg. (192.168.10.22)
DB_CONNECTION=mysql
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=enter the name of your database here
DB_USERNAME=root
DB_PASSWORD=enter your mysql root password here
```
After updating your .env file, save the changes and exit


### Install Composer

Composer is a dependency manager for PHP used for managing dependencies and libraries required for PHP applications. To install `composer` run the following command: 

```php
curl -sS https://getcomposer.org/installer | php
```

You should get the following output
```php
All settings correct for using Composer
Downloading...
Composer (version 2.1.6) successfully installed to: /root/composer.phar
Use it: php composer.phar 
```

Next, move the downloaded binary to the system path and make it executable by everyone
```php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer
```

Next, verify the Composer version using the following command 
```php
composer --version
```

You should see the following output 
```php
Composer version 2.1.6 2021-08-19 17:11:08
```


### Install Composer Dependencies

Whenever you clone a new Laravel project you must now install all of the project dependencies. This is what actually installs Laravel itself, among other necessary packages to get started. When we run composer, it checks the `composer.json` file which is submitted to the github repo and lists all of the composer (PHP) packages that your repo requires. Because these packages are constantly changing, the source code is generally not submitted to github, but instead we let composer handle these updates. So to install all this source code we run composer with the following command.

```php
composer install
```


Generate the artisan key with the following command 

> make sure you are in the `/var/www/mini-project/laravel` directory before executing any command that starts with `php artisan`

Switch to your projects directory

```php
cd /var/www/mini-project/laravel 
```

```php
php artisan key:generate
```

Also run the following php artisan commands

```
php artisan config:cache
php artisan migrate:fresh
php artisan migrate --seed
```


### Configure Apache to Host Laravel 8

Next, you'll need to create an Apache virtual host configuration file to host your Laravel application. You can create it using the following command:

```php
nano /etc/apache2/sites-available/mini-project.conf
```

Add the following lines

```php
<VirtualHost *:80>
    ServerAdmin admin@mini-project.alt
    ServerName mini-project.alt
    ServerAlias www.mini-project.alt
    DocumentRoot /var/www/mini-project/laravel/public
    
    <Directory /var/www/mini-project/laravel/public>
        Options Indexes MultiViews
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

Save and close the file and then enable the Apache rewrite module and activate the Laravel virtual host with the following command: 

```php
a2enmod rewrite
a2dissite 000-default.conf
a2ensite mini-project.conf
```

Next, change the permission and ownership of `mini-project` and `laravel` directory. In order to run, Apache needs certain permissions over the Laravel directory we made. We must first give our web group control of the Laravel directory. You can read more on [Linux file permissions here](https://en.wikipedia.org/wiki/File-system_permissions)

```php
chown -R www-data:www-data /var/www/mini-project/laravel
chmod -R 775 /var/www/mini-project/laravel
```

Finally, reload the Apache service to apply the changes

```php
systemctl reload apache2
```


### Secure your Site

Next if you have a valid domain name, we are going to encrypt it and make our traffic use SSL/TLS

##### Install snapd

Ensure that your version of snapd is up to date. Execute the following instructions on the command line on the machine to ensure that you have the latest version of snapd.

```php
snap install core; snap refresh core
```

##### Install Certbot

Run this command on the command line on the machine to install Certbot.

```php
snap install --classic certbot
```

##### Link the Certbot command

Finally, you can link the certbot command from the snap install directory to your path, so you’ll be able to run it by just typing certbot.

```php
ln -s /snap/bin/certbot /usr/bin/certbot
```

##### Running Certbot

Certbot needs to answer a cryptographic challenge issued by the Let’s Encrypt API in order to prove we control our domain. It uses ports 80 (HTTP) or 443 (HTTPS) to accomplish this. We can now run Certbot to get our certificate. We’ll use the --standalone option to tell Certbot to handle the challenge using its own built-in web server. Finally, the -d flag is used to specify the domain you’re requesting a certificate for. You can add multiple -d options to cover multiple domains in one certificate.

```php
certbot certonly --standalone -d your_domain
```

When running the command, you will be prompted to enter an email address and agree to the terms of service. After doing so, you should see a message telling you the process was successful and where your certificates are stored:

##### Output
```php
IMPORTANT NOTES:
Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/your_domain/fullchain.pem
Key is saved at: /etc/letsencrypt/live/your_domain/privkey.pem
This certificate expires on 2022-02-10.
These files will be updated when the certificate renews.
Certbot has set up a scheduled task to automatically renew this certificate in the background.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
If you like Certbot, please consider supporting our work by:
* Donating to ISRG / Let's Encrypt: https://letsencrypt.org/donate
* Donating to EFF: https://eff.org/donate-le
You should now have your certificates. 
```

### Confirm that Certbot worked
To confirm that your site is set up properly, visit `https://your_domain` in your browser and look for the lock icon in the URL bar. You will be redirected to the Laravel default page


#### Rendered Page

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="/Mini-Project/images/mini-proj-dark.png">
  <source media="(prefers-color-scheme: light)" srcset="/Mini-Project/images/mini-proj.png">
  <img alt="Shows the rendered page in light mode and in dark mode." src="/Mini-Project/images/mini-proj.png">
</picture>


Note: Run the following commands to test that all endpoints are working as they should

```php
cd /var/www/mini-project/laravel
php artisan route:list
```

This will return a list of all the possible endpoints in the project and you can test them by visiting your `domain name/the desired endpoint` or preferably using `postman`

#### API's/Endpoints
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="/Mini-Project/images/endpoints-dark.png">
  <source media="(prefers-color-scheme: light)" srcset="/Mini-Project/images/endpoints.png">
  <img alt="Shows the endpoints in light mode and in dark mode." src="https://github.com/philemonnwanne/altschool-cloud-exercises/blob/main/Mini-Project/images/endpoints.png">
</picture>


