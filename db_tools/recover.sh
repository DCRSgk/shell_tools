#/bin/bash
function get_char() {
    SAVEDSTTY=$(stty -g)
    stty -echo
    stty cbreak
    dd if=/dev/tty bs=1 count=1 2>/dev/null
    stty -raw
    stty echo
    stty $SAVEDSTTY
}

function pause() {
    # 启用功能的开关 1开启|其它不开启
    enable_pause=1

    # 判断第一个参数是否为空，约定俗成的写法
    if [ "x$1" != "x" ]; then
        echo $1
    fi
    if [ $enable_pause -eq 1 ]; then
        # echo "Press any key to continue!"
        echo "按任意键继续!"
        char=$(get_char)
    fi
}

function isOK() {
    if [ $1 -eq 0 ]; then
        echo $2
    else
        pause "执行失败，退出程序！"
        exit
    fi
}

if [ x"$1" = x ]; then
    echo "必须输入对应数据库名称"
    exit 1
fi

if [ x"$2" = x ]; then
    echo "必须输入对应文件名"
    exit 1
fi
echo "Started recover.sh"

database="game_cfg_$1"
echo "恢复数据库:${database}"
echo "文件:$2"

read -r -p "Are You Sure? [Y/n] " input

case $input in
[yY][eE][sS] | [yY])
    mysql -uroot -ppengyouking -h192.168.1.243 -D${database} <$2
    isOK $? "使用 $2 恢复数据库:${database} 成功"
    ;;

[nN][oO] | [nN])
    echo "exit"
    exit 1
    ;;

*)
    echo "Invalid input..."
    exit 1
    ;;
esac
