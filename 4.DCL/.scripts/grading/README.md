# Setup

## :zero: Class - INF1099-201-26H-04 - Administration de base de données

- [ ] courseids[0]=2

```
https://${LMS_URL}/course/view.php?id=2
```

## :one: LMS Assignment ID = 12

```
https://${LMS_URL}/mod/assign/view.php?id=5
```

- [ ] "id": 12 :point_left: Take this as the assignment number !!!
- [ ] "cmid": 16

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
```

## :two: Rubric Definition CMID = 16

```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=core_grading_get_definitions" \
-d "moodlewsrestformat=json" \
-d "cmids[0]=16" \
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
      "cmid": 16,
      "contextid": 463,
      "component": "mod_assign",
      "areaname": "submissions",
      "activemethod": "rubric",
      "definitions": [
        {
          "id": 11,
          "method": "rubric",
          "name": "🅰️ Présence",
          "description": "",
          "descriptionformat": 1,
          "status": 20,
          "copiedfromid": null,
          "timecreated": 1776895739,
          "usercreated": 3,
          "timemodified": 1776895739,
          "usermodified": 3,
          "timecopied": 0,
          "rubric": {
            "rubric_criteria": [
              {
                "id": 45,
                "sortorder": 1,
                "description": "README.md",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 103,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 104,
                    "score": 1,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 105,
                    "score": 2,
                    "definition": "🥇",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 46,
                "sortorder": 2,
                "description": "images",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 106,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 107,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 47,
                "sortorder": 3,
                "description": "🧮",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 108,
                    "score": 0,
                    "definition": "0️⃣",
                    "definitionformat": 1
                  },
                  {
                    "id": 109,
                    "score": 1,
                    "definition": "1️⃣",
                    "definitionformat": 1
                  },
                  {
                    "id": 110,
                    "score": 2,
                    "definition": "*️⃣",
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
