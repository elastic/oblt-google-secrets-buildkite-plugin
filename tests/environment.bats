#!/usr/bin/env bats

load "${BATS_PLUGIN_PATH}/load.bash"

# Uncomment to enable stub debugging
# export GCLOUD_STUB_DEBUG=/dev/tty
# export BUILDKITE_AGENT_STUB_DEBUG=/dev/tty

setup() {
  # you can set variables common to all tests here
  export BUILDKITE_PLUGIN_OBLT_GOOGLE_SECRETS_SECRET='my-secret'
  export BUILDKITE_PLUGIN_OBLT_GOOGLE_SECRETS_ENV_VAR='MY_VAR'

  stub buildkite-agent \
    "redactor add : exit 0"
}

@test "Missing mandatory secret input fails" {
  unset BUILDKITE_PLUGIN_OBLT_GOOGLE_SECRETS_SECRET

  run "$PWD"/hooks/environment

  assert_failure
  assert_output --partial "Parameter 'secret:' is required."
  refute_output --partial 'Accessing Google secret'
}

@test "Missing mandatory env-var input fails" {
  unset BUILDKITE_PLUGIN_OBLT_GOOGLE_SECRETS_ENV_VAR

  run "$PWD"/hooks/environment

  assert_failure
  assert_output --partial "Parameter 'env-var:' is required."
  refute_output --partial 'Accessing Google secret'
}

@test "Normal basic operations" {
  stub gcloud \
    "secrets versions access latest --secret=\"my-secret\" --project=\"elastic-observability\" : echo myvalue"

  run "$PWD"/hooks/environment

  assert_success
  assert_output --partial "Accessing Google secret"

  unstub gcloud
}


@test "Override project" {
  export BUILDKITE_PLUGIN_OBLT_GOOGLE_SECRETS_PROJECT_ID='my-project'

  stub gcloud \
    "secrets versions access latest --secret=\"my-secret\" --project=\"my-project\" : echo myvalue"

  run "$PWD"/hooks/environment

  assert_success
  assert_output --partial "Accessing Google secret"

  unstub gcloud
}
