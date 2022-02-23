#/bin/bash
# if [ -z"$1" ]
# then
#     echo "No argument supplied in table name"
#     exit 0;
# fi
echo "Started dump.sh"

mysqldump --column-statistics=0 -uroot -ppengyouking -h192.168.1.243 game_cfg_102 $1 --ignore-table=game_cfg_102.server_info --ignore-table=game_cfg_102.server_info_copy > ~/102_conf.sql



pid=$!
wait $pid
echo "Completed dump.sh"

echo "Started sync_to_database.sh"
./sync_to_database.sh 107
pid=$!
wait $pid
echo "Completed sync_to_database.sh " $1

echo


time4=$(date "+%Y.%m.%d")
echo $time4

cp 102_conf.sql backup
cd backup
mv 102_conf.sql $1_107_$time4.sql

tail -n 1 $1_107_$time4.sql

# cat 102_conf.sql