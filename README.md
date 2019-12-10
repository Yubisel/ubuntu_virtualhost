# ubuntu_virtualhost
Tool for automate the creation of virtualhost in ubuntu


## How to use
`sudo ./config-vhost.sh`

that's prompt the input for hostname and latter prompt the input for project absolute url, afther that the script with that arguments
make a copy to the file "default-vhost.conf" overrite the values to configure the host move that file to /etc/apache2/sites-available/hostname.conf
and modify the file /etc/hosts adding the entrance for the new host.
