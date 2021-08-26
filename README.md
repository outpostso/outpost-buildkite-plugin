# Outpost Deployment Tracker

Track your Buildkite deployments with Outpost

## Example

Add the following to your `pipeline.yml`:

```yml
steps:
  - plugins:
      - outpostso/outpost#v1.1.0:
          token: "1280176a7327d1510cb5..."
```

Example with custom overrides:

```yml
steps:
  - plugins:
      - outpostso/outpost#v1.1.0:
          token: "2280176a7327d1510cb5..."
          name: ["prod-outpost-api"]
          version: "3.2.1"
          user: "Web Team"
```

Example with bundled deployments:

```yml
steps:
  - plugins:
      - outpostso/outpost#v1.1.0:
          token: "2280176a7327d1510cb5..."
          name: ["prod-outpost-api", "prod-outpost-worker", "prod-outpost-mail"]
          version: "3.2.1"
          user: "Web Team"
```

Example with version generate via command:

```yml
steps:
  - plugins:
      - outpostso/outpost#v1.1.0:
          token: "2280176a7327d1510cb5..."
          name: ["prod-outpost-api", "prod-outpost-worker", "prod-outpost-mail"]
          version-cmd: "make version"
          user: "Web Team"
```

## Configuration

### `token` (Required, string)

The API token from your Outpost account.

### `name` (Optional, array)

The name of the services being deployed, defaults to BuildKite slug.

### `version` (Optional, string)

Version number of your service, defaults to 0.0.0-BuildNumber.

### `sha` (Optional, string)

Alternative GIT SHA for this build.

### `user` (Optional, string)

The name of the user to be associated with this deployment, defaults to buildkite user.

## Developing

To run the tests:

```shell
docker-compose run --rm tests
```

## Contributing

1. Fork the repo
2. Make the changes
3. Run the tests
4. Commit and push your changes
5. Send a pull request
