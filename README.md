# Hive - Docker container environment for modern web applications

## Inspiration
Ce projet est inspiré du projet Laradock (https://laradock.io).

## Création de votre domaine de développement local

Afin de mettre en place votre domaine local, il suffit d'éditer votre fichier /etc/hosts avec la commande "sudo /etc/hosts", et d'ajouter la ligne suivante :

127.0.0.1 hive.dev.local

Une fois cette mise à jour réalisée, il vous suffit d'accéder à votre domaine via un navigateur

## Commandes utiles à l'exploitation quotidienne de la technologie Docker
- docker-compose up : Démarrer l'ensemble des containers du projet
- docker-compose up {container_name} : Démarrer le container {container_name}
- docker-compose ps : Lister les containers du projet courant
- docker-compose images : Lister les containers et les tailles d'images du projet
- docker-compose logs {container_name} : Consulter les logs du container {container_name}
- docker-compose stop : Stopper l'ensemble des containers du projet courant
- docker-compose stop {container_name} : Stopper le container {container_name}
- docker-compose down : Supprimer l'ensemble des containers du projet courant
- docker-compose exec {container_name} {command} : Lancer la commande {command} dans le container {container-name}

## Si jamais vous apporter des modifications sur les Dockerfile/configurations importées à la compilation
- docker-compose build --no-cache : Lancer la compilation de l'ensemble des containers du projet
- docker-compose build --no-cache {container-name} : Lancer la compilation du container {container-name}

## License

Hive is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).