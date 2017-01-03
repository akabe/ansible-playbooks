#!/bin/sh
#
# chkconfig: 2345 99 01
# description: JupyterHub

pid_file="{{ jupyterhub_pid_file }}"

start() {
    echo -n "Starting JupyterHub       "
    sudo -u "{{ jupyterhub_user }}" \
         /usr/local/bin/jupyterhub \
         --config={{ jupyterhub_config_file }} \
         --JupyterHub.spawner_class=sudospawner.SudoSpawner &
    echo "$!" > $pid_file
    echo "[ OK ]"
}

stop() {
    echo -n "Stopping JupyterHub       "
    local pid=$(cat "$pid_file")
    kill $pid
    rm -f "$pid_file"
    echo "[ OK ]"
}

status() {
    if [ -f "$pid_file" ]; then
        local pid=$(cat "$pid_file")
        echo "JupyterHub is running (pid $pid)"
    else
        echo "JupyterHub stopped."
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
