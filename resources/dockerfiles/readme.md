# Tutoriel Docker

Différents docker-hub utilisés dans le projet : https://hub.docker.com/r/juldpnt/reprohackaton_8 

## Construction d'une image

Pour construire une image docker, il faut se déplacer dans le répertoire contenant le fichier `Dockerfile` et exécuter la commande suivante :

```bash
docker build -t <nom_image> .
```
## Envoi d'une image sur Docker Hub

Pour envoyer une image sur Docker Hub, il faut se connecter à son compte Docker Hub :

```bash
docker login
```

Il faut ensuite modifier le nom de l'image pour qu'elle convienne à la convention de nommage de Docker Hub. Par exemple, si le repository de l'utilisateur juldpnt sur dockerhub est reprohackaton_8, il faut renommer l'image en juldpnt/reprohackaton_8:\<nom image> :

```bash
docker tag <nom_image> <nom_utilisateur>/<repo>:<nom_image>
```

Enfin, on peut envoyer l'image sur Docker Hub :

```bash
docker push <nom_utilisateur>/<repo>:<nom_image>
```

## Récupération d'une image sur Docker Hub

Pour récupérer une image sur Docker Hub, il faut exécuter la commande suivante :

```bash
docker pull <nom_utilisateur>/<repo>:<nom_image>
```

## Exécution d'un container

...