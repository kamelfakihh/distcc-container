# distcc container

A basic distcc daemon setup along with a Devcontainer configuration for building applications on a Raspberry Pi

### Note:

- IP addresses for the distcc server/client are currently hardcoded.
- The Devcontainer uses the LLVM version available in the Debian repositories (in this case LLVM 19). On the server, I am using a custom script to manually build Clang from source. Compiler versions should match between the client and server. I will fix this later.
