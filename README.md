
# SQL Exercises

This repository contains solutions to SQL exercises that cover a variety of SQL topics, including data manipulation, joins, aggregations, string functions, and more.

## Table of Contents

1. [Data Modeling and DDL](#data-modeling-and-ddl)  
2. [Modifying Data](#modifying-data)  
3. [Basics](#basics)  
4. [Joins](#joins)  
5. [Aggregation](#aggregation)  
6. [String Functions](#string-functions)  

---

## Data Modeling and DDL

### Table Setup (DDL)

```sql
CREATE SCHEMA IF NOT EXISTS cd;

CREATE TABLE cd.members (
   memid INTEGER NOT NULL, 
   surname VARCHAR(200) NOT NULL, 
   firstname VARCHAR(200) NOT NULL, 
   address VARCHAR(300) NOT NULL, 
   zipcode INTEGER NOT NULL, 
   telephone VARCHAR(20) NOT NULL, 
   recommendedby INTEGER,
   joindate TIMESTAMP NOT NULL,
   CONSTRAINT members_pk PRIMARY KEY (memid),
   CONSTRAINT fk_members_recommendedby FOREIGN KEY (recommendedby)
        REFERENCES cd.members(memid) ON DELETE SET NULL
);

CREATE TABLE cd.facilities (
   facid INTEGER NOT NULL, 
   name VARCHAR(100) NOT NULL, 
   membercost NUMERIC NOT NULL, 
   guestcost NUMERIC NOT NULL, 
   initialoutlay NUMERIC NOT NULL, 
   monthlymaintenance NUMERIC NOT NULL, 
   CONSTRAINT facilities_pk PRIMARY KEY (facid)
);

CREATE TABLE cd.bookings (
   bookid INTEGER NOT NULL, 
   facid INTEGER NOT NULL, 
   memid INTEGER NOT NULL, 
   starttime TIMESTAMP NOT NULL,
   slots INTEGER NOT NULL,
   CONSTRAINT bookings_pk PRIMARY KEY (bookid),
   CONSTRAINT fk_bookings_facid FOREIGN KEY (facid) REFERENCES cd.facilities(facid),
   CONSTRAINT fk_bookings_memid FOREIGN KEY (memid) REFERENCES cd.members(memid)
);
````

---

## Modifying Data

### INSERT

```sql
INSERT INTO cd.facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
VALUES (9, 'Spa', 20, 30, 100000, 800);
```

### INSERT with Sequence

```sql
CREATE SEQUENCE cd.facid_seq START 1;

INSERT INTO cd.facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
VALUES (nextval('cd.facid_seq'), 'Spa', 20, 30, 100000, 800);

ALTER TABLE cd.facilities
ALTER COLUMN facid SET DEFAULT nextval('cd.facid_seq');
```

### UPDATE

```sql
UPDATE cd.facilities
SET initialoutlay = 10000
WHERE facid = 1;
```

### UPDATE with Calculation

```sql
UPDATE cd.facilities
SET
  membercost = (SELECT membercost * 1.10 FROM cd.facilities WHERE facid = 0),
  guestcost = (SELECT guestcost * 1.10 FROM cd.facilities WHERE facid = 0)
WHERE facid = 1;
```

### DELETE ALL

```sql
DELETE FROM cd.bookings;
```

### DELETE with Condition

```sql
SELECT * FROM cd.bookings WHERE memid = 37;

DELETE FROM cd.members WHERE memid = 37;
```

---

## Basics

### Basic Query

```sql
SELECT facid, name, membercost, monthlymaintenance
FROM cd.facilities
WHERE membercost > 0 AND membercost < monthlymaintenance / 50;
```

### Pattern Matching with LIKE

```sql
SELECT facid, name, membercost, guestcost, initialoutlay, monthlymaintenance
FROM cd.facilities
WHERE name LIKE '%Tennis%';
```

### IN Clause

```sql
SELECT facid, name, membercost, guestcost, initialoutlay, monthlymaintenance
FROM cd.facilities
WHERE facid IN (1, 5);
```

### Date Filtering

```sql
SELECT memid, surname, firstname, joindate
FROM cd.members
WHERE joindate > '2012-09-01';
```

### UNION: Combine Member and Facility Names

```sql
SELECT surname AS name FROM cd.members
UNION
SELECT name AS name FROM cd.facilities;
```

---

## Joins

### Basic Join

```sql
SELECT b.starttime
FROM cd.bookings b
JOIN cd.members m ON b.memid = m.memid
WHERE m.surname = 'Farrell' AND m.firstname = 'David';
```

### Join with Filters

```sql
SELECT bks.starttime AS start, facs.name AS name
FROM cd.facilities facs
INNER JOIN cd.bookings bks ON facs.facid = bks.facid
WHERE facs.name IN ('Tennis Court 1', 'Tennis Court 2')
  AND bks.starttime >= '2012-09-21'
  AND bks.starttime < '2012-09-22'
ORDER BY bks.starttime;
```

### Self Join

```sql
SELECT m1.firstname AS memfname, m1.surname AS memsname,
       m2.firstname AS recfname, m2.surname AS recsname
FROM cd.members m1
LEFT JOIN cd.members m2 ON m1.recommendedby = m2.memid
ORDER BY m1.surname, m1.firstname;
```

### Recommenders Only

```sql
SELECT DISTINCT m1.firstname, m1.surname
FROM cd.members m1
WHERE m1.memid IN (
  SELECT recommendedby FROM cd.members WHERE recommendedby IS NOT NULL
)
ORDER BY m1.surname, m1.firstname;
```

### Subquery + Join

```sql
SELECT DISTINCT mems.firstname || ' ' || mems.surname AS member,
       (SELECT recs.firstname || ' ' || recs.surname
        FROM cd.members recs
        WHERE recs.memid = mems.recommendedby)
FROM cd.members mems
ORDER BY member;
```

---

## Aggregation

### Recommendation Count

```sql
SELECT recommendedby AS member_id, COUNT(*) AS recommendation_count
FROM cd.members
WHERE recommendedby IS NOT NULL
GROUP BY recommendedby
ORDER BY member_id;
```

### Facility Slot Sum

```sql
SELECT facid, SUM(slots) AS total_slots
FROM cd.bookings
GROUP BY facid
ORDER BY facid;
```

### Facility Slots by Month

```sql
SELECT facid, SUM(slots) AS total_slots
FROM cd.bookings
WHERE starttime >= '2012-09-01' AND starttime < '2012-10-01'
GROUP BY facid
ORDER BY total_slots;
```

### Group By Multi-Column

```sql
SELECT facid, EXTRACT(MONTH FROM starttime) AS month, SUM(slots) AS total_slots
FROM cd.bookings
WHERE starttime >= '2012-01-01' AND starttime < '2013-01-01'
GROUP BY facid, EXTRACT(MONTH FROM starttime)
ORDER BY facid, month;
```

### Count Distinct Members

```sql
SELECT COUNT(DISTINCT memid) AS total_members_with_bookings
FROM cd.bookings
WHERE memid IS NOT NULL;
```

### Join + Group By

```sql
SELECT mems.surname, mems.firstname, mems.memid,
       MIN(bks.starttime) AS first_booking_after_september_1_2012
FROM cd.members mems
JOIN cd.bookings bks ON mems.memid = bks.memid
WHERE bks.starttime > '2012-09-01'
GROUP BY mems.memid, mems.firstname, mems.surname
ORDER BY mems.memid;
```

### Window Function

```sql
SELECT COUNT(*) OVER() AS count, mems.firstname, mems.surname
FROM cd.members mems
ORDER BY mems.joindate;
```

### Row Number

```sql
SELECT ROW_NUMBER() OVER (ORDER BY joindate) AS row_number, firstname, surname
FROM cd.members
ORDER BY joindate;
```

### Max Total Slots

```sql
WITH slot_counts AS (
  SELECT facid, SUM(slots) AS total
  FROM cd.bookings
  GROUP BY facid
)
SELECT facid, total
FROM slot_counts
WHERE total = (SELECT MAX(total) FROM slot_counts);
```

---

## String Functions

### Concatenate

```sql
SELECT surname || ', ' || firstname AS name
FROM cd.members;
```

### WHERE + String Pattern

```sql
SELECT memid, telephone
FROM cd.members
WHERE telephone LIKE '%(%' OR telephone LIKE '%)%'
ORDER BY memid;
```

### Substring + Group By

```sql
SELECT SUBSTRING(surname FROM 1 FOR 1) AS letter, COUNT(*) AS count
FROM cd.members
GROUP BY letter
ORDER BY letter;
```

---


