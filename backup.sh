#!/bin/bash

DT=$(date +%Y-%m-%d-%H-%M)
DIR=.bak
FILE="${DIR}/${DT}.tgz"
FILE_EXCLUDE=exclude.tag
mkdir ${DIR} -p
touch .bak/${FILE_EXCLUDE}
touch .dbbak/${FILE_EXCLUDE}
touch ./node_modules/${FILE_EXCLUDE}
touch ./out/${FILE_EXCLUDE}
touch ./apps/server/build/${FILE_EXCLUDE}
touch ./apps/web/build/${FILE_EXCLUDE}
touch ./apps/server/node_modules/${FILE_EXCLUDE}

tar -zcvf ${FILE} \
	--exclude=volumes \
	--exclude-tag-all=${FILE_EXCLUDE} \
	.