#!/bin/bash

# Combined array: each entry = "student_id|github_id|avatar_id"
STUDENTS=(
"300141550|emeraudesantu|211749528"
"300141567|arsprod2001|169725025"
"300142242|yahiiiia|131247071"
"300146667|djaberbenyezza|205994773"
"300147786|300786147|231366133"
"300148210|zianiferiel|233097107"
"300148450|adjaoud-git|205994730"
"300150205|blbsblm|205994753"
"300150271|mazighs|205994932"
"300150284|aroua-git|205994902"
"300150293|amir1450|212635146"
"300150295|lounasallouti1|205994740"
"300150303|jessmaud|211592293"
"300150399|chkips|195236786"
"300150417|latifmuristaga|212187666"
"300150524|takieddinechoufa|206965671"
"300150527|akrembouraoui|212277460"
"300150562|isako29|205994758"
"300151292|akahil521|205994792"
"300151469|Rabia-777|206001876"
"300151492|hacen19|206000307"
"300151825|FeatFreedy|195238262"
"300151833|raoufbrs15|109877652"
"300151841|massi9313|205994823"
"300153476|dialloramatoulayebah|129418622"
"300153747|madjou15|211754108"
"300154718|stephanetidjet|243453409"
)

## Example: iterate and access each part
# for entry in "${STUDENTS[@]}"; do
  # IFS='|' read -r STUDENT_ID GITHUB_ID AVATAR <<< "$entry"
  # echo "Student: $STUDENT_ID, GitHub: $GITHUB_ID, Avatar: $AVATAR"
# done
