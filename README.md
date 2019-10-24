# monitoring
Ce projet contien un script bash qui quant executé renvoi en pourcentage le CPU load, Memoire et espace disque utilisé.
**Technologies:**

Mon choix n'étais pas arbitraire, j'ai choisi bash script car sur n'importe quelle machine linux (ubuntu, centos...), on peux l'executer et le resultat est presque le meme.
Personellement je travaille sur mon environement local, soit une ubuntu 16.04.

**Choix des données à monitorer:**

* On commence par le CPU:
`CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')`

La variable CPU reçoit la charge du CPU en filtrant le resultat de la commande top -bn1, on extracte la charge moyenne du cpu pendant la derniére minute. 

* Memoire vive utilisé:

`MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')`

La variable MEMORY reçoit le resultat aprés le filtrage de la commande
`free -m` qui renvoit des statistiques sur la memoire(total, utilisé, disponible...).

* Espace disque:

`DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')`

La variable DSIK reçoit le pourçentage d'espace disque utilisé sur la partition ou on a monté notre repértoir racine.

**Stockage des données:**

J'ai choisi de stocker les données sur un fichier texte `log.txt`, ce dernier peut étre par la suite insérer sur un fichier calculateur comme Microsoft excel pour faire des analyse, ou encore consulté par un administrateur systéme.

**Periodicité de recupération des données:**

Comme demandé de supérviser le systeme j'ai assuré que le script tourne toute les 5minutes en utilisant `slee 300`.

Malhereusement je vois que 5 minutes est trop car sur une machine ou serveur qu'on utilise fréquament on peut avoir des piques brusques et on risque des crash du systeme.

**Améliorations envisagés:**

J'aller ajouter un systeme de notification par email mais cela necessite la configuration d'un serveur mail comme postfix...

Un email sera envoyer au mail de l'administrateur, quand la charge du CPU est à 80% par exemple.
