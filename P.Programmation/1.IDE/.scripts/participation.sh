#!/bin/sh

# --------------------------------------
#
#
#
# --------------------------------------

source ../../.scripts/students.sh --source-only
   
echo "# Participation au `date +"%d-%m-%Y %H:%M"`"
echo ""


echo "| Table des matières            | Description                                             |"
echo "|-------------------------------|---------------------------------------------------------|"
echo "| :a: [Présence](#a-présence)   | L'étudiant.e a fait son travail    :heavy_check_mark:   |"
echo "| :b: [Précision](#b-précision) | L'étudiant.e a réussi son travail  :tada:               |"

echo ""
echo "## Légende"
echo ""

echo "| Signe              | Signification                 |"
echo "|--------------------|-------------------------------|"
echo "| :heavy_check_mark: | Prêt à être corrigé           |"
echo "| :x:                | Projet inexistant             |"


echo ""
echo "## :a: Présence"
echo ""
echo "|:hash:| Boréal :id:                | :id:/README.md    | :rocket: |"
echo "|------|----------------------------|-------------------|----------|"

i=0
s=0

for entry in "${STUDENTS[@]}"; do

   IFS='|' read -r id github avatar <<< "$entry"

   URL="[${github}](https://github.com/${github}) <image src='https://avatars0.githubusercontent.com/u/${avatar}?s=460&v=4' width=20 height=20></image>"

   FILE=${id}/README.md
   OK="| ${i} | [${id}](../${FILE}) ${URL} | :heavy_check_mark: | :heavy_check_mark: |"
   KO_WEB="| ${i} | [${id}](../${FILE}) ${URL} | :heavy_check_mark: | :x: |"
   KO="| ${i} | [${id}](../${FILE}) ${URL} | :x: | :x: |"
   if [ -f "$FILE" ]; then
       if git log --format=fuller -- ${FILE} | grep Author | grep -q "noreply"; then
           echo ${KO_WEB}
       else
           echo ${OK}
           let "s++"
       fi
   else
       echo ${KO}
   fi
   let "i++"
   COUNT="\$\\frac{${s}}{${i}}$"
   STATS=$(echo "$s*100/$i" | bc)
   SUM="$\displaystyle\sum_{i=1}^{${i}} s_i$"
 done
 
echo "| :abacus: | " ${COUNT} " = " ${STATS}% "|" ${SUM} = ${s} "|"
