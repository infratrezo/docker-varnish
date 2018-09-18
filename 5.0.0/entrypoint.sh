#!/bin/bash
HTTP_PORT=${HTTP_PORT:-6081}
ADMIN_PORT=${ADMIN_PORT:-6082}

if ! set | grep BACKEND ; then
    echo '$BACKEND variable is undefined. Please tell me the hostname/ip of the varnish backend'
    exit 1
fi

sed -i "s/^\(\s\|\t\)*\.host.*/    .host = \"$BACKEND\";/g" /etc/varnish/default.vcl

if varnishd -Cf /etc/varnish/default.vcl ; then
    exec /usr/sbin/varnishd -j unix,user=vcache -F -a :${HTTP_PORT} -T localhost:${ADMIN_PORT} -f /etc/varnish/default.vcl -S /etc/varnish/secret -s malloc,256m
else
    echo "VCL check failed - what did you do wrong?"
    exit 1
fi
