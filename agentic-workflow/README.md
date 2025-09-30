Here is the revised **"Running Dependent Services"** section for your README.

This version is updated to reflect the most efficient setup: **Stdio Docker (on-demand)** for both **Terraform** and **GitHub**, requiring **no manual Docker daemon commands** for those services. The `gcloud` server is kept as an external, persistent service, as configured in your `settings.json`.

-----

## Running Dependent Services

Certain agents, like `gcp_scout`, `terraform_updater`, or a potential `github_auditor`, require external Model Context Protocol (MCP) servers to be running to function correctly.

### Prerequisites for Local Docker Stdio Servers 🐳

1.  **Docker Daemon:** Ensure **Docker Desktop is installed and running** on your local machine before starting the Gemini CLI.
2.  **GitHub PAT:** Ensure your GitHub Personal Access Token is set as the environment variable `$GITHUB_PAT` in your `~/.gemini/.env` file for the GitHub server to authenticate.

-----

### (GOOGLER INTERNAL) gcloud MCP Server (Streamable-HTTP)

The `gcloud` MCP server is configured to run as a persistent Streamable-HTTP service at `127.0.0.1:8080/sse`. It must be started manually.

1.  **Create and enter a new CitC client** (or use `g4d <client_name>` for an existing one):

    ```bash
    g4d -f gcloud_mcp_client
    ```

2.  **Navigate to the gcloud MCP server directory**:

    ```bash
    cd cloud/developer_experience/gcloud/mcp
    ```

3.  **Run the blaze command** to start the persistent HTTP server:

    ```bash
    blaze run :mcp -- --http 127.0.0.1:8080
    ```

-----

### Terraform MCP Server (Local Docker / Stdio)

This server is launched **automatically on demand** by the Gemini CLI. It uses **Stdio transport** to communicate with the container, ensuring it only runs when a Terraform tool is called.


-----

### GitHub MCP Server (Local Docker / Stdio)

This server is also launched **automatically on demand** by the Gemini CLI. It communicates via **Stdio transport**, securely pulling the necessary PAT from the environment variable you set in `~/.gemini/.env`.