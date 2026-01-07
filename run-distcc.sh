#!/usr/bin/env bash

# docker build . --tag "distcc-daemon"
docker run --privileged --network host -it distcc-daemon /bin/bash -c "distccd --allow 192.168.0.101 --log-stderr --no-detach"
