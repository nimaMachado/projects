# projects
Je vous présente quelques uns des projets que j'ai codé en python dont un en Lisp. J'ai préparé une application graphique aussi avant-hier mais elle n'est toujours pas au point. 

Le chatbot s'inspire d'un des premiers chatbot qui ait jamais existé. Le langage Lisp était le langage phare aux balbutiemments de l'IA.
Le fonctionnement est très simple mais le langage rend le tout très peu lisible. Il était beaucoup apprécié car la récursion marchait pas mal avec. Ici, on a une fonction match qui parcours une liste n1 et la compare à la liste n2. Ensuite on essaie de travailler avec des patterns. Nous aurons n1 du type ( x * je suis allé * y ) et n2 (Hier soir à 22h je suis allé au cinéma). Le but étant de trouver à l'aide de n2 à quoi correspond x et y. Les '*' nous aident à délimiter ce qui est manquant et ce qui ne l'est pas. Au final pour être bref, on arrive à avoir une conversation restreinte avec notre terminal. La longevité de la discussion dépend surtout des cas de figure que l'on met en paramètre. Une possibilité que je n'ai pas encore exploré vu la difficulté à lire et écrire un fichier avec ce langage est de gérer le cas de figure ou l'ordinateur n'est pas confronté à une phrase qu'il connait. Dans ce cas ci, à l'heure actuel, il est muet. Il serait très interessant que nous proposions à l'utilisateur de rajouter sa phrase avec ce que devrait répondre le programme. Le programme commencerait avec sa base de donnée et pour écrire celle-ci. Nous sommes bien loin d'une véritable IA dans tout les cas. Je suis aussi navré d'avance du peu de lisibilté de ce code. Le langage lisp peut être très vite encombrant. Pour l'executer, il suffit d'installer clisp et de taper cette commande sur le terminal : clisp chatbot.lisp. 

Tictactoe est un jeu de morpion codé en python. Nous jouons contre l'ordinateur qui utilise l'algorithme minimax. C'est donc impossible de gagner contre elle. 

Jeu.py est un tour par tour très rudimentaire sur lequel j'ai voulu baser mon appliction graphique en Java. Ce code s'est fait en programmation objet orienté.

Perceptron est un notebook Jupyter ou je me familiarise avec la bibliothèque Pandas. J'y manipule des dataFrame et la bibliothèque Matplotlib aussi. Le but final était de creer un modèle qui puisse prédire la survie d'un passager du Titanic. A la fin de ce notebook, le fichier csv est traité et il en résulte un nouveau fichier csv modifié et prêt à être utilisé pour un modèle de sklearn.

C'est dans nombre que j'ai experimenté pour la première fois avec la bibliothèque sklearn. Les matrice des images étaient déjà présente dans cette bibliothèque pour pouvoir se familiariser avec l'utilisation de modèle. Ici c'est une régression logistique. Nous traitons bien sûr d'abord les données ensuite en divise celle-ci en 2 groupes. Il y a celles avec lesquelles on construit notre modèle et celles qui nous servirons de test pour le modèle. C'est à la fin, au moment de fit que ça ne marche pas. J'ai bien essayé d'augmenter le nombre d'itération. Je ne voulais changer
