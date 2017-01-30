#!/bin/sh

# chkconfig: 345 84 15
# description: Jupyter
# processname: jupyter

progname=jupyter
logfile={{ jupyter_log_file }}
lockfile=/var/run/subsys/jupyter
pidfile=$lockfile

wait_port_to_open() {
    local port="$1"
    for i in $(seq 1 10); do
        if nc -z localhost $port >/dev/null 2>&1; then
            break
        else
            sleep 3
        fi
    done
}

wait_process_to_die() {
    if ! [ -f "$pidfile" ]; then
        echo "$progname is not running."
        return 1
    fi
    local pid="$(cat $pidfile)"
    if [ -n "$pid" ]; then
        local forcekill=1
        for i in $(seq 1 10); do
            kill $pid >/dev/null 2>&1
            if kill -0 $pid >/dev/null 2>&1; then # check the process is alive
                sleep 3
            else
                forcekill=0
                break
            fi
        done
        if [[ forceKill -ne 0 ]]; then
            kill -9 $pid >/dev/null 2>&1
        fi
    else
        echo "$progname is not running."
        return 1
    fi

    rm -f "$pidfile"
}

start() {
    if [ -f "$pidfile" ]; then
        echo "$progname is already running."
        return 1
    fi

    echo "Starting $progname..."

    mkdir -p "$(dirname $lockfile)"
    su "{{ jupyter_user }}" --login -c "jupyter notebook" >$logfile 2>&1 &
    echo "$!" >$pidfile
    wait_port_to_open {{ jupyter_port }}
}

stop() {
    echo "Shutting down $progname..."
    wait_process_to_die
}

status() {
    if nc -z localhost {{ jupyter_port }} >/dev/null 2>&1; then
        echo "$progname is running."
    else
        echo "$progname is down."
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
