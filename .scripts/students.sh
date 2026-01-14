#!/bin/bash

# Combined array: each entry = "student_id|github_id|avatar_id"
STUDENTS=(
"300141550|emeraudesantu|211749528"
"300141567|arsprod2001|169725025"
"300146667|djaberbenyezza|205994773"
"300148210|zianiferiel|233097107"
"300148450|adjaoud-git|205994730"
"300150205|blbsblm|205994753"
"300150293|octocat|583231"
"300150399|chkips|195236786"
"300150417|latifmuristaga|212187666"
"300150527|akrembouraoui|212277460"
"300150562|isako29|205994758"
"300151469|Rabia-777|206001876"
"300151492|hacen19|206000307"
"300151825|FeatFreedy|195238262"
"300151833|raoufbrs15|109877652"
"300153476|dialloramatoulayebah|129418622"
"300153747|madjou15|211754108"
"300154718|octocat|583231"
)

## Example: iterate and access each part
# for entry in "${STUDENTS[@]}"; do
  # IFS='|' read -r STUDENT_ID GITHUB_ID AVATAR <<< "$entry"
  # echo "Student: $STUDENT_ID, GitHub: $GITHUB_ID, Avatar: $AVATAR"
# done
