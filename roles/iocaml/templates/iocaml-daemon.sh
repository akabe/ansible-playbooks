#!/bin/sh
# chkconfig: 2345 99 01
# description: IOCaml Server

. /etc/rc.d/init.d/functions

pidfile=/var/lock/subsys/iocaml

start() {
    echo "Starting IOCaml server..."

    su "{{ iocaml_user }}" --login -c "iocaml {{ iocaml_options }}" 1>{{ iocaml_log_path }} 2>&1 &
    echo "$!" > "$pidfile"
}

stop() {
    echo "Stopping IOCaml server..."

    if [ -f "$pidfile" ]; then
        local pid="$(cat $pidfile)"
        if [ -n "$pid" ]; then
            kill "$pid"
            local status=$?
            sleep 2
            echo "Exited IOCaml server: status=$status"
        fi
        rm -f "$pidfile"
    fi
}

status() {
    if [ -f "$pidfile" ]; then
        echo "IOCaml is running... pid=$(cat $pidfile)"
    else
        echo "IOCaml is stopped..."
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    status)
        status
        ;;
esac
