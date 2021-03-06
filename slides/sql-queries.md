% SQL Queries
% CS 4400

# The SELECT-FROM-WHERE Structure

```sql
SELECT <attributes>
FROM <tables>
WHERE <conditions>
```

From relational algebra:
- `SELECT <attributes>` corresponds to projection
- `FROM <tables>` specifies the table in parentheses in a relational algebra expression and joins
- `WHERE <conditions>` corresponds to selection

# Projection

$\pi_{first\_name, last\_name}(author)$

```sql
mysql> select first_name, last_name from author;
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| John       | McCarthy  |
| Dennis     | Ritchie   |
| Ken        | Thompson  |
| Claude     | Shannon   |
| Alan       | Turing    |
| Alonzo     | Church    |
| Perry      | White     |
| Moshe      | Vardi     |
| Roy        | Batty     |
+------------+-----------+
9 rows in set (0.00 sec)
```

# Asterisk

```sql
mysql> select * from author;
+-----------+------------+-----------+
| author_id | first_name | last_name |
+-----------+------------+-----------+
|         1 | John       | McCarthy  |
|         2 | Dennis     | Ritchie   |
|         3 | Ken        | Thompson  |
|         4 | Claude     | Shannon   |
|         5 | Alan       | Turing    |
|         6 | Alonzo     | Church    |
|         7 | Perry      | White     |
|         8 | Moshe      | Vardi     |
|         9 | Roy        | Batty     |
+-----------+------------+-----------+
9 rows in set (0.00 sec)
```

Notice that with no condition on select, all rows returned.

# Select

$\sigma_{year = 2012}(book)$

```sql
mysql> select * from book where year = 2012;
+---------+------------+-------+------+--------+
| book_id | book_title | month | year | editor |
+---------+------------+-------+------+--------+
|       7 | AAAI       | July  | 2012 |      9 |
|       8 | NIPS       | July  | 2012 |      9 |
+---------+------------+-------+------+--------+
2 rows in set (0.00 sec)
```

# The FROM Clause

The `FROM` clause takes one or more source tables from the database and combines them into one (large) table using the `JOIN` operator. Three kinds of joins:

- CROSS JOIN
- INNER JOIN
- OUTER JOIN

Sicne DB designs are typically factored into many tables, the join is the most important part of a query.

# CROSS JOIN

A CROSS JOIN matches every row of the first table with every row of the second table. Think of a cross join as a cartesian product.

The general syntax for a cross join is:

```sql
SELECT <select_header> FROM <table1> CROSS JOIN <table2>
```

or

```sql
SELECT <select_header> FROM <table1>, <table2>
```

# CROSS JOIN EXAMPLE

```sql
mysql> select * from pub cross join book;
+--------+-----------------+---------+---------+------------+----------+------+--------+
| Pub_id | title           | book_id | book_id | book_title | month    | year | editor |
+--------+-----------------+---------+---------+------------+----------+------+--------+
|      1 | LISP            |       1 |       1 | CACM       | April    | 1960 |      8 |
|      2 | Unix            |       2 |       1 | CACM       | April    | 1960 |      8 |
|      3 | Info Theory     |       3 |       1 | CACM       | April    | 1960 |      8 |
|      4 | Turing Machines |       4 |       1 | CACM       | April    | 1960 |      8 |
|      5 | Turing Test     |       5 |       1 | CACM       | April    | 1960 |      8 |
|      6 | Lambda Calculus |       6 |       1 | CACM       | April    | 1960 |      8 |
|      1 | LISP            |       1 |       2 | CACM       | July     | 1974 |      8 |
|      2 | Unix            |       2 |       2 | CACM       | July     | 1974 |      8 |
|      3 | Info Theory     |       3 |       2 | CACM       | July     | 1974 |      8 |
|      4 | Turing Machines |       4 |       2 | CACM       | July     | 1974 |      8 |
|      5 | Turing Test     |       5 |       2 | CACM       | July     | 1974 |      8 |
|      6 | Lambda Calculus |       6 |       2 | CACM       | July     | 1974 |      8 |
|      1 | LISP            |       1 |       3 | BST        | July     | 1948 |      2 |
|      2 | Unix            |       2 |       3 | BST        | July     | 1948 |      2 |
|      3 | Info Theory     |       3 |       3 | BST        | July     | 1948 |      2 |
|      4 | Turing Machines |       4 |       3 | BST        | July     | 1948 |      2 |
|      5 | Turing Test     |       5 |       3 | BST        | July     | 1948 |      2 |
|      6 | Lambda Calculus |       6 |       3 | BST        | July     | 1948 |      2 |
|      1 | LISP            |       1 |       4 | LMS        | November | 1936 |      7 |
|      2 | Unix            |       2 |       4 | LMS        | November | 1936 |      7 |
|      3 | Info Theory     |       3 |       4 | LMS        | November | 1936 |      7 |
|      4 | Turing Machines |       4 |       4 | LMS        | November | 1936 |      7 |
|      5 | Turing Test     |       5 |       4 | LMS        | November | 1936 |      7 |
|      6 | Lambda Calculus |       6 |       4 | LMS        | November | 1936 |      7 |
|      1 | LISP            |       1 |       5 | Mind       | October  | 1950 |   NULL |
|      2 | Unix            |       2 |       5 | Mind       | October  | 1950 |   NULL |
|      3 | Info Theory     |       3 |       5 | Mind       | October  | 1950 |   NULL |
|      4 | Turing Machines |       4 |       5 | Mind       | October  | 1950 |   NULL |
|      5 | Turing Test     |       5 |       5 | Mind       | October  | 1950 |   NULL |
|      6 | Lambda Calculus |       6 |       5 | Mind       | October  | 1950 |   NULL |
|      1 | LISP            |       1 |       6 | AMS        | Month    | 1941 |   NULL |
|      2 | Unix            |       2 |       6 | AMS        | Month    | 1941 |   NULL |
|      3 | Info Theory     |       3 |       6 | AMS        | Month    | 1941 |   NULL |
|      4 | Turing Machines |       4 |       6 | AMS        | Month    | 1941 |   NULL |
|      5 | Turing Test     |       5 |       6 | AMS        | Month    | 1941 |   NULL |
|      6 | Lambda Calculus |       6 |       6 | AMS        | Month    | 1941 |   NULL |
|      1 | LISP            |       1 |       7 | AAAI       | July     | 2012 |      9 |
|      2 | Unix            |       2 |       7 | AAAI       | July     | 2012 |      9 |
|      3 | Info Theory     |       3 |       7 | AAAI       | July     | 2012 |      9 |
|      4 | Turing Machines |       4 |       7 | AAAI       | July     | 2012 |      9 |
|      5 | Turing Test     |       5 |       7 | AAAI       | July     | 2012 |      9 |
|      6 | Lambda Calculus |       6 |       7 | AAAI       | July     | 2012 |      9 |
|      1 | LISP            |       1 |       8 | NIPS       | July     | 2012 |      9 |
|      2 | Unix            |       2 |       8 | NIPS       | July     | 2012 |      9 |
|      3 | Info Theory     |       3 |       8 | NIPS       | July     | 2012 |      9 |
|      4 | Turing Machines |       4 |       8 | NIPS       | July     | 2012 |      9 |
|      5 | Turing Test     |       5 |       8 | NIPS       | July     | 2012 |      9 |
|      6 | Lambda Calculus |       6 |       8 | NIPS       | July     | 2012 |      9 |
+--------+-----------------+---------+---------+------------+----------+------+--------+
48 rows in set (0.00 sec)
```

# `LIMIT`ing Results

If we don't want many results to scroll past the bottom of the screen we can limit the number of results using a LIMIT clause.

```sql
mysql> select * from pub, book limit 3;
+--------+-------------+---------+---------+------------+-------+------+--------+
| pub_id | title       | book_id | book_id | book_title | month | year | editor |
+--------+-------------+---------+---------+------------+-------+------+--------+
|      1 | LISP        |       1 |       1 | CACM       | April | 1960 |      8 |
|      2 | Unix        |       2 |       1 | CACM       | April | 1960 |      8 |
|      3 | Info Theory |       3 |       1 | CACM       | April | 1960 |      8 |
+--------+-------------+---------+---------+------------+-------+------+--------+
3 rows in set (0.00 sec)
```
The general form of the `LIMIT` clause is `LIMIT` *start*, *count*, where *start* is the first row returned and *count* is the number of rows returned. If a single value is given, *start* assumes the value 0.


# Inner Joins

A simple inner join uses an `ON` condition.
```sql
mysql> select * from pub join book on pub.book_id = book.book_id;
+--------+-----------------+---------+---------+------------+----------+------+--------+
| pub_id | title           | book_id | book_id | book_title | month    | year | editor |
+--------+-----------------+---------+---------+------------+----------+------+--------+
|      1 | LISP            |       1 |       1 | CACM       | April    | 1960 |      8 |
|      2 | Unix            |       2 |       2 | CACM       | July     | 1974 |      8 |
|      3 | Info Theory     |       3 |       3 | BST        | July     | 1948 |      2 |
|      4 | Turing Machines |       4 |       4 | LMS        | November | 1936 |      7 |
|      5 | Turing Test     |       5 |       5 | Mind       | October  | 1950 |   NULL |
|      6 | Lambda Calculus |       6 |       6 | AMS        | Month    | 1941 |   NULL |
+--------+-----------------+---------+---------+------------+----------+------+--------+
6 rows in set (0.00 sec)
```

Notice that `book_id` appears twice, becuase we get one from each source table. We can fix that ...

# Natural Joins

The `USING` clause, also called a natural join, equijoins on a like-named column from each table and includes the join column only once.

```sql
mysql> select * from pub join book using (book_id);
+---------+--------+-----------------+------------+----------+------+--------+
| book_id | pub_id | title           | book_title | month    | year | editor |
+---------+--------+-----------------+------------+----------+------+--------+
|       1 |      1 | LISP            | CACM       | April    | 1960 |      8 |
|       2 |      2 | Unix            | CACM       | July     | 1974 |      8 |
|       3 |      3 | Info Theory     | BST        | July     | 1948 |      2 |
|       4 |      4 | Turing Machines | LMS        | November | 1936 |      7 |
|       5 |      5 | Turing Test     | Mind       | October  | 1950 |   NULL |
|       6 |      6 | Lambda Calculus | AMS        | Month    | 1941 |   NULL |
+---------+--------+-----------------+------------+----------+------+--------+
6 rows in set (0.00 sec)
```

# Many to Many Relationships

A single author can write many publications, and a single publication can have many authors. This is a many-to-many relationship, which is modeled in relational databases with a relationship (or link or bridge) table.

```sql
CREATE TABLE IF NOT EXISTS author_pub (
  author_id INTEGER NOT NULL REFERENCES author(author_id),
  pub_id INTEGER NOT NULL REFERENCES publication(pub_id),
  author_position INTEGER NOT NULL, -- first author, second, etc?
  PRIMARY KEY (author_id, pub_id)
);
```
`author_pub` tables links the `author` and `pub` tables

- `author_id` and `pub_id` are foreign keys to `author` and `pub` tables
- `(author_id, pub_id) is composite key for the table


# Joining Multiple Tables

We can join all three tables by chaining join clauses:

```sql
mysql> select *
    -> from author join author_pub using (author_id)
    ->   join pub using (pub_id);
+--------+-----------+------------+-----------+-----------------+-----------------+---------+
| pub_id | author_id | first_name | last_name | author_position | title           | book_id |
+--------+-----------+------------+-----------+-----------------+-----------------+---------+
|      1 |         1 | John       | McCarthy  |               1 | LISP            |       1 |
|      2 |         2 | Dennis     | Ritchie   |               1 | Unix            |       2 |
|      2 |         3 | Ken        | Thompson  |               2 | Unix            |       2 |
|      3 |         4 | Claude     | Shannon   |               1 | Info Theory     |       3 |
|      4 |         5 | Alan       | Turing    |               1 | Turing Machines |       4 |
|      5 |         5 | Alan       | Turing    |               1 | Turing Test     |       5 |
|      6 |         6 | Alonzo     | Church    |               1 | Lambda Calculus |       6 |
+--------+-----------+------------+-----------+-----------------+-----------------+---------+
7 rows in set (0.01 sec)

```

# String Matching with `LIKE`

Our where condition can match a pattern with like. Use a % for wildcard, i.e., matching any character sequence.

Which publications have "Turing" in their titles?

```sql
elect * from pub where title like 'Turing%';
+--------+-----------------+---------+
| pub_id | title           | book_id |
+--------+-----------------+---------+
|      4 | Turing Machines |       4 |
|      5 | Turing Test     |       5 |
+--------+-----------------+---------+
2 rows in set (0.00 sec)
```

Note that strings are not case-sensitive.


# Simple Database: Dorms

1. Download [dorms.sql](../resources/dorms.sql)
2. On the command line, go to the directory where you downloaded dorms.sql
3. Make sure your MySQL server is running:
    ```sh
    $ mysql.server start
    Starting MySQL
    SUCCESS!
    ```
4. Run the `dorms.sql` script like this:
    ```sh
    $ mysql -u root -p < dorms.sql
    Enter password:
    ```

# Running Queries on the Dorms Database

Start MySQL's client and `use` the `dorms` database.

    ```sh
    $ mysql -u root -p
    Enter password:
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    ...
    mysql> use dorms
    ...
    Database changed
    mysql>
    ```

# Exploring the Database

Get a list of the tables:

```sql
mysql> show tables;
+-----------------+
| Tables_in_dorms |
+-----------------+
| dorm            |
| student         |
+-----------------+
2 rows in set (0.00 sec)
```

See the structure of a table:

```sql
mysql> describe dorm;
+---------+---------+------+-----+---------+-------+
| Field   | Type    | Null | Key | Default | Extra |
+---------+---------+------+-----+---------+-------+
| dorm_id | int(11) | NO   | PRI | NULL    |       |
| name    | text    | YES  |     | NULL    |       |
| spaces  | int(11) | YES  |     | NULL    |       |
+---------+---------+------+-----+---------+-------+
3 rows in set (0.00 sec)
```

# Simple Queries on Dorms Database

- What are the names of all the dorms?
- Which students have GPAs greater than 3.0?
- Which students are in Armstrong?
- Rank students by GPA.
- Which student has the top GPA?
