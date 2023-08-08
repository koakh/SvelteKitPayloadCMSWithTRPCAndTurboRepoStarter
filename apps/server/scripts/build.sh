#!/bin/bash

# note#1: required bash to use sed files on `apps/server/scripts/build.sh`
# note#2: test with `cd apps/server && pnpm build && cd ../.. && pnpm start:server`

# prepare for build:
# clean dist
# replace access"; with access.cjs"; in all files in the src directory
# replace s"; with s.cjs"; in payload.config.ts
# replace handler.mjs with handler.js in server.mts
# replace "type": with "#type": in package.json
# replace: payload.config.cjs "./collections/(.*)" with "./collections/(.*).cjs"

rm -rf dist

# search ./src/server.mts and replace 'handler.mjs' with 'handler.js'
FILE='./src/server.mts'
SEARCH='handler.mjs'
REPLACE='handler.js'
sed -i -- "s/${SEARCH}/${REPLACE}/g" ${FILE}

# mod-off
# search ./dist/payload.config.cjs and replace all "./collections/(.*)" with "./collections/(.*).cjs"
# ex "./collections/Categories" with "./collections/Categories.cjs"
FILE='./package.json'
SEARCH='\"type\":'
REPLACE='"#type":'
sed -i -- "s/${SEARCH}/${REPLACE}/g" ${FILE}

# build
node esbuild.build.mjs

# search and Replace all files Recursively, replacing `.mts` with `.mjs`
grep -rli '.mts' ./dist/* | xargs -i@ sed -i 's/\.mts/\.mjs/g' @

# search ./dist/payload.config.cjs and replace all "./collections/(.*)" with "./collections/(.*).cjs"
# ex "./collections/Categories" with "./collections/Categories.cjs"
FILE='./dist/payload.config.cjs'
SEARCH='var import_(.*) = __toESM\(require\(\".\/collections\/(.*)\"\)\);'
REPLACE='var import_\1 = __toESM\(require\(\".\/collections\/\1.cjs\"\)\);'
sed -E -i -- "s/${SEARCH}/${REPLACE}/g" <<< 'var import_Categories = __toESM(require("./collections/Categories"));' ${FILE}
