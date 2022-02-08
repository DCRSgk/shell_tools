#/bin/bash

database="game_cfg_$1"
echo ${database}

mysql -uroot -ppengyouking -h192.168.1.243  -D${database}<~/102_conf.sql