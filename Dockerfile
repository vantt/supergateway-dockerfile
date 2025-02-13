# This Dockerfile sets up a containerized environment with both Python and Node.js installed.
# It includes the following tools:
# - Python (via the official Python 3.11 slim image)
# - Node.js (LTS version installed via NodeSource repository)
# - npm and npx (bundled with Node.js)
# - uv (Rust-based Python package manager)
#
# The container is designed to support development workflows that require both Python and Node.js,
# such as full-stack applications, data science projects, or web development with frontend/backend components.
#
# To build this Dockerfile, run: docker build -t supergateway .
# To run the container, use: 
# 
#   docker run -i --rm -p 8000:8000 supergateway --stdio "npx -y @modelcontextprotocol/server-everything"
#   docker run -i --rm -p 8000:8000 supergateway --stdio "npx -y @modelcontextprotocol/server-filesystem folder/path1 folder/paht2"
#   docker run -i --rm -p 8000:8000 supergateway --stdio "uvx run mcp-server-fetch"



# Use the official Python image as the base image
FROM python:3.11-slim

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (LTS version)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest

# Install Rust (required for uv/uvx)
ENV PATH="/root/.cargo/bin:${PATH}"
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && rustup update

# Install uv/uvx
RUN pip install uvx

# Verify installations
RUN python --version && \
    node --version && \
    npm --version && \
    uv --version

# Install Supergateway
RUN npm install -g supergateway

# RUN npm install -g @smithery/cli@latest

# Set the working directory inside the container
WORKDIR /app

# Set the entrypoint to run Supergateway
ENTRYPOINT ["supergateway"]

# Set default command arguments
CMD ["--stdio", "uvx mcp-server-git"]