#!/usr/bin/env bash

set -euo pipefail

echo "--- :google_cloud: Verifying GOOGLE_SECRET_VALUE is set"

if [ -z "${GOOGLE_SECRET_VALUE:-}" ]; then
  echo "^^^ +++"
  echo "Error: GOOGLE_SECRET_VALUE is not set. The plugin did not export the secret."
  echo "If you are running this locally, make sure the plugin is configured correctly before running the tests."
  exit 1
fi

echo "GOOGLE_SECRET_VALUE is set"

echo ""
echo "E2E test passed! The Google secret was successfully retrieved and exported."
