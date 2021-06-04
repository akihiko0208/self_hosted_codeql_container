#!/bin/bash
IMGNAME=self_hosted_container
VERSION=0.4

docker build -t ${IMGNAME}:${VERSION} ..
