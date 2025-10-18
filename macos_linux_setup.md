# Turbo Flow Quick Setup for MacOS & Linux

This guide provides one-line install commands for the `turbo-flow-claude` environment.

Pasting the correct command for your operating system into your terminal will download and run an installer script that automatically:

1.  Installs all required system dependencies (Node.js, Python, Tmux, etc.).
2.  Copies the `devpods` configuration to your local machine.
3.  Patches the scripts for compatibility.
4.  Runs the `setup.sh`, `post-setup.sh`, and `tmux-workspace.sh` scripts in order to complete the installation.

-----

##  macOS Setup

Open your terminal and paste the following command:

```bash
curl -sL https://raw.githubusercontent.com/marcuspat/turbo-flow-claude/main/devpods/install_macos.sh | bash
```

-----

## 🐧 Linux Setup (Debian/Ubuntu/Fedora/RHEL)

Open your terminal and paste the following command:

```bash
curl -sL https://raw.githubusercontent.com/marcuspat/turbo-flow-claude/main/devpods/install_linux.sh | bash
```

-----

## After the Script Runs

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
