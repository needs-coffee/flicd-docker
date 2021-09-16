#!/bin/sh
/bin/netstat -an | grep LISTEN | grep -c ${FLIC_PORT}