# Turbo Flow Quick Setup

This guide explains how to run the installer scripts for the `turbo-flow-claude` environment.

These scripts will automatically:

1.  Install all required system dependencies (Node.js, Python, Tmux, etc.).
2.  Copy the `devpods` configuration to your local machine.
3.  Patch the scripts for compatibility.
4.  Run the `setup.sh`, `post-setup.sh`, and `tmux-workspace.sh` scripts in order to complete the installation.

-----

## ⚙️ Installation

### 1\. Clone the Repository

First, clone the repository to your local machine:

```bash
git clone https://github.com/marcuspat/turbo-flow-claude.git
```

### 2\. Run the Installer

1.  Navigate into the `devpods` directory:

    ```bash
    cd turbo-flow-claude/devpods
    ```

2.  Make the boot scripts executable (you only need to do this once):

    ```bash
    chmod +x boot_macosx.sh boot_linux.sh
    ```

3.  Run the correct script for your operating system:

    **On  macOS:**

    ```bash
    ./boot_macosx.sh
    ```

    **On 🐧 Linux:**

    ```bash
    ./boot_linux.sh
    ```

-----

## ✅ After the Script Runs

The installer script finishes by launching you directly into a **TMux session** named `workspace`. Tmux is a terminal multiplexer that allows you to run and manage multiple terminal windows within a single session.

Your `tmux` session is pre-configured with the following windows:

  * **Window 0: `Claude-1`** (Main work window)
  * **Window 1: `Claude-2`** (A second work window)
  * **Window 2: `Claude-Monitor`** (Runs `claude-monitor`)
  * **Window 3: `htop`** (System monitor)

### Basic Tmux Commands

  * **Switch Windows:** Press **`Ctrl+b`**, release, then press the window number (e.g., `0`, `1`, `2`).
  * **Next Window:** Press **`Ctrl+b`**, release, then press `n` (for next).
  * **Detach (Leave Session Running):** Press **`Ctrl+b`**, release, then press `d` (for detach).
  * **Re-attach:** From your normal terminal, type `tmux a -t workspace` to get back into your session.

All your new aliases (like `dsp`, `cf-swarm`, `cfs`, etc.) are now active and ready to use *inside* this `tmux` session.
