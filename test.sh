#!/bin/bash

rm -f test.sqlite

echo "
CREATE TABLE table1 (t1 INTEGER);
CREATE TABLE table2 (t2 INTEGER);
CREATE VIEW view1 AS SELECT t1 AS v1 FROM table1;
" | sqlite3 test.sqlite

autoreconf --install
./configure
make

./sqlite3_column_origin test.sqlite 'SELECT v1, 1 + 2, v1 + 2 FROM view1' | tr '\0' ';'
echo ''
./sqlite3_column_origin test.sqlite 'SELECT * FROM table1 JOIN table2' | tr '\0' ';'
echo ''
