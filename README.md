# Itarazzo Client
The *Itarazzo Client* allows for the container-based execution and integration of workflow tests based on the [Arazzo Specification](https://spec.openapis.org/arazzo/latest.html). 

---

**Note**: This project is developed in my free time alongside family and full-time work. Any feedback or contributions are greatly appreciated as I strive to make this tool as helpful as possible for other developers.

---

## Contents
- [Parameters](#parameters)
- [Docker Configuration](#docker-configuration)
- [Building and Running the Docker Image](#building-and-running-docker-image)
- [Using Docker Compose](#using-docker-compose)
- [Execution Notes](#execution-notes)
- [Security](#security-warning)

---

## Parameters
To configure the workflows, two environment variables need to be specified:

- `ARAZZO_FILE`: Path or URI to the Arazzo specification (e.g., `/itarazzo/specs/pet-store.arazzo.yaml`)
- `ARAZZO_INPUTS_FILE`: Path to a valid JSON file that contains input values for the workflow test (e.g., `/itarazzo/specs/arazzo-inputs.json`)

---

## Docker Configuration
The Itarazzo client runs within a Docker container as a non-root user (`itarazzobot`) in the working directory `/itarazzo`.

---

## Building and Running Docker Image
Use the following commands to build and run the Docker image:

```bash
# Build the Docker image
docker build -t itarazzo-client .

# Run the container
docker run --rm \
    -e ARAZZO_FILE=/itarazzo/specs/pet-store.arazzo.yaml \
    -e ARAZZO_INPUTS_FILE=/itarazzo/specs/arazzo-inputs.json \
    -v /path/to/specsDir:/itarazzo/specs \
    -v /path/to/reportsDir:/itarazzo/target/reports \
    itarazzo-client
```

---

### Explanation of this command:
- Sets the environment variables `ARAZZO_FILE` and `ARAZZO_INPUTS_FILE`.
- Mounts the local directory `path/to/specsDir` to `/itarazzo/specs`, allowing access to specifications in the container.
- Mounts `path/to/reportsDir` to `/itarazzo/target/reports` so that test reports are available on the host machine.

---

## Using docker-compose
There is also a `docker-compose.yaml` which simplifies starting the container:

```yaml
services:
  itarazzo:
    image: leidenheit/itarazzo-client:latest
    environment:
      - ARAZZO_FILE=/itarazzo/specs/pet-store.arazzo.yaml
      - ARAZZO_INPUTS_FILE=/itarazzo/specs/arazzo-inputs.json
    volumes:
      - ./src/test/resources:/itarazzo/specs
      - ./target/reports:/itarazzo/target/reports
    stop_grace_period: 30s
```
### Start the container using docker-compose:
```bash
docker-compose up --build
```
This command builds and starts the container, runs the tests, and exits automatically when done.

---

## Execution Notes
The container will automatically exit after completing the tests.

---

## Security Warning
*Itarazzo Client makes real API requests. Please take care to avoid unintentionally interacting with production systems.*
