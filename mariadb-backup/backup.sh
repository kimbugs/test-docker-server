#!/bin/bash

# For test
input=$1
timestamp=$(date +"%F %T")
datetime=$(date -d ${input} +"%F")
past_datetime=$(date -d "${input} -1 month" +"%F")
day=$(date -d ${input} +"%d")

# For Production
# timestamp=$(date +"%F %T")
# datetime=$(date +"%F")
# past_datetime=$(date +"%F" -d '1 month ago')
# day=$(date +"%d")

BASE_PATH=/var/lib/mysql/backup
FULL_BACKUP_DAY=01 # ex) 01, 02, 03 ... 31
INC_DAY1=08
INC_DAY2=15
INC_DAY3=22
INC_DAY4=26
DB_USER=root
DB_PASSWORD=root

# delete directory
# ${1} - file path
function delete_directory(){
    rm -r ${1}
    if [ $? -eq 0 ]; then
        echo "Delete directory ${1}"
    else
        echo "Fail delete directory ${1}"
    fi
}

# mariadb full backup
# ${1} - file path
function mariabackup_full(){
    mariabackup --backup --target-dir=${1} --user=${DB_USER} --password=${DB_PASSWORD} > ${BASE_PATH}/full-${datetime}.log 2>&1
    if [ $? -eq 0 ]; then
        echo "Done full backup"
    else
        echo "Fail full backup"
        exit
    fi
}

# mariadb incremental backup
# ${1} - incremental file path
# ${2} - full file path
function mariabackup_incremental(){
    mariabackup --backup --target-dir=${1} --incremental-basedir=${2} --user=${DB_USER} --password=${DB_PASSWORD} > ${BASE_PATH}/incremental-${datetime}.log 2>&1
    if [ $? -eq 0 ]; then
        echo "Done incremental backup"
    else
        echo "Fail incremental backup"
        exit
    fi
}

# full_backup 
function full_backup(){
    echo "${timestamp} - (1/3) Run Mariadb full backup command"
    mariabackup_full "${BASE_PATH}/full-${datetime}"
    echo "${timestamp} - (2/3) Delete 1 month ago full-backup data."
    delete_directory "${BASE_PATH}/full-${past_datetime}"
    delete_directory "${BASE_PATH}/full-${past_datetime}.log"
    echo "${timestamp} - (3/3) Delete 1 month ago incremental-backup data."
    delete_directory "${BASE_PATH}/incremental-*"
    echo "${timestamp} - Full backup Done"
}

# incremental_backup
function incremental_backup(){
    FULL_BACKUP_PATH="${BASE_PATH}/full-${datetime:0:7}-${FULL_BACKUP_DAY}"
    echo "${timestamp} - (1/3) Check full backup folder"
    if [ ! -d ${FULL_BACKUP_PATH} ]; then
        echo "Fail incremental backup, full backup folder not exist"
        exit
    fi
    echo "${timestamp} - (2/3) Run Mariadb incremental backup command"
    mariabackup_incremental "${BASE_PATH}/incremental-${datetime}" ${FULL_BACKUP_PATH}
    echo "${timestamp} - (3/3) incremental backup Done"
}

function main(){
    # check backup folder
    if [ ! -d ${BASE_PATH} ]; then
        mkdir ${BASE_PATH}
    fi

    if [ ${day} -eq ${FULL_BACKUP_DAY} ]; then
        echo "${timestamp} - Full backup ${day}"
        full_backup
    elif [ ${day} -eq ${INC_DAY1} ] || [ ${day} -eq ${INC_DAY2} ] || [ ${day} -eq ${INC_DAY3} ] || [ ${day} -eq ${INC_DAY4} ]; then
        echo "${timestamp} - incremental backup ${day}"
        incremental_backup
    else
        echo "${timestamp} - None backup ${day}"
    fi
}

main

exit