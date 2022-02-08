#/bin/bash
# if [ -z"$1" ]
# then
#     echo "No argument supplied in dump_sync"
#     exit 0;
# fi

# mysqldump --column-statistics=0 -uroot -ppengyouking -h192.168.1.243 game_cfg_102 --ignore-table=game_cfg_102.server_info --ignore-table=game_cfg_102.server_info_copy > ~/102_conf.sql

echo "Started dump.sh"
./dump.sh &
pid=$!
wait $pid
echo "Completed dump.sh"
# echo “Started foo.sh”

echo "Started sync_to_database.sh"
./sync_to_database.sh $1 &
pid=$!
wait $pid
echo "Completed sync_to_database.sh"
