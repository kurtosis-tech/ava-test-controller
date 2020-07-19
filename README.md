Ava End-to-End Tests
====================
This repo contains end-to-end tests for the Ava network and Gecko client using [the Kurtosis testing framework](https://github.com/kurtosis-tech/kurtosis)

Requirements
------------
* Golang version 1.13x.x
* [A Docker engine running in your environment](https://docs.docker.com/engine/install/)

Running Locally
---------------
1. Clone this repository
1. Run `scripts/full_rebuild_and_run.sh`

In your Docker engine you'll now see:
* A set of running Docker containers representing the nodes of the test networks
* A set of stopped Docker containers for the test controllers, one for each test

You can now run `scripts/run.sh` to re-run the testing suite, using whatever arguments you like. To see the full list of supported arguments, pass in the `--help` flag to the `run.sh` script.

Developing Locally
------------------
### Architecture
This repo uses the [Kurtosis architecture](https://github.com/kurtosis-tech/kurtosis), so you should first go through the tutorial there to familiarize yourself with the core Kurtosis concepts.

In this implementation of Kurtosis, we have:
* `AvaService` and `GeckoService` as our service interfaces
* `GeckoServiceInitializerCore` and `GeckoServiceAvailabilityChecker` for including Gecko services in test networks
    * `GeckoCertProvider` to allow controlling the cert that a Gecko service starts with, to allow for writing duplicate-node-ID tests
* `TestGeckoNetwork` to encapsulate a Gecko test network of arbitrary size
* Several tests
* `AvaTestSuite` to contain all the tests Kurtosis can run
* A `main.go` for running a controller Docker image under the `controller` package
* A `main.go` for running the Kurtosis initializer under the `initializer` package

Additionally, this repo also contains a Gecko client (which should probably be moved to the Gecko repo).

### Adding A Test
1. Create a new file in `commons/ava_testsuite` for your test
1. Create a struct that implements the `testsuite.Test` interface from Kurtosis
1. Fill in the interface's functions
1. Register the test in `AvaTestSuite`'s `GetTests` method

### Running Locally As A Developer
The `scripts/full_rebuild_and_run.sh` will rebuild and rerun both the initializer and controller Docker image; rerun this every time that you make a change. Arguments passed to this script will get passed to the initializer binary CLI as-is.

### Keeping Your Dev Environment Clean
Kurtosis intentionally doesn't delete containers and volumes, which means your local Docker environment will accumulate images, containers, and volumes. Make sure to read [the Notes section of the Kurtosis README](https://github.com/kurtosis-tech/kurtosis/tree/develop#notes) for information on how to keep your local environment clean while you develop.
