# *FeedbackLoop* - La meilleure plateforme de retours et de vote d'idées

<p align="center">
    <img src="assets/image/logo/feedback-loop.jpg">
</p>

## Comment contribuer ? 🎈
Ce document rapporte l'ensemble des actions à appliquer et des exigences à respecter pour pouvoir contribuer efficacemnt au projet **FeedbackLoop**

## Commencer à contribuer : fork + clone 🌟
Particulierement pour ce travail collaboratif, vu qu'il s'agit d'un projet propre au groupe 9 de la communauté ***FlutterFire Summer Camp***, adoptons la methodologie : fork + clone
- <u>**fork**</u> : chaque membre du groupe qui souhaite contribuer au projet devra forker ce repository; ça permettra que chaque contributeur ait une copie du repo directement sur son compte GitHub (au lieu de travailler sur un seul compte si vous aviez simplement cloné le repo)
- <u>**clone**</u> : Après le fork, il ne restera plus qu'à cloner votre version du repo en local sur votre machine
- <u>**Les branches**</u> : En local, ne travaillez surtout pas sur la branche **main**; cous avez le choix entre :
    - **renommer la branche principale main** : par exemple : main -> main-dev grace a la commande :
    ```bash
    git branch -M main-dev
    ```
    contraitement, sur le repo distant la branche main sera toujours présente et il vous fqudrq creer la branche "main-dev" sur le repo distant de votre compte
    - **Travailler sur une autre branche** : Ou tout simplement creer une nouvelle branche et travailler dessus

## Valider sa contribution : push + pull request + code review 🎯
- <u>**push**</u> : une fois votre travail terminé  en local, vous le pousserez sur votre copie du repo sur votre compte
- <u>**pull request**</u> : Ensuite une demande d'extraction en effectuant un *pull request* qui  permetrra de soumettre votre travil auprès du compte d'origine qui heberge le repo
- <u>**code review**</u> : Enfin, pour que votre code soit fusionner au projet, il sera revu par le chef de groupe afin de le valider

## Instructions après avoir le repo en local sur votre pc 💻
Une fois le repository cloné, veuillez à effectuer ces étapes :
- Tapez la commande :
```bash
flutter pub get
``` 
Ceci permettra de télécharger les packages (avec les versions précisées) qui sont déjà renseignés et que nous utiliserons tout au long du projet pour implémenter plusieurs fonctionnalités
- Les packages actuellement présents qui seront téléchargés sont : `flutter_native_splash`, `shared_preferences`, `go_router` et `flutter_riverpod`
- le package `flutter_web_plugins` sera également chargé ainsi que les répertoires d'assets `assets/*`

## Architecture du projet 📏
Vous devez être à l'aise avec la **clean architecture** selon l'approche **layer-first**; C'est selon elle que les repertoires du projet ont été structurés :

### 1. lib/presentation/ 🧸
Tout ce qui est UI et visible par l'utilisateur
- **lib/presentation/screens/** : les differents ecrans de l'application
- **lib/presentation/widgets/** : les widgets personnalisés reutilisables partout dans l'application
- **lib/presentation/providers/** : Vous definirez généralement tous vos providers dans ce repertoire

### 2. lib/domain/ 🔗
Le coeur de l'architecture. Il contient du dart pur; pas de flutter et aucune dependances provenant de l'exterieur
- **lib/domain/entities/** : les classes entités présents dns l'application
- **lib/domain/repositories/** : une abstraction pour l'implementation des classes dans "lib/data/repositories/"
- **lib/domain/usecases/** : Des classes pour chaque methodes abstraites des interfaces du "lib/domain/repositories/"

### 3. lib/data/ 🧬
C'est le repertoire responsable de faiare tout traitement associés  aux données de l'application
- **lib/data/data_source/** : Pour definir les differentes source de donnees (local/serveur)
- **lib/data/models/** : les entités sont etendues ici pour definir des méthodes  de serialisation
- **lib/data/repositories/** : On implemente les interfaces definis dans "lib/domain/repositories"

### 4. lib/core 🎴
On y definira tout ce qui commun à toutes les couches clean architecture et qui est global à l'application
- **lib/core/error/** : les exceptions personnalisées
- **lib/core/routes/** : la configurations des dfférentes routes
- **lib/core/theme/** : la gestion du thème et du design system de l'application
- **lib/core/providers/** : ici, on veillera a ce que les providers definis n'ont aucune dependances aux couches (presentation/domain/data)

### 5. assets/ 📟
Il contient tout elemnts exterieur qui sera utilisé dans l'application
- **assets/animation/** : contiendra les animations
- **assets/font/** : pour stocker les polices personnalisées
- **assets/icon/** : parfois les icones fournir par flutter ne suffiront pas et on aura besoin des icones personnalisés (en .svg)
- **assets/image/** : Toutes les images de mocking
    - **assets/image/logo/** : specialement pour le logo de l'application et ses derivés
- **assets/splash_screen/** : les images de splash screen natif

### 6. design/ 🎨
On y trouvera les fichiers des maquettes graphiques de l'application ainsi que les screenshots
- **design/mobile/screenshots** : les captures d'écran de  la maquette graphique de la version mobile
- **design/web/screenshots** : les captures d'écran de  la maquette graphique de la version web/desktop

### 7. test/ 🧪
Ce répertoire nous servira essentiellement créer des fichiers qui permettra d'effectuer des tests unitaires et de widgets de nore application. Son aborescence a été calqué aux différentes couches clean architecture pour qu'on puisse se retrouver facilemnt dans les tests. Veuillons à mettre chque test dans le repertoire correspondant en fonction de sa nature.

## <u>Nota Bene</u> : Les conventions de nommage 📝
### 1. **Pour les fichiers images**
- Pas de majuscule! ... tout en minuscule
- Haissez les espaces comme pas possible!
- Soyez le plus concis possible, évitez les noms à rallonge inutilement car les différents répertoires contenus dans `assets` sont déjà assez significatifs. <u>Exemple :</u> Préferez **tiktok.png** ou bien **profil.jpg** plutôt que respectivement **logo-de-tiktok.png** ou **icone-de-profil.jpg** ... Le simple fait que ces images soient stockées dans `assets/icons` est déjà représentatif de ce qu'il sont, pas la peine de le préciser dans leur nom
- Veuillez à nommer vos images en séparant chaque mot par un ***tiret (-)***. <u>Exemple :</u> **ma-belle-image.png**
- Seules les extensions suivantes sont autorisées : `.png`, `.jpg`, `.jpeg` ... Fuyez les `.webp`

### 2. **Pour tous les fichiers dart**
- Tout en minuscule!
- Fuyez les espaces comme la peste!
- Utiliser la convention de nommage ***snake case*** qui consiste à séparer chaque ot du nom de notre fichier par des ***underscore (_)***. <u>Exemple :</u> **mon_joli_fichier.dart**
- si votre fichier défini principalemnt une classe, il est primordiale que le nom de cette classe soit le même que le nom de votre fichier mais en convention **pascal case** qui consiste à mettre en masjucule les premières de chaque mot de votre classe. <u>Exemple :</u> votre fichier : **home_screen.dart** => votre classe qui y est défini : **HomeScreen** ... on s'y retrouvera plus facilement

### 3. **Pour les fichiers widgets**
- Evitez de terminer le nom de vos widgets personnalisés par `widget` ... En effet tout est widget en flutter et ça n'apporte aucune plu value
- Préferez utiliser `custom`. <u>Exemple :</u> **navigation_bar_custom.dart**

### 3. **Pour les nom des variable et objets**
- C'est un crime d'y insérer des espaces (dart ne vous l'autorisera pas de toutes façon)
- Utilisez la convention **`camel case`** qui consiste à coller les mots du nom de votre variable/objet et de mettre en majuscule seulement les premières lettres de chaque mot sauf le pour le premier mot. <u>Exemple :</u> **maVariable**, **monObjet** <u>Contre Exemple (ce qu'il ne faut pas faire) :</u> **MaVariable**, **Monobjet**, **maconstante** 