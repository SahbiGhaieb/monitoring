# monitoring
Ce projet contien un script bash qui quant executé renvoi en pourcentage le CPU load, Memoire et espace disque utilisé.
**Technologies:**

Mon choix n'étais pas arbitraire, j'ai choisi bash script car sur n'importe quelle machine linux (ubuntu, centos...), on peux l'executer et le resultat est presque le meme.
Personellement je travaille sur mon environement local, soit une ubuntu 16.04.

**Utilisation:**

Pour éxecuter ce projet faite ces petites étapes trés faciles:
1. Cloner ce repo.
2. donner le droit d'execution au fichier monit.sh en utilisant la commande `chmod +x monit.sh`
3. éxecuter le script en utilisant `./monit.sh`

**Choix des données à monitorer:**

* On commence par le CPU:

`CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')`

La variable **CPU** reçoit la charge du CPU en filtrant le resultat de la commande top -bn1, on extracte la charge moyenne du cpu pendant la derniére minute. 

* Memoire vive utilisé:

`MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')`

La variable **MEMORY** reçoit le resultat aprés le filtrage de la commande
`free -m` qui renvoit des statistiques sur la memoire(total, utilisé, disponible...).

* Espace disque:

`DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')`

La variable **DSIK** reçoit le pourçentage d'espace disque utilisé sur la partition ou on a monté notre repértoir racine.

**Stockage des données:**

J'ai choisi de stocker les données sur un fichier texte `log.txt`, ce dernier peut étre par la suite insérer sur un fichier calculateur comme Microsoft excel pour faire des analyse, ou encore consulté par un administrateur systéme.

**Periodicité de recupération des données:**

Comme demandé de supérviser le systeme j'ai assuré que le script tourne toute les 5minutes en utilisant `slee 300`.

Malhereusement je vois que 5 minutes est trop car sur une machine ou serveur qu'on utilise fréquament on peut avoir des piques brusques et on risque des crash du systeme.

**Améliorations envisagés:**

J'aller ajouter un systeme de notification par email mais cela necessite la configuration d'un serveur mail comme postfix...

Un email sera envoyer au mail de l'administrateur, quand la charge du CPU est à 70% par exemple.

**Alerting:**

Comme j'ai mentionnée en haut si on vas intégrer une solution d'alerting par email par exemple. Dans ce cas on peux fixer des variables pour les seuils (THRESHOLD), **CPU_THRESHOLD=80%**, **MEMORY_THRESHOLD=80%**, **DISK_THRESHOLD=90%**, **NETWORK_THRESHOLD**... 
Apres on teste ces valeurs avec les valeur qu'on recupére chaque 5 minutes dans notre cas, si THRESHOLD<=valeurs on envoi une alerte.
Une autre méthode pour faire une alerte d'état critique serais d'utiliser la commande `notify-send`, cette commande vas envoyer des message au niveau du bureau(desktop), mais ce n'est pas une méthode efficace pour les serveurs. 

Comme n'importe quelle machine qui fonctionne et execute differents programmes, si le CPU, Memoire, Disk... sont satturés, sa peut causer des latences (LAG), voir meme causer le crash totale du systeme.

**Amelioration Envisagés**

Chaque programme peux toujours étre évolué et amélioré, surtout notre petit script.

Evidemment nous pouvons non seulement recupérer les taux CPU/MEMOIRE/DISK utilisé mais aussi on peux extraire les taux d'utilisation du reseau(network), température du CPU, on peux supérviser la totalité de nos services, serveur web, mail, applications... 

**Amelioration du stockage**

Personellement je préfére stocker les logs dans des fichiers, mais il existe aussi d'autre possibilités, on peux stocker ces log dans des bases de données, il existe plusieurs bases de données et de preference utiliser des bases de données NoSQL.