<p align="center">
  <img src="icon.png" alt="Xerberus Logo" width="21%">
</p>

# Xerberus Testnet Node for StartOS

Welcome to the Xerberus Testnet Node project, designed to run on StartOS. This repository provides the `s9pk` package necessary to deploy and operate the `xerberus-node` on [StartOS](https://github.com/Start9Labs/start-os/). For detailed insights into service packaging, refer to the [Developer Docs](https://docs.start9.com/latest/developer-docs/packaging).

## Dependencies

To build this project, you'll need to install the following system dependencies. Follow the provided links for installation instructions:

- [Docker](https://docs.docker.com/get-docker)
- [Docker Buildx](https://docs.docker.com/buildx/working-with-buildx/)
- [yq](https://mikefarah.gitbook.io/yq)
- [Deno](https://deno.land/)
- [Make](https://www.gnu.org/software/make/)
- [Start SDK](https://github.com/Start9Labs/start-os/tree/sdk/)

## Build Environment

Set up your StartOS build environment. Here's an example for Ubuntu 20.04:

1. **Install Docker**
   ```bash
   curl -fsSL https://get.docker.com | bash
   sudo usermod -aG docker "$USER"
   exec sudo su -l $USER
   ```

2. **Set Buildx as Default Builder**
   ```bash
   docker buildx install
   docker buildx create --use
   ```

3. **Enable Cross-Architecture Emulated Builds**
   ```bash
   docker run --privileged --rm linuxkit/binfmt:v0.8
   ```

4. **Install yq**
   ```bash
   sudo snap install yq
   ```

5. **Install Deno**
   ```bash
   sudo snap install deno
   ```

6. **Install Build Essentials**
   ```bash
   sudo apt-get install -y build-essential openssl libssl-dev libc6-dev clang libclang-dev ca-certificates
   ```

7. **Install Rust**
   ```bash
   curl https://sh.rustup.rs -sSf | sh
   # Choose option 1 for default install
   source $HOME/.cargo/env
   ```

8. **Build and Install Start SDK**
   ```bash
   git clone https://github.com/Start9Labs/start-os.git && cd start-os && git submodule update --init --recursive
   ```

   Before running `make sdk`, update the `time` package:
   ```bash
   cargo update -p time --manifest-path=core/Cargo.toml
   ```

   Now, build the SDK:
   ```bash
   make sdk
   ```

   Initialize and verify the SDK installation:
   ```bash
   start-sdk init
   start-sdk --version
   ```

Now, you're ready to build the `xerberus-node` package!

## Cloning

Clone the project repository:

```
git clone https://github.com/your-username/xerberus-node-startos.git
cd xerberus-node-startos
git submodule update --init --recursive
```

## Building

To build the `xerberus-node` package for all supported platforms:

```
make
```

For a single platform:

- For **amd64**:
  ```
  make x86
  ```

- For **arm64**:
  ```
  make arm
  ```

## Installing (on StartOS)

To install the package on your StartOS instance:

> :information_source: Replace `server-name.local` with your Start9 server's address.

```
start-cli auth login
# Enter your StartOS password
start-cli --host https://server-name.local package install xerberus-node.s9pk
```

If your `start-cli` configuration file has a default host set, you can simplify the installation to:

```
make install
```

**Tip:** Alternatively, you can install the `xerberus-node.s9pk` using the **Sideload Service** feature under **System > Manage**.

### Verify Installation

After installation, navigate to the StartOS Services page, select **Xerberus Testnet Node**, configure, and start the service. Ensure that all interfaces are accessible as per the service's documentation.

**Congratulations!** You've successfully installed the Xerberus Testnet Node on StartOS. 
