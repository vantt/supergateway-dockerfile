# supergateway-dockerfile

Dockerfile for https://github.com/supercorp-ai/supergateway

## Building the Docker Image

To build the Docker image, navigate to the `supergateway-dockerfile` directory and run the following command:

```bash
docker build -t supergateway .
```

This command builds an image named `supergateway` using the `Dockerfile` in the current directory.

## Running the Docker Container

Once the image is built, you can run a container using the following command:

```bash
docker run -i --rm -p 8000:8000 supergateway [OPTIONS]
```

Replace `[OPTIONS]` with the desired command-line arguments for `supergateway`. Here are some examples:

*   Run with `@modelcontextprotocol/server-everything`:

    ```bash
    docker run -i --rm -p 8000:8000 supergateway --stdio "npx -y @modelcontextprotocol/server-everything"
    ```

*   Run with `@modelcontextprotocol/fetch`:

    ```bash
    docker run -i --rm -p 8000:8000 supergateway --stdio "uvx run mcp-server-fetch"
    ```


*   Run with `@modelcontextprotocol/server-filesystem` and specified folders:

    ```bash
    docker run -i --rm -p 8000:8000 supergateway --stdio "npx -y @modelcontextprotocol/server-filesystem folder/path1 folder/path2"
    ```

*   Run with `uvx mcp-server-git`:

    ```bash
    docker run -i --rm -p 8000:8000 supergateway --stdio "uvx mcp-server-git"
    ```

## Understanding ENTRYPOINT and CMD

The `Dockerfile` uses both `ENTRYPOINT` and `CMD` instructions to define how the container executes the `supergateway` application.

*   **ENTRYPOINT**: Specifies the executable that will be run when the container starts. In this case, the `ENTRYPOINT` is set to `supergateway`. This means that the `supergateway` command will always be executed when the container runs.

    ```dockerfile
    ENTRYPOINT ["supergateway"]
    ```

*   **CMD**: Provides default arguments to the `ENTRYPOINT` command. If the user doesn't provide any arguments when running the container, the arguments specified in the `CMD` instruction will be used. In this case, the default command is `--stdio "uvx mcp-server-git"`.

    ```dockerfile
    CMD ["--stdio", "uvx mcp-server-git"]
    ```

    This means that, by default, the container will run `supergateway --stdio "uvx mcp-server-git"`.

## How to Use It

The `ENTRYPOINT` and `CMD` instructions work together to provide flexibility in how the `supergateway` application is run.

*   If you want to run `supergateway` with the default arguments, simply run the container without any arguments:

    ```bash
    docker run -i --rm -p 8000:8000 supergateway
    ```

*   If you want to run `supergateway` with different arguments, you can specify them when running the container. These arguments will override the default arguments specified in the `CMD` instruction:

    ```bash
    docker run -i --rm -p 8000:8000 supergateway --stdio "npx -y @modelcontextprotocol/server-everything"
    ```

In this example, the `--stdio "npx -y @modelcontextprotocol/server-everything"` arguments override the default `--stdio "uvx mcp-server-git"` arguments.

## Todo

Currently not run with  **@smithery-ai**, need to pre-install package, not dynamic installation.
