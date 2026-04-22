# Setup

## :zero: Class - INF1099-201-26H-04 - Administration de base de données

- [ ] courseids[0]=2

```
https://${LMS_URL}/course/view.php?id=2
```

## :one: LMS Assignment ID = 10

```
https://${LMS_URL}/mod/assign/view.php?id=5
```

- [ ] "id": 10 :point_left: Take this as the assignment number !!!
- [ ] "cmid": 14

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
  "id": 1,
  "cmid": 2,
  "name": "0.Plan De Cours"
}
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
```

## :two: Rubric Definition CMID = 13

```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=core_grading_get_definitions" \
-d "moodlewsrestformat=json" \
-d "cmids[0]=14" \
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
      "cmid": 14,
      "contextid": 461,
      "component": "mod_assign",
      "areaname": "submissions",
      "activemethod": "rubric",
      "definitions": [
        {
          "id": 9,
          "method": "rubric",
          "name": "🅰️ Présence",
          "description": "",
          "descriptionformat": 1,
          "status": 20,
          "copiedfromid": null,
          "timecreated": 1776887540,
          "usercreated": 3,
          "timemodified": 1776887782,
          "usermodified": 3,
          "timecopied": 0,
          "rubric": {
            "rubric_criteria": [
              {
                "id": 36,
                "sortorder": 1,
                "description": "README.md",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 81,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 82,
                    "score": 1,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 83,
                    "score": 2,
                    "definition": "🥇",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 37,
                "sortorder": 2,
                "description": "images",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 84,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 85,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 38,
                "sortorder": 3,
                "description": "🧮",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 86,
                    "score": 0,
                    "definition": "0️⃣",
                    "definitionformat": 1
                  },
                  {
                    "id": 87,
                    "score": 1,
                    "definition": "1️⃣",
                    "definitionformat": 1
                  },
                  {
                    "id": 94,
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
