🧪 1️⃣ Objectif
L’objectif de ce TP est de comprendre le fonctionnement du DCL (Data Control Language) dans PostgreSQL, notamment la gestion des utilisateurs et des permissions sur une base, un schéma et une table.
⚙️ 2️⃣ Préparation de l’environnement
Connexion au conteneur
<img width="771" height="106" alt="image" src="https://github.com/user-attachments/assets/ed7b95ed-452c-433b-92ea-639612b56f8e" />
Connexion à PostgreSQL
<img width="468" height="117" alt="image" src="https://github.com/user-attachments/assets/ad3fc216-ef36-4aaf-bdc3-26e665d5254e" />
PostgreSQL

🏗 3️⃣ Création de la base et des objets
Création de la base
<img width="457" height="30" alt="image" src="https://github.com/user-attachments/assets/026363e5-1c18-41a8-813b-efb1403d6dad" />
Création du schéma et la table
<img width="702" height="240" alt="image" src="https://github.com/user-attachments/assets/cfb3a088-923b-4ba1-929a-8bd9352ab880" />
👤 4️⃣ Création des utilisateurs
<img width="653" height="102" alt="image" src="https://github.com/user-attachments/assets/8c09719a-fdb1-4069-ab5a-f0b70c48d318" />
🔐 5️⃣ Attribution des droits
Connexion à la base
<img width="743" height="39" alt="image" src="https://github.com/user-attachments/assets/b0370b02-73c0-4e70-bfa3-54878d3521d5" />
Accès au schéma
<img width="773" height="48" alt="image" src="https://github.com/user-attachments/assets/73670d5b-eb2e-44af-bb36-19effd5d296b" />
Droits sur la table
<img width="608" height="208" alt="image" src="https://github.com/user-attachments/assets/b3a5aab8-e5d6-4b9b-9882-c249ee039d0a" />
Droits sur la séquence
<img width="488" height="101" alt="image" src="https://github.com/user-attachments/assets/3a64369b-386d-4ec1-85bb-0e2645fd3cb6" />
🧪 6️⃣ Tests des permissions
🔹 Test avec étudiant
Connexion
<img width="543" height="68" alt="image" src="https://github.com/user-attachments/assets/6aaf0b27-68ae-4ac5-883a-f2267e8ae753" />
Test lecture 
<img width="480" height="96" alt="image" src="https://github.com/user-attachments/assets/8aaa802f-cc3c-4691-9a70-7f4e98ba98a6" />
Test insertion (doit échouer) :
<img width="616" height="85" alt="image" src="https://github.com/user-attachments/assets/f0705605-7270-4981-9246-415fe5055b89" />
🔹 Test avec professeur
Connexion
<img width="541" height="42" alt="image" src="https://github.com/user-attachments/assets/8e4234cb-da14-470c-80bd-641ce4bbde61" />
Insertion :
<img width="613" height="78" alt="image" src="https://github.com/user-attachments/assets/5f75ae14-b138-412d-8a9a-90106687d886" />
Modification :
<img width="399" height="104" alt="image" src="https://github.com/user-attachments/assets/6a588da5-3cd1-4cac-b81b-7b7d0b526521" />
🔄 7️⃣ Retrait des droits
<img width="632" height="153" alt="image" src="https://github.com/user-attachments/assets/a82e845a-0937-4f67-99c4-b1df8c25780a" />
Testet avec étudiant 
le test doit echoué
<img width="672" height="230" alt="image" src="https://github.com/user-attachments/assets/d7ef436d-4635-4d54-85f6-f8fc9793dd5e" />
🗑 8️⃣ Suppression des utilisateurs
<img width="402" height="89" alt="image" src="https://github.com/user-attachments/assets/2aa1b843-3656-4059-81a7-e2d5efad5b91" />
📝 9️⃣ Conclusion
Ce TP m’a permis de comprendre que PostgreSQL sépare les permissions en trois niveaux : base, schéma et table.
Les commandes GRANT et REVOKE permettent de gérer précisément les droits des utilisateurs.
La gestion des séquences est nécessaire pour permettre les INSERT sur des colonnes SERIAL.
