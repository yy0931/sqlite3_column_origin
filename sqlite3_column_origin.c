#include <stdio.h>
#include <stdlib.h>
#include <sqlite3.h>
#include <string.h>

int main(int argc, char **argv) {
    if (argc == 2 && strcmp(argv[1], "--version") == 0) {
        fprintf(stderr, "1.0.0");  // semver
        return 1;
    }
    if (argc < 3) {
        fprintf(stderr, "Usage: %s <database> <query>\n\n", argv[0]);
        fprintf(stderr, "Outputs the source of each column in the query in the following format.\n");
        fprintf(stderr, "database-name\\0table-name\\0column-name\\0\n");
        fprintf(stderr, "The database, table, and column names are encoded in UTF-8.\n");
        fprintf(stderr, "If a column is an expression, \\0\\0\\0 will be output.\n\n");
        fprintf(stderr, "To get the version of program, use: \"%s --version\".\n", argv[0]);
        return 1;
    }

    // Open the database connection
    sqlite3 *db;
    int      rc = sqlite3_open(argv[1], &db);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "Error opening database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return 1;
    }

    // Prepare the SELECT statement
    sqlite3_stmt *stmt;
    rc = sqlite3_prepare_v2(db, argv[2], -1, &stmt, NULL);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "Error preparing statement: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return 1;
    }

    // Get the data sources and print them using \0 as delimiters
    int count = sqlite3_column_count(stmt);
    const char *str;
    for (int i = 0; i < count; i++) {
        str = sqlite3_column_database_name(stmt, i);
        if (str != NULL) {
            printf("%s", str);
        }
        putchar(0);
        str = sqlite3_column_table_name(stmt, i);
        if (str != NULL) {
            printf("%s", str);
        }
        putchar(0);
        str = sqlite3_column_origin_name(stmt, i);
        if (str != NULL) {
            printf("%s", str);
        }
        putchar(0);
    }

    // Finalize the statement and close the database connection
    sqlite3_finalize(stmt);
    sqlite3_close(db);

    return 0;
}
