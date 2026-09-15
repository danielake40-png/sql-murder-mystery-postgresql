/*
============================================================
SQL MURDER MYSTERY — POSTGRESQL
Portfolio Project
============================================================

PROJECT OBJECTIVE
A murder occurred in SQL City on January 15, 2018. Using
a relational police database, the investigation identifies:
1. The original crime scene report
2. The two witnesses
3. Evidence from witness interviews
4. The murderer
5. The person who hired the murderer

DATABASE: PostgreSQL
LANGUAGE: SQL
PROJECT TYPE: Data investigation / relational database analysis

SQL TECHNIQUES
SELECT, WHERE, LIKE, ORDER BY, LIMIT, JOIN, GROUP BY,
HAVING, COUNT(), FILTERING, PATTERN MATCHING, SUBQUERIES
*/


/* =========================================================
   STEP 1 — LOCATE THE CRIME SCENE REPORT
   ========================================================= */

SELECT date, type, city, description
FROM crime_scene_report
WHERE date = 20180115
  AND city = 'SQL City'
  AND type = 'murder';


/* FINDING:
   The query returned the murder report for SQL City on
   January 15, 2018. The report provided the clues needed
   to identify the two witnesses.
*/


/* =========================================================
   STEP 2 — IDENTIFY THE WITNESSES
   ========================================================= */

-- Witness 1: the person living at the last house on
-- Northwestern Dr.

SELECT name, address_street_name, address_number
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;

-- FINDING: Morty Schapiro


-- Witness 2: Annabel living on Franklin Ave.

SELECT name, address_street_name, address_number
FROM person
WHERE name LIKE 'Annabel%'
  AND address_street_name = 'Franklin Ave';

-- FINDING: Annabel Miller


/* =========================================================
   STEP 3 — ANALYZE THE WITNESS INTERVIEWS
   ========================================================= */

-- Morty Schapiro's interview

SELECT p.name, i.transcript
FROM person AS p
JOIN interview AS i
  ON p.id = i.person_id
WHERE p.name = 'Morty Schapiro';

-- KEY CLUES FROM MORTY:
-- • The suspect was a man.
-- • He carried a Get Fit Now Gym bag.
-- • His membership number started with 48Z.
-- • The bag was associated with a gold membership.
-- • His vehicle plate contained H42W.
-- • Morty had seen the suspect at the gym.


-- Annabel Miller's interview

SELECT p.name, i.transcript
FROM person AS p
JOIN interview AS i
  ON p.id = i.person_id
WHERE p.name = 'Annabel Miller';

-- KEY CLUE FROM ANNABEL:
-- She recognized the killer from her gym and had seen
-- him working out on January 9, 2018.

-- Combined, the witness statements point to a male gold
-- Get Fit Now member with a 48Z membership prefix who
-- attended the gym on January 9 and drove a vehicle
-- with a plate containing H42W.


/* =========================================================
   STEP 4 — FILTER THE GYM MEMBERSHIP RECORDS
   ========================================================= */

SELECT id, person_id, membership_status
FROM get_fit_now_member
WHERE id LIKE '48Z%'
  AND membership_status = 'gold';

-- FINDING:
-- Two candidates matched the membership clues:
-- • Joe Germuska
-- • Jeremy Bowers


/* =========================================================
   STEP 5 — CROSS-CHECK GYM ATTENDANCE AND VEHICLE EVIDENCE
   ========================================================= */

SELECT
    m.id AS membership_id,
    m.person_id,
    p.name,
    c.check_in_date,
    c.check_in_time,
    c.check_out_time,
    dl.plate_number
FROM get_fit_now_member AS m
JOIN get_fit_now_check_in AS c
  ON m.id = c.membership_id
JOIN person AS p
  ON m.person_id = p.id
JOIN drivers_license AS dl
  ON p.license_id = dl.id
WHERE m.id LIKE '48Z%'
  AND m.membership_status = 'gold'
  AND c.check_in_date = 20180109
  AND dl.plate_number LIKE '%H42W%';

-- FINDING:
-- Jeremy Bowers was the only candidate matching the
-- combined gym attendance and vehicle evidence.


/* =========================================================
   STEP 6 — INTERVIEW THE PRIME SUSPECT
   ========================================================= */

SELECT p.name, i.transcript
FROM person AS p
JOIN interview AS i
  ON p.id = i.person_id
WHERE p.name = 'Jeremy Bowers';

-- JEREMY'S CLUES:
-- The person who hired him was:
-- • A woman
-- • Approximately 65–67 inches tall
-- • Red-haired
-- • Driving a Tesla Model S
-- • Seen at the SQL Symphony Concert three times
--   during December 2017


/* =========================================================
   STEP 7 — FIND PEOPLE WHO ATTENDED THE CONCERT EXACTLY
   THREE TIMES IN DECEMBER 2017
   ========================================================= */

SELECT
    p.id,
    p.name,
    COUNT(*) AS attendance_count
FROM person AS p
JOIN facebook_event_checkin AS f
  ON p.id = f.person_id
WHERE f.event_name = 'SQL Symphony Concert'
  AND f.date::text LIKE '201712%'
GROUP BY p.id, p.name
HAVING COUNT(*) = 3;

-- FINDING:
-- Two people attended exactly three times:
-- 1. Bryan Pardo
-- 2. Miranda Priestly
--
-- Jeremy described the person who hired him as a woman,
-- eliminating Bryan Pardo based on the gender clue.


/* =========================================================
   STEP 8 — VALIDATE THE HIRER USING DRIVER'S-LICENSE DATA
   ========================================================= */

SELECT
    p.id,
    p.name,
    dl.gender,
    dl.height,
    dl.hair_color,
    dl.car_make,
    dl.car_model
FROM person AS p
JOIN drivers_license AS dl
  ON p.license_id = dl.id
WHERE p.name = 'Miranda Priestly';

-- VALIDATION:
-- Miranda Priestly matches the key description:
-- • Female
-- • Height within the approximate 65–67 inch range
-- • Red hair
-- • Tesla Model S
--
-- Therefore, Miranda Priestly is identified as the person
-- who hired Jeremy Bowers.


/* =========================================================
   FINAL FINDINGS
   =========================================================

   MURDERER:
   Jeremy Bowers

   PERSON WHO HIRED THE MURDERER:
   Miranda Priestly

   The investigation demonstrates how SQL can transform
   narrative clues into structured database queries and
   progressively narrow a large set of records to a final
   conclusion.
*/


/* =========================================================
   KEY SQL SKILLS DEMONSTRATED
   =========================================================

   SELECT       → Retrieved relevant records
   WHERE        → Filtered evidence
   LIKE         → Pattern matching for names, IDs and plates
   ORDER BY     → Located the highest address number
   LIMIT        → Selected the relevant witness
   JOIN         → Connected related relational tables
   GROUP BY     → Grouped concert attendance by person
   COUNT()      → Counted event attendance
   HAVING       → Filtered people attending exactly 3 times
   SUBQUERIES   → Used for multi-stage filtering during analysis
*/


/* =========================================================
   WHAT I LEARNED
   =========================================================

   1. SQL can be used as an investigative and analytical tool,
      not only for simple data retrieval.

   2. Complex problems become easier when broken into smaller
      analytical questions.

   3. Multiple relational tables can be combined to validate
      evidence from different sources.

   4. Results should be validated against multiple clues before
      reaching a final conclusion.
*/
