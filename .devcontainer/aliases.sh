wireshark-ports() {
    printf "%-65s %s\n" "CONTAINER" "PORT"

    docker ps \
        --filter "name=clab_vsc_ws" \
        --format "{{.Names}}" |
    while read -r container; do
        port=$(docker port "$container" 5800/tcp 2>/dev/null)
        port=${port##*:}
        printf "%-65s %s\n" "$container" "$port"
    done
}