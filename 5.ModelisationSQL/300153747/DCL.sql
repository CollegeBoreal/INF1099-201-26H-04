CREATE ROLE gestionnaire;

GRANT SELECT, INSERT, UPDATE
ON vehicule
TO gestionnaire;

GRANT SELECT
ON transit
TO gestionnaire;

REVOKE DELETE
ON vehicule
FROM gestionnaire;
