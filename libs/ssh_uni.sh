set -a

ssh_uni() {
    local host_login="login-stud.informatik.uni-bonn.de"
    local host_destination_default="robo18"
    local username_default="karacora"
    local ports_default=("9999")

    local host_destination="$host_destination_default"
    local username="$username_default"
    local ports=("${ports_default[@]}")
    local ssh_cmd=""

    usage() {
        echo "Usage:"
        echo "  ssh_uni [-H <host>] [-U <username>] <port1> <port2> ..."
        echo
        echo "Options:"
        echo " -h, --help		Display this help message and exit."
        echo " -H, --host		Destination host name. Default is \"$host_destination_default\"."
        echo " -U, --user		Username at destination host. Default is \"$username_default\"."
        echo
        echo "Custom SSH command for connecting to a network node of the University of Bonn."
        echo "Jumps over $host_login if destination host is not directly reachable."
        echo "Ports [${ports_default[@]}] are always forwarded."
        echo
    }

    parse_args() {
        local arg=""
        while [[ $# -gt 0 ]]; do
            arg="$1"
            shift
            case $arg in
            -h | --help)
                usage
                return 0
                ;;
            -H | --host)
                host_destination="$1"
                shift
                ;;
            -U | --user)
                username="$1"
                shift
                ;;
            -* | --*)
                echo "Unknown option $1"
                return 1
                ;;
            *)
                ports+=("$arg")
                ;;
            esac
        done
    }

    host_reachable() {
        ping "$host_destination" -c 1 &>/dev/null
    }

    construct_cmd() {
        local ssh_cmd="ssh "
        ssh_cmd+="$username@$host_destination "

        if ! host_reachable; then
            ssh_cmd+="-J $username@$host_login "
        fi

        for port in "${ports[@]}"; do
            ssh_cmd+="-L ${port}:localhost:${port} "
        done

        echo "$ssh_cmd"
    }

    parse_args "$@"

    ssh_cmd="$(construct_cmd)"
    eval "$ssh_cmd"
}
