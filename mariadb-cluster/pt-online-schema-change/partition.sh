#!/bin/bash

db=$1
table=$2
id=root
password=root

echo "DB : ${db}"
echo "TABLE : ${table}"
echo "ID : ${id}"
echo "Password: ${password}"

pt-online-schema-change \
--alter "PARTITION BY RANGE(year(read_datetime))
(
        PARTITION p2017 VALUES LESS THAN (2018),
        PARTITION p2018 VALUES LESS THAN (2019),
        PARTITION p2019 VALUES LESS THAN (2020),
        PARTITION p2020 VALUES LESS THAN (2021),
        PARTITION p2021 VALUES LESS THAN (2022),
        PARTITION p2022 VALUES LESS THAN (2023),
        PARTITION p2023 VALUES LESS THAN (2024),
        PARTITION p2024 VALUES LESS THAN (2025),
        PARTITION p2025 VALUES LESS THAN (2026),
        PARTITION p2026 VALUES LESS THAN (2027),
        PARTITION p2027 VALUES LESS THAN (2028),
        PARTITION p2028 VALUES LESS THAN (2029),
        PARTITION p2029 VALUES LESS THAN (2030),
        PARTITION p2030 VALUES LESS THAN (2031),
        PARTITION p2031 VALUES LESS THAN (2032),
        PARTITION p2032 VALUES LESS THAN (2033),
        PARTITION p2033 VALUES LESS THAN (2034),
        PARTITION p2034 VALUES LESS THAN (2035),
        PARTITION p2035 VALUES LESS THAN (2036)
)" D=${db},t=${table} \
--no-drop-old-table \
--progress=time,30 \
--chunk-size=1000 \
--defaults-file=/etc/mysql/my.cnf \
--host=localhost \
--user=${id} \
--password=${password} \
--chunk-index=PRIMARY \
--no-check-replication-filters
--charset=UTF8 \
--execute
