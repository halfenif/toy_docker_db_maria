#!/bin/bash
#/usr/bin/mariadbd-safe --skip-grant-tables &
sleep 5
mariadbd -u root -e "CREATE DATABASE mydb"
#mysql -u root mydb < /tmp/dump.sql


mariadbd --user=root --password=mariadb --execute="create database test00; use test00;" 