# monitoring
Ce projet contien un script bash qui quant executé renvoi en pourcentage le CPU load, Memoire et espace disque utilisé.
**Technologies:**
---
Mon choix n'étais pas arbitraire, j'ai choisi bash script car sur n'importe quelle machine linux (ubuntu, centos...), on peux l'executer et le resultat est presque le meme.
Personellement je travaille sur mon environement local, soit une ubuntu 16.04.
**Choix des données à monitorer:**
---
On commence par le CPU:
`CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')`
---
Memoire vive utilisé:
`MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')`
La variable MEMORY recoit le resultat aprés le filtrage de la commande
`free -m` qui renvoit des statistiques sur la memoire(total, utilisé, disponible...). 
---
Espace disque:
