PHP is a programming language used for developing web applications. You must install PHP packages on a Ubuntu system to run the application written on it. Generally, it is used to create e-commerce websites, blogs, and API applications. If you’re looking for an easy way to install PHP on Ubuntu 22.04, look no further. This blog post will show you how to do it quickly and easily.

We will use the Ondrej PPA for installing PHP on Ubuntu 22.04 LTS system. Which contains PHP 8.3, 8.2, 8.1, 8.0, 7.4, 7.3, 7.2, 7.1, 7.0 & PHP 5.6 packages. You can install any of the versions required for your application. The new application developers are suggested to use the latest PHP version ie PHP 8.2.

In this tutorial, you will learn how to install PHP on Ubuntu 22.04 LTS system. This tutorial is also compatible with Ubuntu 20.04 LTS, and Ubuntu 18.04 LTS systems.

Prerequisites
First, log in to Ubuntu 22.04 via the console. Then update the Apt cache and upgrade the current packages of the system using the following command:

sudo apt update && sudo apt upgrade 
When prompted, press ‘y’ to confirm the installation.

Step 1: Install PHP on Ubuntu 22.04
PHP installation on Ubuntu systems is pretty straightforward. You just need to add the required PPA and you can install any PHP version on the Ubuntu system.

Follow these steps to complete PHP installation on Ubuntu:

Install a few dependencies required by this tutorial with the below-mentioned command:
sudo apt install software-properties-common ca-certificates lsb-release apt-transport-https 
Add the Ondrej PPA to your system, which contains all versions of PHP packages for Ubuntu systems.
LC_ALL=C.UTF-8 sudo add-apt-repository ppa:ondrej/php 
Now, update the Apt package manager cache.
sudo apt update 
The SURY repository contains PHP 8.3, 8.2, 8.1, 7.4, 7.3, 7.2 & PHP 5.6. As the latest stable version of PHP is 8.2, but a large number of websites still required PHP 7.x. You can install any of the required PHP versions on your system.
Install PHP 8.2:
sudo apt install php8.3 
Install PHP 8.2:
sudo apt install php8.2 
Install PHP 8.1:
sudo apt install php8.1 
Install PHP 7.4:
sudo apt install php7.4 
Install PHP 5.6 (EOL):
sudo apt install php5.6 
Replace version 8.3, 8.2, 8.1, 7.4, or 5.6 with the required PHP version to install on Ubuntu. Even you can install multiple PHP versions on a single Ubuntu system.

Most PHP applications depend on various extensions to extend their features. That can also be installed using the following syntax:
sudo apt install php8.2-[extension]
Replace [extension] with the extension you want to install, if you want to add multiple extensions then include them in braces, I am going to install “php-mbstring, php-mysql, php-xml, and php-curl” by running the below-mentioned command:

sudo apt install php8.2-mysql php8.2-mbstring php8.2-xml php8.2-curl 
Users who have installed different PHP versions, need to replace 8.2 with the required PHP versions.

Step 2: Check Active PHP Version
Now after installation verify that the correct version of PHP is installed by checking the version number by the below-mentioned command:

php -v 
Output:

PHP 8.2.1 (cli) (built: Jan 13 2023 10:43:08) (NTS)
Copyright (c) The PHP Group
Zend Engine v4.2.1, Copyright (c) Zend Technologies
    with Zend OPcache v8.2.1, Copyright (c), by Zend Technologies
Step 3: Understand PHP Configuration Files
The PHP configuration files are stored under /etc/php directory with the version numbers. For example, all the configuration files related to PHP 8.2 are located below:

Main PHP configuration file location:
PHP CLI: /etc/php/8.2/cli/php.ini
Apache: /etc/php/8.2/apache2/php.ini
PHP FPM: /etc/php/8.2/fpm/php.ini
All the installed PHP modules are stored under /etc/php/8.2/mods-available directory.
PHP Active modules configuration directory location:
PHP CLI: /etc/php/8.2/cli/conf.d/
Apache: /etc/php/8.2/apache2/conf.d/
PHP FPM: /etc/php/8.2/fpm/conf.d/
To check files for the other PHP versions, just change the PHP version number (8.2 in the above example) in the files and directory path.

Step 4: Change Default PHP Version
You can use an `update-alternatives` command to set the default PHP version. Use this tutorial to read more details about switching the PHP version for CLI and Apache.

sudo update-alternatives --config php
Output: (Select your choice)

There are 4 choices for the alternative php (providing /usr/bin/php).

  Selection    Path             Priority   Status
------------------------------------------------------------
* 0            /usr/bin/php8.1   81        auto mode
  1            /usr/bin/php5.6   56        manual mode
  2            /usr/bin/php7.4   74        manual mode
  3            /usr/bin/php8.0   80        manual mode
  4            /usr/bin/php8.1   81        manual mode
  5            /usr/bin/php8.2   82        manual mode
  6            /usr/bin/php8.3   83        manual mode

Press  to keep the current choice[*], or type selection number: 6
The above output shows all the installed PHP versions on your system. Selection number 6 set PHP 8.3 as the default PHP version for the command line.

Step 5: Uninstalling PHP (Optional)
If any PHP version is no more required, it can be removed from the system. That will free the disk space as well as system security.

To uninstall any PHP version just type:

sudo apt remove php5.6 
Also, uninstall all the modules for that version with the following command:

sudo apt remove php5.6-* 
Conclusion
This tutorial provides you with the instructions to install PHP on Ubuntu 22.04. The Ondrej PPA allows us to install PHP on Ubuntu systems quickly. It also allows us to install multiple PHP versions on a single system. You can switch to any PHP version as default anytime with the update-alternative utility.
