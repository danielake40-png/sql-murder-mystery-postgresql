# SQL Murder Mystery — Investigating a Crime Using PostgreSQL

## Project Overview

A murder occurred in SQL City on **January 15, 2018**. I used SQL and a relational police database to investigate the available evidence, identify the murderer, and determine who hired the murderer.

This project demonstrates how SQL can be used to turn narrative clues into structured data analysis and progressively narrow down potential suspects.

## Objective

The investigation aimed to:

1. Retrieve the original crime scene report.
2. Identify the two witnesses.
3. Analyze their interview statements.
4. Search the database for people matching the clues.
5. Identify the murderer.
6. Determine who hired the murderer.

## Tools & Technologies

- **Database:** PostgreSQL
- **Language:** SQL
- **Project Type:** Data investigation / relational database analysis

## SQL Skills Demonstrated

- `SELECT`
- `WHERE`
- `LIKE`
- `ORDER BY`
- `LIMIT`
- `JOIN`
- `GROUP BY`
- `HAVING`
- `COUNT()`
- Filtering
- Pattern matching
- Relational database analysis
- Evidence validation

## Investigation Process

### 1. Crime Scene Report

I filtered the `crime_scene_report` table using:

- Date: January 15, 2018
- City: SQL City
- Crime type: murder

The report provided the information needed to identify two witnesses.

### 2. Witness Identification

The first witness was identified by finding the person living at the highest address number on Northwestern Dr.

**Witness 1:** Morty Schapiro

The second witness was identified from the clue that the witness lived on Franklin Ave.

**Witness 2:** Annabel Miller

### 3. Witness Interviews

The witness interviews provided the following evidence:

**Morty Schapiro**
- The suspect was a man.
- He carried a Get Fit Now Gym bag.
- His membership number started with `48Z`.
- The relevant membership was gold.
- His vehicle license plate contained `H42W`.
- Morty had seen the suspect at the gym.

**Annabel Miller**
- She recognized the killer from her gym.
- She had seen him working out on January 9, 2018.

### 4. Gym Membership Investigation

I searched for gold Get Fit Now members whose membership IDs started with `48Z`.

This produced two candidates:

- Joe Germuska
- Jeremy Bowers

### 5. Cross-Checking Gym and Vehicle Evidence

I joined the gym membership, gym check-in, person, and driver's-license tables.

I filtered for:

- `48Z` membership prefix
- Gold membership
- Gym attendance on January 9, 2018
- License plate containing `H42W`

The combined evidence narrowed the investigation to:

**Jeremy Bowers**

### 6. Jeremy Bowers Interview

Jeremy's interview provided new clues about the person who hired him:

- Woman
- Approximately 65–67 inches tall
- Red hair
- Tesla Model S
- Attended the SQL Symphony Concert three times in December 2017

### 7. Concert Attendance Analysis

I grouped SQL Symphony Concert attendance by person and used `HAVING COUNT(*) = 3` to identify people who attended exactly three times during December 2017.

Two candidates were found:

1. Bryan Pardo
2. Miranda Priestly

Because Jeremy described the person who hired him as a woman, Bryan Pardo was eliminated.

### 8. Final Validation

I checked Miranda Priestly's driver's-license information against Jeremy's description.

The records matched the key clues:

- Female
- Height within the 65–67 inch range
- Red hair
- Tesla Model S

## Final Findings

| Finding | Result |
|---|---|
| Murderer | **Jeremy Bowers** |
| Person who hired the murderer | **Miranda Priestly** |

## Key Learning

This project taught me that SQL is not only a language for retrieving records. It can also be used to investigate real-world-style problems.

The most important lesson was to:

> Break a complex problem into smaller questions, connect evidence across related tables, and validate the final result using multiple independent clues.

## Portfolio Takeaway

This project demonstrates my ability to:

- Understand a business-style problem
- Break a problem into analytical questions
- Query relational databases
- Combine information across multiple tables
- Filter and validate evidence
- Use aggregation to identify patterns
- Communicate analytical findings clearly

## Repository Structure

```text
SQL-Murder-Mystery-PostgreSQL/
│
├── README.md
├── investigation.sql
└── screenshots/
    └── README.md
```

## Screenshots

Screenshots of important query results can be added to the `screenshots` folder to visually document the investigation.

Suggested screenshots:

1. Crime scene report
2. Morty Schapiro identification
3. Annabel Miller identification
4. Gym membership candidates
5. Jeremy Bowers evidence
6. Concert attendance candidates
7. Miranda Priestly validation

## Author

**Daniel Ake**

Data Analytics Portfolio Project  
PostgreSQL | SQL | Data Investigation
