# Setup

## :a: Class - INF1099-201-26H-04 - Administration de base de données

```
https://${LMS_URL}/course/view.php?id=2
```

## :b: Assignments for:

- [ ] courseids[0]=2

```json
{
  "id": 5,              // Assignment ID
  "cmid": 9,            // Rubric Definition CMID
  "name": "1.Domaines"  // Assignment name
}
```

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
<details><summary>📑</summary>

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
{
  "id": 15,
  "cmid": 19,
  "name": "7.PLSQL"
}
{
  "id": 16,
  "cmid": 20,
  "name": "8.NoSQL"
}
```

</details>

