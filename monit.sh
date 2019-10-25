#! /bin/bash
#tester si le fichier log est deja crée
if [ ! -f /home/sahbi/Documents/testSysteme/log.txt ] 
then
    touch log.txt
fi
#tester si le fichier est plain ou vide
if [ -s /home/sahbi/Documents/testSysteme/log.txt ] 
then
    while [ true ]; do
        MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
        DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
        CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
        echo "$MEMORY$DISK$CPU" >> /home/sahbi/Documents/testSysteme/log.txt
        #executer le script toute les 5minutes ou on peux modifier le crontab 
        #et ajouter une ligne au lieu de cette commande
        sleep 5m
    done    
    else
    printf "Memory\t\tDisk\t\tCPU\n" > "/home/sahbi/Documents/testSysteme/log.txt"
        while [ true ]; do
            DATE=$(date +"%m-%d-%Y-%T")
            MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
            DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
            CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
            echo "$MEMORY$DISK$CPU" >> /home/sahbi/Documents/testSysteme/log.txt
            sleep 5m
        done  
fi