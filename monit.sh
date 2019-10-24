#! /bin/bash
#tester si le fichier log est deja crée
if [ ! -f /home/sahbi/Documents/testSysteme/log.txt ] 
then
    touch log.txt
fi
#tester si le fichier est plain ou vide
if [ -s /home/sahbi/Documents/testSysteme/log.txt ] 
then
    #echo "le fichier est plain"
    end=$((SECONDS+3600))
    while [ $SECONDS -lt $end ]; do
    MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
    DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
    CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
    echo "$MEMORY$DISK$CPU" >> /home/sahbi/Documents/testSysteme/log.txt
    #envoyer un email
    #echo -e "CPU/MEMORY/DISK:" | /usr/sbin/sendmail -f$from -t$to -u$subject -m"test" -a/home/sahbi/Documents/testSysteme/log.txt
    #executer le script toute les 5minutes ou on peux modifier le crontab et ajouter une ligne
    #sleep 300
    sleep 5
    done    
    else
    #echo "le fichier est vide"
    printf "Memory\t\tDisk\t\tCPU\n" > "/home/sahbi/Documents/testSysteme/log.txt"
        end=$((SECONDS+3600))
        while [ $SECONDS -lt $end ]; do
        DATE=$(date +"%m-%d-%Y-%T")
        MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
        DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
        CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
        echo "$MEMORY$DISK$CPU" >> /home/sahbi/Documents/testSysteme/log.txt
        sleep 5
        done  
fi