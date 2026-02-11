#!/bin/bash

# --------------------------------------
# Student Participation Report
# --------------------------------------

# Load the combined students array
source ../.scripts/students.sh --source-only

echo "# Participation au $(date +"%d-%m-%Y %H:%M")"
echo ""

# Table des matières
echo "| Table des matières            | Description                                             |"
echo "|-------------------------------|---------------------------------------------------------|"
echo "| :a: [Présence](#a-présence)   | L'étudiant.e a fait son travail    :heavy_check_mark:   |"
echo "| :b: [Précision](#b-précision) | L'étudiant.e a réussi son travail  :tada:               |"

echo ""
echo "## Légende"
echo ""
echo "| Signe              | Signification                 |"
echo "|--------------------|-------------------------------|"
echo "| :heavy_check_mark: | Prêt à être corrigé / Fichier créé |"
echo "| :x:                | Projet inexistant / Fichier manquant |"

echo ""
echo "## :a: Présence"
echo ""
echo "|:hash:| Boréal :id:                | README.md    | images | 1FN.txt | 2FN.txt | 3FN.txt |"
echo "|------|----------------------------|--------------|--------|---------|---------|---------|"

i=0
s=0

for entry in "${STUDENTS[@]}"; do
    IFS='|' read -r ID GITHUB AVATAR <<< "$entry"

    URL="[${GITHUB}](https://github.com/${GITHUB}) <image src='https://avatars0.githubusercontent.com/u/${AVATAR}?s=460&v=4' width=20 height=20></image>"
    FILE=${ID}/README.md
    FOLDER=${ID}/images

    # Nouveaux fichiers à tester
    FILE_1FN=${ID}/1FN.txt
    FILE_2FN=${ID}/2FN.txt
    FILE_3FN=${ID}/3FN.txt

    # Vérification de la présence des fichiers
    CHECK_1FN=":x:"
    CHECK_2FN=":x:"
    CHECK_3FN=":x:"
    [ -f "$FILE_1FN" ] && CHECK_1FN=":heavy_check_mark:"
    [ -f "$FILE_2FN" ] && CHECK_2FN=":heavy_check_mark:"
    [ -f "$FILE_3FN" ] && CHECK_3FN=":heavy_check_mark:"

    # Statut README et images
    OK="| ${i} | [${ID}](../${FILE}) :point_right: ${URL} | :heavy_check_mark: | :x: | ${CHECK_1FN} | ${CHECK_2FN} | ${CHECK_3FN} |"
    FULL_OK="| ${i} | [${ID}](../${FILE}) :point_right: ${URL} | :heavy_check_mark: | :heavy_check_mark: | ${CHECK_1FN} | ${CHECK_2FN} | ${CHECK_3FN} |"
    KO="| ${i} | [${ID}](../${FILE}) :point_right: ${URL} | :x: | :x: | ${CHECK_1FN} | ${CHECK_2FN} | ${CHECK_3FN} |"

    if [ -f "$FILE" ]; then
        if [ -d "$FOLDER" ]; then
            echo "${FULL_OK}"
            ((s++))
        else
            echo "${OK}"
        fi
    else
        echo "${KO}"
    fi

    ((i++))
    COUNT="\$\\frac{${s}}{${i}}$"
    STATS=$(echo "$s*100/$i" | bc)
    SUM="$\displaystyle\sum_{i=1}^{${i}} s_i$"
done

echo "| :abacus: | ${COUNT} = ${STATS}% | ${SUM} = ${s} |"

