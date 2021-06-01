#!/bin/bash
cd actions-runner
./config.sh --url ${URL} --token ${TOKEN}
./run.sh
