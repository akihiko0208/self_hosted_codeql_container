#!/bin/bash
IMGNAME=self_hosted_codeql_container
VERSION=0.1

docker build -t ${IMGNAME}:${VERSION} ..
