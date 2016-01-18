#!/bin/sh
. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

_createSimpleGoMain()
{
  cat > ${BUILD_DIR}/main.go <<EOF
package main

func main() {
	println("ok")
}
EOF
}

_createVendoredProject()
{
_createSimpleGoMain

  mkdir -p ${BUILD_DIR}/vendor
  cat > ${BUILD_DIR}/production_build_go.json <<EOF
{ "GoVersion": "1.5.3, "Build": "default", "Name": "mytest" }
EOF
}

testCompileVendoredApp() {
  _createVendoredProject

  compile

  assertCapturedSuccess

  assertCaptured "should install GoVersion from production_build_go.json" "-----> Installing go1.5.3... done"
  assertCaptured "should run go install" "-----> Running: go install -v -tags heroku ./..."

  assertTrue "mytest exists" "[ -f ${BUILD_DIR}/bin/mytest ]"
  assertTrue "mytest is executable" "[ -x ${BUILD_DIR}/bin/mytest ]"

  assertEquals "running mytest should print 'ok'" "ok" "$(${BUILD_DIR}/bin/mytest 2>&1)"
}
