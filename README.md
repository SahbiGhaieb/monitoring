# monitoring
Ce projet contient un script qui quand exécuté renvoi en pourcentage le CPU load, Mémoire et espace disque utilisé.
**Technologies:**

Mon choix n'était pas arbitraire, j'ai choisi bash script car sur n'importe quelle machine Linux (Ubuntu, centos...), on peut l'exécuter et le résultat est presque le même.
Personnellement je travaille sur mon environement local, soit une Ubuntu 16.04.

**Utilisation:**

Pour exécuter ce projet faite ces petites étapes très faciles:
1. Cloner ce repo.
2. Donner le droit d'exécution au fichier monit.sh en utilisant la commande `chmod +x monit.sh`
3. Exécuter le script en utilisant `./monit.sh`

**Choix des données à monitorer:**

* On commence par le CPU:

`CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')`

La variable **CPU** reçoit la charge du CPU en filtrant le résultat de la commande top -bn1, on extracte la charge moyenne du cpu pendant la dernière minute.

* Memoire vive utilisé:

`MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')`

La variable **MEMORY** reçoit le resultat aprés le filtrage de la commande
`free -m`  qui renvoit des statistiques sur la mémoire(total, utilisé, disponible...).

* Espace disque:

`DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')`

La variable **DISK** reçoit le pourcentage d'espace disque utilisé sur la partition ou on a monté notre repértoir racine.

**Stockage des données:**

J'ai choisi de stocker les données sur un fichier texte `log.txt`, ce dernier peut être par la suite inséré sur un fichier calculateur comme Microsoft excel pour faire des analyses, ou encore consulté par un administrateur système.

**Periodicité de recupération des données:**

Comme demandé de superviser le système j'ai assuré que le script tourne toutes les 5 minutes en utilisant `sleep 5m`.

On peut aussi utiliser le crontab pour assurer une periodicité de notre choix pour éxecuter notre script.

Malheureusement je vois que 5 minutes sont trop car sur une machine ou serveur qu'on utilise fréquemment on peut avoir des piques brusques et on risque des crashs du système.

**Améliorations envisagés:**

J'allais ajouter un système de notification par email mais cela necessite la configuration d'un serveur mail comme postfix...

Un email sera envoyé au mail à l'administrateur, quand la charge du CPU est à 70% par exemple.

**Alerting:**

Comme j'ai mentionné en haut si on va intégrer une solution d'alerting par email par exemple. Dans ce cas on peut fixer des variables pour les seuils (THRESHOLD), **CPU_THRESHOLD=80%**, **MEMORY_THRESHOLD=80%**, **DISK_THRESHOLD=90%**, **NETWORK_THRESHOLD**... 
Après on teste ces valeurs avec les valeurs qu'on récupère chaque 5 minutes dans notre cas, si THRESHOLD=valeurs on envoie une alerte.
Une autre méthode pour faire une alerte d'état critique serait d'utiliser la commande `notify-send`, cette commande va envoyer des messages au niveau du bureau(desktop), mais ce n'est pas une méthode efficace pour les serveurs.

Comme n'importe quelle machine qui fonctionne et exécute différents programmes, si le CPU, Mémoire, Disc... sont saturés, ça peut causer des latences (LAG), voire même causer le crash total du système.

**Amelioration Envisagés**

Pour diminuer l'intervention humaine et automatiser le lancement de notre script à chaque demarage du systéme, on peut le mettre en tant que service et l'ajouter au demarrage(`service nom_du_service enable`).

Chaque programme peut toujours être évolué et amélioré, surtout notre petit script.

Évidemment nous pouvons non seulement récupérer les taux CPU/MEMOIRE/DISK utilisé mais aussi on peut extraire les taux d'utilisation du réseau(network), température du CPU, on peut superviser la totalité de nos services, serveur web, mail, applications.... 

**Amelioration du stockage**

Personnellement je préfére stocker les logs dans des fichiers, mais il existe aussi d'autres possibilités, on peut stocker ces logs dans des bases de données, il existe plusieurs bases de données et de préférence utiliser des bases de données NoSql.

**Recommendation d'outil de monitoring:**

Personnellement je n'ai pas une grande expérience en ce qui concerne les outils de monitoring. J'ai testé quelques outils auparavant, je peux citer **Nagios** un bon outil robuste et gratuit que j'ai utilisé pendant mon apprentissage ainsi que **Zabbix** qui est open-source. 

J'ai fait des recherches concernant ces outils je peux ainsi que j'ai aussi aimé **Netdata** qui est un outil de monitoring en temps réel, il a des interfaces fascinantes et simples, j'aurais aimé le tester et donner mon avis personnel sur le sujet.