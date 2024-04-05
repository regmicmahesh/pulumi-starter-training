# Pulumi Starter Code

This repository contains a pulumi codebase that we may use to experiment.

## Prerequisites

1. GNU Make
2. Docker

## Setting up

1. Clone the repository.

2. Adjust the values accordingly in `env/override.mk` using `env/override.example.mk`.

```bash
cp env/override.example.mk env/override.mk
```

3. Run the server using `make pulumi-init`. Ensure docker engine is 
running before running this command.

```bash
make pulumi-init
```

4. Run `make help` to see all the available commands.

```bash
make help
```

## Configuration

Check the `docker/docker-compose.yaml` and `Makefile` to see all the
available configurations you can change.

