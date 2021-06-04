#!/bin/bash
IMGNAME=self_hosted_codeql_container
VERSION=0.3

docker build -t ${IMGNAME}:${VERSION} ..
