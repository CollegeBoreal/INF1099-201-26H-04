# Setup

## :a: LMS Assignment ID = 16

```
https://${LMS_URL}/mod/assign/view.php?id=16
```

```json
{
  "id": 16,              // Assignment ID
  "cmid": 20,            // Rubric Definition CMID
  "name": "8.NoSQL"      // Assignment name
}
```

## :b: Rubric Definition for

- [ ] cmids[0]=20

- [ ] Retrieve all rubric definitions from LMS


```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=core_grading_get_definitions" \
-d "moodlewsrestformat=json" \
-d "cmids[0]=20" \
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
      "cmid": 20,
      "contextid": 470,
      "component": "mod_assign",
      "areaname": "submissions",
      "activemethod": "rubric",
      "definitions": [
        {
          "id": 15,
          "method": "rubric",
          "name": "🅰️ Présence",
          "description": "",
          "descriptionformat": 1,
          "status": 20,
          "copiedfromid": null,
          "timecreated": 1776911766,
          "usercreated": 3,
          "timemodified": 1776911847,
          "usermodified": 3,
          "timecopied": 0,
          "rubric": {
            "rubric_criteria": [
              {
                "id": 69,
                "sortorder": 1,
                "description": "README.md",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 159,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 160,
                    "score": 1,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 161,
                    "score": 2,
                    "definition": "🥇",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 70,
                "sortorder": 2,
                "description": "images",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 162,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 163,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 71,
                "sortorder": 3,
                "description": "init.sql",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 164,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 165,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 72,
                "sortorder": 4,
                "description": "app.py",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 166,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 167,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 73,
                "sortorder": 5,
                "description": "requirements.txt",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 168,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 169,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 74,
                "sortorder": 6,
                "description": "🪤 DB",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 170,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 171,
                    "score": 1,
                    "definition": "💥",
                    "definitionformat": 1
                  },
                  {
                    "id": 172,
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
