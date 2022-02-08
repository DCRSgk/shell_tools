#/bin/bash
if [ x"$1" = x ]; then
    echo "need table name"
    exit 1
fi
echo "Started dump.sh"

mysqldump --column-statistics=0 -uroot -ppengyouking -h192.168.1.243 game_cfg_107 $1 --ignore-table=game_cfg_107.server_info --ignore-table=game_cfg_107.server_info_copy > ~/102_conf.sql



pid=$!
wait $pid
echo "Completed dump.sh"

echo "Started sync_to_database.sh"
./sync_to_database.sh 102 &
pid=$!
wait $pid
echo "Completed sync_to_database.sh"

# # cat 102_conf.sql

time4=$(date "+%Y.%m.%d")
echo $time4


cp 102_conf.sql backup
cd backup
mv 102_conf.sql $1_102_$time4.sql

tail -n 1 $1_102_$time4.sql