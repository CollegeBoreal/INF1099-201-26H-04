-- 1️⃣ Vérifier tous les utilisateurs
SELECT * FROM betformula.utilisateur;

-- 2️⃣ Vérifier toutes les villes
SELECT * FROM betformula.ville;

-- 3️⃣ Vérifier tous les pilotes
SELECT * FROM betformula.pilote;

-- 4️⃣ Vérifier toutes les équipes et leurs sponsors
SELECT e.id_equipe, e.nom_equipe, s.nom_sponsor
FROM betformula.equipe e
JOIN betformula.sponsor s ON e.id_sponsor = s.id_sponsor;

-- 5️⃣ Vérifier tous les circuits avec leur ville
SELECT c.id_circuit, c.nom_circuit, v.nom_ville
FROM betformula.circuit c
JOIN betformula.ville v ON c.id_ville = v.id_ville;

-- 6️⃣ Vérifier tous les événements et leur circuit
SELECT ev.id_evenement, ev.nom_evenement, ev.date_evenement, c.nom_circuit
FROM betformula.evenement ev
JOIN betformula.circuit c ON ev.id_circuit = c.id_circuit;

-- 7️⃣ Vérifier toutes les courses et leur événement
SELECT co.id_course, co.nom_course, co.date_course, ev.nom_evenement
FROM betformula.course co
JOIN betformula.evenement ev ON co.id_evenement = ev.id_evenement;

-- 8️⃣ Vérifier tous les paris avec infos utilisateur, pilote et course
SELECT p.id_pari, u.nom AS nom_user, u.email, co.nom_course, pi.nom_pilote, p.montant, p.resultat
FROM betformula.pari p
JOIN betformula.utilisateur u ON p.id_user = u.id_user
JOIN betformula.course co ON p.id_course = co.id_course
JOIN betformula.pilote pi ON p.id_pilote = pi.id_pilote
ORDER BY p.id_pari;

-- 9️⃣ Nombre de paris par utilisateur
SELECT u.nom, COUNT(p.id_pari) AS nb_paris
FROM betformula.utilisateur u
LEFT JOIN betformula.pari p ON u.id_user = p.id_user
GROUP BY u.nom
ORDER BY nb_paris DESC;

-- 🔟 Courses avec le nombre de pilotes participants
SELECT co.nom_course, COUNT(pi.id_pilote) AS nb_pilotes
FROM betformula.course co
JOIN betformula.pari p ON co.id_course = p.id_course
JOIN betformula.pilote pi ON p.id_pilote = pi.id_pilote
GROUP BY co.nom_course
ORDER BY nb_pilotes DESC;