SELECT data 
FROM tournaments 
WHERE data->'teams' @> '["Alpha Wolves"]';