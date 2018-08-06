if [ "$EUID" -gt "500" ]; then
pathmunge /usr/local/sbin:/sbin:/usr/sbin
fi
