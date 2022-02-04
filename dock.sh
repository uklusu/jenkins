#!/bin/bash
service php7.4-fpm restart
service nginx start
systemctl start mysql
