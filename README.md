# Google Secrets Buildkite plugins

Expose secrets to your build steps. Secrets are stored in Google Secret Manager.

## Properties

| Name             | Description                                              | Required | Default                 |
|---------------|-------------------------------------------------------------|----------|-------------------------|
| `secret`      | The secret to access.                                       | `true`   | ``                      |
| `env-var`     | Make the fetched secret available as environment variables. | `true`   | ``                      |
| `project-id`  | The GCP project id.                                         | `true`   | `elastic-observability` |

## Usage

```yml
steps:
  - command: |
      echo "$EC_API_KEY"
    plugins:
      - elastic/oblt-google-secrets#v0.1.0:
          secret: "elastic-cloud-observability-team-qa-api-key"
          env-var: "EC_API_KEY"
          # project-id: "elastic-observability"
```
