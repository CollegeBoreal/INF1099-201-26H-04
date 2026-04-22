# Setup

## :zero: Class - INF1099-201-26H-04 - Administration de base de données

- [ ] courseids[0]=2

```
https://${LMS_URL}/course/view.php?id=2
```

## :one: LMS Assignment ID = 14

```
https://${LMS_URL}/mod/assign/view.php?id=5
```

- [ ] "id": 14 :point_left: Take this as the assignment number !!!
- [ ] "cmid": 18

```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=mod_assign_get_assignments" \
-d "moodlewsrestformat=json" \
-d "courseids[0]=2" | jq '.courses[].assignments[] | {id, cmid, name}'
```
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1704    0  1587  100   117   2463    181 --:--:-- --:--:-- --:--:--  2645
```
```json
{
  "id": 5,
  "cmid": 9,
  "name": "1.Domaines"
}
{
  "id": 10,
  "cmid": 14,
  "name": "2.MySQL"
}
{
  "id": 11,
  "cmid": 15,
  "name": "3.Postgres"
}
{
  "id": 12,
  "cmid": 16,
  "name": "4.DCL"
}
{
  "id": 13,
  "cmid": 17,
  "name": "5.ModelisationSQL"
}
{
  "id": 14,
  "cmid": 18,
  "name": "6.BATCH"
}
```

## :two: Rubric Definition CMID = 18

```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=core_grading_get_definitions" \
-d "moodlewsrestformat=json" \
-d "cmids[0]=18" \
-d "areaname=submissions" | jq .
```
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  2397    0  2261  100   136   3849    231 --:--:-- --:--:-- --:--:--  4076
```
<details><summary>📑</summary>

```json
{
  "areas": [
    {
      "cmid": 18,
      "contextid": 465,
      "component": "mod_assign",
      "areaname": "submissions",
      "activemethod": "rubric",
      "definitions": [
        {
          "id": 13,
          "method": "rubric",
          "name": "🅰️ Présence",
          "description": "",
          "descriptionformat": 1,
          "status": 20,
          "copiedfromid": null,
          "timecreated": 1776898458,
          "usercreated": 3,
          "timemodified": 1776898575,
          "usermodified": 3,
          "timecopied": 0,
          "rubric": {
            "rubric_criteria": [
              {
                "id": 55,
                "sortorder": 1,
                "description": "README.md",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 127,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 128,
                    "score": 1,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 129,
                    "score": 2,
                    "definition": "🥇",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 56,
                "sortorder": 2,
                "description": "images",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 130,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 131,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 57,
                "sortorder": 3,
                "description": "DDL.sql",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 132,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 133,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 58,
                "sortorder": 4,
                "description": "DML.sql",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 134,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 135,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 59,
                "sortorder": 5,
                "description": "DQL.sql",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 136,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 137,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 60,
                "sortorder": 6,
                "description": "DCL.sql",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 138,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 139,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 61,
                "sortorder": 7,
                "description": "🪤 DB",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 140,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 141,
                    "score": 1,
                    "definition": "💥",
                    "definitionformat": 1
                  },
                  {
                    "id": 142,
                    "score": 2,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              }
            ]
          }
        }
      ]
    }
  ],
  "warnings": []
}
```

</details>
