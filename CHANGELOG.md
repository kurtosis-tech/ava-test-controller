# TBD
* Bumped Gecko startup timeout from 30s -> 90s

# 0.3.0
* Removed startPortRange and endPortRange CLI args
* Declare timeouts for tests
* After reviewing possibility of centralizing deserialization of JSON RPC responses, determined it's not doable. Removing TODOs related to this.
* Make initializer & controller log levels independently configurable
* Adding test for full connectivity based on Peers API.
* Split `admin` and `health` endpoint types into their own files, for readability
* Provide functionality for tests to add & stop nodes in the network dynamically
* Split Gecko networks into MutableGeckoNetwork and FixedGeckoNetwork
* Fix bug with tests passing when they shouldn't
* Catch RPC-level errors in MakeRPCRequest
* Add all five default stakers to staking network bootstrapping
* Implement test for transferring assets between XChain accounts
* Implement test for transferring assets from XChain to PChain
* Created `GeckoCertProvider` interface that's fed into the `GeckoServiceInitializerCore`, allowing for test writers to customize the certs that the certs get
* Created two implementations of `GeckoCertProvider`:
    * `StaticGeckoCertProvider`, which provides the exact same predefined cert repeatedly
    * `RandomGeckoCertProvider`, which provides generated certs (optionally, the same random-generated cert each time)
* Removed `FixedGeckoNetwork` in favor of `TestGeckoNetwork`, which allows for more control over the testnet that gets created
* Removed the single-node and ten-node Gecko tests; they don't actually test anything useful when compared to the staking network tests
* Expanded RpcWorkflow test to add a staker
* Expanded RpcWorkflow test to add a delegator and transfer funds back to XChain
* Created high level function to both fund and add a staker to default subnet
* Fixed fully connected test and added nonbootstrap node as staker

# 0.2.1
* Fix tee suppressing exit code of the Docker image
* Add parameters to `makeRpcRequest` on Gecko client
* Added a mock JSON RPC requester for testing Gecko client methods
* Add method calls on the Gecko client and tests for the following PChain endpoints:
    * `createBlockhain`
    * `getBlockchainStatus`
    * `createAccount`
    * `importKey`
    * `exportKey`
    * `getAccount`
    * `listAccounts`
    * `createSubnet`
    * `platform.getSubnets`
    * `platform.validatedBy`
    * `platform.validates`
    * `platform.getBlockchains`
    * `platform.exportAVA`
    * `platform.importAVA`
    * `platform.sign`
    * `platform.issueTx`
    * `getPendingValidators`
    * `sampleValidators`
    * `addDefaultSubnetValidator`
    * `addNonDefaultSubnetValidator`
    * `addNonDefaultSubnetDelegator`
* Added tests for the following non-PChain endpoints:
    * `admin.getNodeID`
    * `admin.peers`
    * `health.getLiveness`
* Removed unnecessary docker pull command in ci script.

# 0.2.0
* Updated code to use latest Kurtosis version that stops containers
* Added convenience scripts for rebuilding and running to the `scripts` directory
* Updated CI check & documentation to reflect the use of the convenience scripts
* Switched ServiceAvailabilityCheckerCore to use the `health` API's getLiveness call
* Added `GeckoClient` with some basic endpoint implementations
* Enabled staking
* Added grabbing logs from the controller
