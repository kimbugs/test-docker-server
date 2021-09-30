stop slave;

reset slave;

set global gtid_slave_pos='0-3001-7256';

change master to master_host='server1', master_port=3306, master_user='replication_user', master_password='replication', master_use_gtid=slave_pos;

start slave;