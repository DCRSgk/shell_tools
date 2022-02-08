#/bin/bash

mysqldump --column-statistics=0 -uroot -ppengyouking -h192.168.1.243 game_cfg_102 --ignore-table=game_cfg_102.server_info --ignore-table=game_cfg_102.server_info_copy > ~/102_conf.sql

