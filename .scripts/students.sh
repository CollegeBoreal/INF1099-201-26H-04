#!/bin/bash

# Combined array: each entry = "student_id|github_id|avatar_id"
STUDENTS=(
"300141550|octocat|583231"
"300141567|octocat|583231"
"300146667|octocat|583231"
"300148210|octocat|583231"
"300148450|octocat|583231"
"300150205|octocat|583231"
"300150293|octocat|583231"
"300150399|octocat|583231"
"300150417|octocat|583231"
"300150527|octocat|583231"
"300150562|octocat|583231"
"300151469|octocat|583231"
"300151492|octocat|583231"
"300151825|octocat|583231"
"300151833|octocat|583231"
"300153476|octocat|583231"
"300153747|octocat|583231"
"300154718|octocat|583231"
)

## Example: iterate and access each part
#for entry in "${STUDENTS[@]}"; do
  #IFS='|' read -r STUDENT_ID GITHUB_ID AVATAR <<< "$entry"
  #echo "Student: $STUDENT_ID, GitHub: $GITHUB_ID, Avatar: $AVATAR"
#done
