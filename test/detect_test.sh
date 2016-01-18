#!/bin/sh
. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

testDetect_NotFound()
{
  detect

  assertNoAppDetected
}

testDetect_NotFound_NoVendorFolder()
{
  touch ${BUILD_DIR}/main.go

  detect

  assertNoAppDetected
}

testDetect_VendoredGo()
{
  touch ${BUILD_DIR}/main.go
  touch ${BUILD_DIR}/production_build_go

  detect

  assertAppDetected "Vendored Go"
}
