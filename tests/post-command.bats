#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

# Uncomment the following line to debug stub failures
# export BUILDKITE_AGENT_STUB_DEBUG=/dev/tty

@test "Register deployment with custom values" {
  export BUILDKITE_BRANCH="main"
  export BUILDKITE_BUILD_NUMBER=1
  export BUILDKITE_PIPELINE_SLUG="outpost-plugin-test"
  export BUILDKITE_COMMIT="97ea24288f50f920462bd4d586589445c335ff58"
  export BUILDKITE_BUILD_CREATOR="HelloAllan"
  export BUILDKITE_BUILD_URL="https://buildkite.com/outpost"

  export BUILDKITE_PLUGIN_OUTPOST_TOKEN="foobar"
  export BUILDKITE_PLUGIN_OUTPOST_VERSION="3.2.1"
  export BUILDKITE_PLUGIN_OUTPOST_NAME_0="prod-api-worker"
  export BUILDKITE_PLUGIN_OUTPOST_SHA="97ea2428"
  export BUILDKITE_PLUGIN_OUTPOST_USER="Allan"

  stub curl \
   '--silent --request POST --url https://deploy.outpost.so/v1/track --header "Authorization: Bearer foobar" --header "Content-Type: application/json" --data '"'"'{"name": ["prod-api-worker"], "version": "3.2.1", "sha": "97ea2428", "user": "Allan", "url": "https://buildkite.com/outpost", "branch": "main"}'"'"' : echo "Outpost Override"'

  run "$PWD/hooks/post-command"

  assert_success
  assert_output --partial "Outpost Override"

  unstub curl
}

@test "Register deployment with build defaults" {
  export BUILDKITE_BRANCH="main"
  export BUILDKITE_BUILD_NUMBER=1
  export BUILDKITE_PIPELINE_SLUG="outpost-plugin-test"
  export BUILDKITE_COMMIT="97ea24288f50f920462bd4d586589445c335ff58"
  export BUILDKITE_BUILD_CREATOR="HelloAllan"
  export BUILDKITE_BUILD_URL="https://buildkite.com/outpost"

  export BUILDKITE_PLUGIN_OUTPOST_TOKEN="foobar"

  stub curl \
   '--silent --request POST --url https://deploy.outpost.so/v1/track --header "Authorization: Bearer foobar" --header "Content-Type: application/json" --data '"'"'{"name": ["outpost-plugin-test"], "version": "0.0.0-1", "sha": "97ea24288f50f920462bd4d586589445c335ff58", "user": "HelloAllan", "url": "https://buildkite.com/outpost", "branch": "main"}'"'"' : echo "Outpost Default"'

  run "$PWD/hooks/post-command"

  assert_success
  assert_output --partial "Outpost Default"

  unstub curl
}

@test "Register multiple deployments with names array" {
  export BUILDKITE_BRANCH="main"
  export BUILDKITE_BUILD_NUMBER=1
  export BUILDKITE_PIPELINE_SLUG="outpost-plugin-test"
  export BUILDKITE_COMMIT="97ea24288f50f920462bd4d586589445c335ff58"
  export BUILDKITE_BUILD_CREATOR="HelloAllan"
  export BUILDKITE_BUILD_URL="https://buildkite.com/outpost"

  export BUILDKITE_PLUGIN_OUTPOST_TOKEN="foobar"
  export BUILDKITE_PLUGIN_OUTPOST_NAME_0="prod-outpost-api"
  export BUILDKITE_PLUGIN_OUTPOST_NAME_1="prod-outpost-worker"
  export BUILDKITE_PLUGIN_OUTPOST_NAME_2="prod-outpost-mail"

  stub curl \
   '--silent --request POST --url https://deploy.outpost.so/v1/track --header "Authorization: Bearer foobar" --header "Content-Type: application/json" --data '"'"'{"name": ["prod-outpost-api","prod-outpost-worker","prod-outpost-mail"], "version": "0.0.0-1", "sha": "97ea24288f50f920462bd4d586589445c335ff58", "user": "HelloAllan", "url": "https://buildkite.com/outpost", "branch": "main"}'"'"' : echo "Outpost Name Array"'

  run "$PWD/hooks/post-command"

  assert_success
  assert_output --partial "Outpost Name Array"

  unstub curl
}

@test "Register deployment with version command" {
  export BUILDKITE_BRANCH="main"
  export BUILDKITE_BUILD_NUMBER=1
  export BUILDKITE_PIPELINE_SLUG="outpost-plugin-test"
  export BUILDKITE_COMMIT="97ea24288f50f920462bd4d586589445c335ff58"
  export BUILDKITE_BUILD_CREATOR="HelloAllan"
  export BUILDKITE_BUILD_URL="https://buildkite.com/outpost"

  export BUILDKITE_PLUGIN_OUTPOST_TOKEN="foobar"
  export BUILDKITE_PLUGIN_OUTPOST_VERSION_CMD="echo abc123"

  stub curl \
   '--silent --request POST --url https://deploy.outpost.so/v1/track --header "Authorization: Bearer foobar" --header "Content-Type: application/json" --data '"'"'{"name": ["outpost-plugin-test"], "version": "abc123", "sha": "97ea24288f50f920462bd4d586589445c335ff58", "user": "HelloAllan", "url": "https://buildkite.com/outpost", "branch": "main"}'"'"' : echo "Outpost Default"'

  run "$PWD/hooks/post-command"

  assert_success
  assert_output --partial "Outpost Default"

  unstub curl
}

@test "Register deployment with version command overiding version" {
  export BUILDKITE_BRANCH="main"
  export BUILDKITE_BUILD_NUMBER=1
  export BUILDKITE_PIPELINE_SLUG="outpost-plugin-test"
  export BUILDKITE_COMMIT="97ea24288f50f920462bd4d586589445c335ff58"
  export BUILDKITE_BUILD_CREATOR="HelloAllan"
  export BUILDKITE_BUILD_URL="https://buildkite.com/outpost"

  export BUILDKITE_PLUGIN_OUTPOST_TOKEN="foobar"
  export BUILDKITE_PLUGIN_OUTPOST_VERSION="3.2.1"
  export BUILDKITE_PLUGIN_OUTPOST_VERSION_CMD="echo abc123"

  stub curl \
   '--silent --request POST --url https://deploy.outpost.so/v1/track --header "Authorization: Bearer foobar" --header "Content-Type: application/json" --data '"'"'{"name": ["outpost-plugin-test"], "version": "abc123", "sha": "97ea24288f50f920462bd4d586589445c335ff58", "user": "HelloAllan", "url": "https://buildkite.com/outpost", "branch": "main"}'"'"' : echo "Outpost Default"'

  run "$PWD/hooks/post-command"

  assert_success
  assert_output --partial "Outpost Default"

  unstub curl
}
