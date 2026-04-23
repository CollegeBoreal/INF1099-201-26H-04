# Setup

## :a: LMS Assignment ID = 5

```
https://${LMS_URL}/mod/assign/view.php?id=5
```

```json
{
  "id": 5,              // Assignment ID
  "cmid": 9,            // Rubric Definition CMID
  "name": "1.Domaines"     // Assignment name
}
```

## :b: Rubric Definition for

- [ ] cmids[0]=9

- [ ] Retrieve all rubric definitions from LMS


```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=core_grading_get_definitions" \
-d "moodlewsrestformat=json" \
-d "cmids[0]=9" \
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
      "cmid": 9,
      "contextid": 444,
      "component": "mod_assign",
      "areaname": "submissions",
      "activemethod": "rubric",
      "definitions": [
        {
          "id": 4,
          "method": "rubric",
          "name": "Participation",
          "description": "",
          "descriptionformat": 1,
          "status": 20,
          "copiedfromid": null,
          "timecreated": 1776697994,
          "usercreated": 3,
          "timemodified": 1776872403,
          "usermodified": 3,
          "timecopied": 0,
          "rubric": {
            "rubric_criteria": [
              {
                "id": 13,
                "sortorder": 1,
                "description": "README.md",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 30,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 31,
                    "score": 1,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 32,
                    "score": 2,
                    "definition": "🥇",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 31,
                "sortorder": 2,
                "description": "images",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 71,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 72,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 32,
                "sortorder": 3,
                "description": "Modele",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 73,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 74,
                    "score": 1,
                    "definition": "🧭",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 33,
                "sortorder": 4,
                "description": "1FN.txt",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 75,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 76,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 34,
                "sortorder": 5,
                "description": "2FN.txt",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 77,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 78,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 35,
                "sortorder": 6,
                "description": "3FN.txt",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 79,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 80,
                    "score": 1,
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
