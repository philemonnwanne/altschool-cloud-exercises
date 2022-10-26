## Exercise 7

### Task:

* Create a bash script to run at every hour, saving system memory (RAM) usage to a specified file and at midnight it sends the content of the file to a specified email address, then starts over for the new day.

### Instruction:

- [ ] Submit the content of your script, cronjob and a sample of the email sent, all in the folder for this exercise.

### Procedure

#### SCRIPT
Create a bash script to execute all neccessary commands in a predefined order

> Link here: [script](https://github.com/philemonnwanne/altschool-cloud-exercises/blob/main/Month-02/Exercise-07/script.sh)

#### MAIL
For a linux machine to be able to send a mail, update apt and install an SMTP server by running the following commands
```
sudo apt update
sudo apt install ssmtp
```

Also install a mail client by running the following commands
```
sudo apt install bsd-mailx
```

After installing the mail server and client, make the necessary configurations to get them both working by editing the `/etc/ssmtp/ssmtp.conf` and `/etc/ssmtp/revaliases` files.

Here's a sample of both configurations:

```ruby
vagrant@ubuntu:/$ cat /etc/ssmtp/ssmtp.conf
root==*********@mail.com
mailhub=smtp.gmail.com:587
hostname=ubuntu
AuthUser=*********@mail.com
AuthPass=**************** [Gmail app password]
UseSTARTTLS=yes
UseTLS=yes
FromLineOverride=yes
```

```ruby
vagrant@ubuntu:/$ cat /etc/ssmtp/revaliases
root:myemail@gmail.com:smtp.gmail.com:587
```

#### CRON
Next thing to do after writing a bash script would be creating a crontab to run a cronjob. Run the following command to install a crontab since
```php
crontab -e
```

> If this your first time installing a crontab, you would have an option to pick an editor of your choice, so go ahead and choose which ever one that you are comfortable working with.

I have attached my configuration below:

[crontab](https://github.com/philemonnwanne/altschool-cloud-exercises/blob/main/Month-02/Exercise-07/cronjob)

```ruby
* * * * * bash /home/vagrant/script.sh
```

#### Mail Output
[mail](https://github.com/philemonnwanne/altschool-cloud-exercises/blob/main/Month-02/Exercise-07/cron-mail.pdf)
