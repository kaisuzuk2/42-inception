DOMAINNAME='aaa'
WP_TITLE='bbb'

for var in DOMAINNAME WP_TITLE; do
    if [ -z "${var}" ]; then
        echo 'error'
        exit 1
    fi
    echo ${!var}
done