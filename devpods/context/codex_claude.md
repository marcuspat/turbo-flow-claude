# Codex Setup Instructions for Claude Code

**Purpose:** User gives this document to Claude Code with the instruction "Please set up Codex on my system" and Claude executes all steps automatically.

**Prerequisites:**
- Node.js and npm installed
- Basic development environment
- Git installed (for project version control)

---

## ⚡ Claude Execution Flowchart (READ THIS FIRST)

**Claude, follow this exact flowchart to execute the setup correctly:**

### Step 1: Detect the Operating System (DO THIS FIRST)

Execute this command to detect the OS:

```bash
uname -s
```

**Based on the output, remember the OS:**
- If output is `Darwin` → You are on **macOS** (use Part 1c, 5c, 6c)
- If output is `Linux` → You are on **Linux** (use Part 1b, 5b, 6b)
- If output is not recognized, try this Windows command:

```powershell
$PSVersionTable.Platform
```

- If output is `Win32NT` → You are on **Windows** (use Part 1a, 5a, 6a)

**Write down your OS now, you'll need it for the remaining steps.**

### Step 2: Execute the Setup in Order

For each part below, **execute ONLY the section labeled with your detected OS**. Skip all other OS sections.

**Part 0a:** Prerequisites Check (all OS sections - execute your OS only)
↓
**Part 1:** Installation (execute 1a, 1b, or 1c based on your OS)
↓
**Part 2:** Create Configuration Directory (all OS sections - execute your OS only)
↓
**Part 3:** Set Up Configuration File (all OS sections - execute your OS only)
↓
**Part 4:** Initialize Git Repository (all OS sections - same for all)
↓
**Part 5:** Handle PATH Issues (execute 5a, 5b, or 5c based on your OS - ONLY if Codex not found)
↓
**Part 0a:** Authenticate with Codex (all OS - same commands for all)
↓
**Part 6:** Verify Setup (execute 6a, 6b, or 6c based on your OS)
↓
**Part 7:** Test Two-Way Communication (all OS - same for all)

### Step 3: How to Skip Sections

- **If a requirement check passes** (e.g., `which codex` finds Codex) → Skip that section
- **If a directory already exists** → Skip creation and proceed to next step
- **If Codex is in PATH** → Skip Part 5 entirely
- **If git is already initialized** → Skip to git config

### Step 4: Important Rules

✅ **Always execute Part 0 first** (OS Detection) - this determines everything else
✅ **Execute your OS-specific sections only** - ignore sections labeled for other OSes
✅ **Read expected outputs** - they tell you if a step succeeded
✅ **If a command fails** → Stop and check the Troubleshooting section for your OS
✅ **If a step is already done** → Skip it and move to the next step

### Step 5: Example Execution (for clarity)

**If user is on Linux:**
1. Run OS detection → Output is "Linux"
2. Execute Part 0 (Linux checks only)
3. Execute Part 1b (Linux installation only) - skip 1a and 1c
4. Execute Part 2 (Linux directory creation only) - skip Windows section
5. Execute Part 3 (Linux config creation only)
6. Execute Part 4 (git init - same for all OS)
7. Execute Part 5b (Linux PATH) - only if `which codex` failed
8. Execute Part 0a (authentication - same for all)
9. Execute Part 6b (Linux verification only) - skip 6a and 6c
10. Execute Part 7 (two-way communication testing - same for all)

---

## Prerequisites: Codex Subscription Required

**⚠️ IMPORTANT:** Before setting up Codex, you must have:

1. **Active Codex Subscription**
   - A valid Codex subscription account
   - Currently authenticated to your Codex account
   - Access to use Codex CLI

2. **Codex Account Login Credentials**
   - Your Codex account email
   - Associated authentication method (Google OAuth, etc.)
   - Active subscription with valid billing

**If you don't have a Codex subscription yet:**
- Visit the Codex website and create an account
- Activate a subscription plan
- Verify your subscription is active before proceeding with setup

**Codex will ask you to authenticate using device-based OAuth during setup - you'll be guided through this process.**

---

## Part 0: OS Detection & Requirements Check

Claude, before starting any installation, please:

1. **Detect the operating system:**

   **For Windows (PowerShell):**
   ```powershell
   $PSVersionTable.Platform
   # Should output: Win32NT
   ```

   **For Linux:**
   ```bash
   uname -s
   # Should output: Linux
   ```

   **For macOS:**
   ```bash
   uname -s
   # Should output: Darwin
   ```

2. **Check if Node.js and npm are installed and compatible:**

   **All OS (same command):**
   ```bash
   node --version && npm --version
   ```

   Expected output: Should show v18+ for Node.js and v8+ for npm
   - If not found: STOP and install Node.js from https://nodejs.org/
   - If version is too old: Update Node.js

3. **Check if Git is installed:**

   **Windows (PowerShell):**
   ```powershell
   git --version
   ```

   **Linux & macOS (bash/zsh):**
   ```bash
   git --version
   ```

   Expected: Should show "git version X.X.X"
   - If not found: Install Git before proceeding

4. **Check npm global directory location (varies by OS):**

   **All OS:**
   ```bash
   npm config get prefix
   ```

   Expected output by OS:
   - **Windows**: Usually `C:\Users\USERNAME\AppData\Roaming\npm`
   - **Linux**: Usually `/home/username/.npm-global` or `/usr/local`
   - **macOS**: Usually `/usr/local` or `/opt/homebrew` (Apple Silicon)

5. **Check if Codex is already installed:**

   **Windows (PowerShell):**
   ```powershell
   where codex
   ```

   **Linux & macOS:**
   ```bash
   which codex
   ```

   - If found: Show version with `codex --version`
   - If not found: Proceed to Part 1 for your OS
   - If version is old: Uninstall and reinstall: `npm uninstall -g @openai/codex`

6. **Check if ~/.codex directory exists:**

   **Windows (PowerShell):**
   ```powershell
   Test-Path $env:USERPROFILE\.codex
   ```

   **Linux & macOS:**
   ```bash
   ls -la ~/.codex
   ```

   - If exists: Verify `auth.json` and `config.toml` exist inside
   - If not exists: You'll create it in Part 2

---

## Part 1: Installation

### Part 1a: Installation for Windows

Claude, execute these steps for Windows:

**Prerequisites Check:**
- Confirm Node.js is installed: `node --version`
- Confirm npm is installed: `npm --version`
- You have administrator or sudo-equivalent access

**Installation Steps:**

1. **Open PowerShell as Administrator** (if not already)

2. **Install Codex globally via npm:**
   ```powershell
   npm install -g "@openai/codex"
   ```

   Expected: Should show installation progress and complete without errors

3. **Verify Codex installation:**
   ```powershell
   codex --version
   ```

   Expected: Should show a version number (e.g., "0.57.0" or later)

   If "command not found":
   - Close and reopen PowerShell completely (to refresh PATH)
   - If still not found, proceed to "Part 5a: Windows Shell Configuration" to add to PATH

4. **Find the exact Codex installation path:**
   ```powershell
   where codex
   ```

   Expected output: Path like `C:\Users\USERNAME\AppData\Roaming\npm\codex.cmd`
   - Note this path for later use if needed

---

### Part 1b: Installation for Linux

Claude, execute these steps for Linux:

**Prerequisites Check:**
- Confirm Node.js is installed: `node --version`
- Confirm npm is installed: `npm --version`
- Check if you need sudo: `npm config get prefix`

**Installation Steps:**

1. **Check npm global directory:**
   ```bash
   npm config get prefix
   ```

   - If output is `/usr/local` or `/opt/...`: You'll likely need sudo
   - If output is in your home directory (e.g., `/home/username/.npm-global`): No sudo needed

2. **Install Codex globally via npm:**

   **If npm prefix is in home directory (no sudo needed):**
   ```bash
   npm install -g @openai/codex
   ```

   **If npm prefix is /usr/local (may need sudo):**
   ```bash
   sudo npm install -g @openai/codex
   ```

   Expected: Should show installation progress and complete without errors

3. **Verify Codex installation:**
   ```bash
   which codex
   ```

   Expected: Should show path like `/usr/local/bin/codex` or `/home/username/.npm-global/bin/codex`

   Then verify version:
   ```bash
   codex --version
   ```

   Expected: Should show version number (e.g., "0.57.0" or later)

4. **If Codex not in PATH after installation:**
   - Get the path from `which codex` command above
   - Proceed to "Part 5b: Linux Shell Configuration" to add to PATH

---

### Part 1c: Installation for macOS

Claude, execute these steps for macOS:

**Prerequisites Check:**
- Confirm Node.js is installed: `node --version`
- Confirm npm is installed: `npm --version`
- Determine your shell: `echo $SHELL` (should show `/bin/zsh` on Catalina+ or `/bin/bash` on older versions)

**Installation Steps (Recommended: via Homebrew):**

1. **Option A: Install via Homebrew (Recommended for macOS):**
   ```bash
   brew install codex
   ```

   Skip to verification step below.

2. **Option B: Install via npm (if Homebrew not available):**

   First check npm prefix:
   ```bash
   npm config get prefix
   ```

   Then install:
   ```bash
   npm install -g @openai/codex
   ```

3. **Verify Codex installation:**
   ```bash
   which codex
   ```

   Expected: Should show path like `/usr/local/bin/codex` or `/opt/homebrew/bin/codex`

   Then verify version:
   ```bash
   codex --version
   ```

   Expected: Should show version number (e.g., "0.57.0" or later)

4. **If Codex not in PATH:**
   - Get the path from `which codex` above
   - Proceed to "Part 5c: macOS Shell Configuration" to add to PATH

---

## Part 2: Create Codex Configuration Directory

Claude, execute this step for all operating systems:

1. **Create the `.codex` configuration directory:**

   **Windows (PowerShell):**
   ```powershell
   $codexDir = "$env:USERPROFILE\.codex"
   if (-not (Test-Path $codexDir)) {
       New-Item -ItemType Directory -Path $codexDir -Force | Out-Null
       Write-Host "Created: $codexDir"
   } else {
       Write-Host "Already exists: $codexDir"
   }
   ```

   **Linux & macOS:**
   ```bash
   mkdir -p ~/.codex
   echo "Created or verified: ~/.codex"
   ```

2. **Verify the directory exists:**

   **Windows (PowerShell):**
   ```powershell
   Test-Path $env:USERPROFILE\.codex
   # Should return: True
   ```

   **Linux & macOS:**
   ```bash
   ls -la ~/.codex
   # Should show directory listing
   ```

---

## Part 3: Set Up Codex Configuration File

Claude, create the Codex configuration file at the appropriate location for the OS:

**File Location:**
- **Windows**: `C:\Users\USERNAME\.codex\config.toml`
- **Linux & macOS**: `~/.codex/config.toml`

**Content to add to config.toml:**
```toml
[projects."CURRENT_PROJECT_PATH"]
trust_level = "trusted"

[profiles.claude]
approval_policy = "never"
sandbox_mode = "danger-full-access"
model = "gpt-5"
model_reasoning_effort = "high"
show_raw_agent_reasoning = false
```

**Important Instructions:**
1. Replace `CURRENT_PROJECT_PATH` with the absolute path to the current project directory
2. Get the current directory path:

   **Windows (PowerShell):**
   ```powershell
   (Get-Location).Path
   ```

   **Linux & macOS:**
   ```bash
   pwd
   ```

3. Example paths after replacement:
   - **Windows**: `[projects."C:\\Users\\username\\my-project"]` (note double backslashes in TOML)
   - **Linux**: `[projects."/home/username/my-project"]`
   - **macOS**: `[projects."/Users/username/my-project"]`

**Creation Instructions:**

**Windows (PowerShell):**
```powershell
$configPath = "$env:USERPROFILE\.codex\config.toml"
$projectPath = (Get-Location).Path.Replace("\", "\\")  # Escape backslashes for TOML

$content = @"
[projects."$projectPath"]
trust_level = "trusted"

[profiles.claude]
approval_policy = "never"
sandbox_mode = "danger-full-access"
model = "gpt-5"
model_reasoning_effort = "high"
show_raw_agent_reasoning = false
"@

Set-Content -Path $configPath -Value $content
Write-Host "Created: $configPath"
```

**Linux & macOS:**
```bash
cat > ~/.codex/config.toml << 'EOF'
[projects."$(pwd)"]
trust_level = "trusted"

[profiles.claude]
approval_policy = "never"
sandbox_mode = "danger-full-access"
model = "gpt-5"
model_reasoning_effort = "high"
show_raw_agent_reasoning = false
EOF

echo "Created: ~/.codex/config.toml"
```

**Alternative (More Permissive - for entire home directory):**

**Windows (PowerShell):**
```powershell
$configPath = "$env:USERPROFILE\.codex\config.toml"
$homePath = $env:USERPROFILE.Replace("\", "\\")

$content = @"
[projects."$homePath"]
trust_level = "trusted"

[profiles.claude]
approval_policy = "never"
sandbox_mode = "danger-full-access"
model = "gpt-5"
model_reasoning_effort = "high"
show_raw_agent_reasoning = false
"@

Set-Content -Path $configPath -Value $content
```

**Linux & macOS:**
```bash
cat > ~/.codex/config.toml << 'EOF'
[projects."$HOME"]
trust_level = "trusted"

[profiles.claude]
approval_policy = "never"
sandbox_mode = "danger-full-access"
model = "gpt-5"
model_reasoning_effort = "high"
show_raw_agent_reasoning = false
EOF
```

---

## Part 4: Initialize Git Repository (if not already done)

Claude, check and initialize git for all operating systems:

1. **Check if git is initialized:**

   **All OS:**
   ```bash
   git status 2>&1 | head -1
   ```

   - If shows "fatal: not a git repository": Proceed to step 2
   - If shows "On branch main" or "On branch master": Already initialized, skip to step 3

2. **If not a git repository, initialize it:**

   **All OS:**
   ```bash
   git init
   ```

3. **Configure git user (verify/set credentials):**

   **Check current configuration:**
   ```bash
   git config user.email
   git config user.name
   ```

   If empty, set them:
   ```bash
   git config user.email "your-email@example.com"
   git config user.name "Your Name"
   ```

   **Note:** Replace with actual email and name

4. **Verify git is initialized:**
   ```bash
   git status
   ```

   Expected: Should show "On branch main" or similar (not "fatal: not a git repository")

---

## Part 5: Handle PATH Issues (OS-Specific)

Claude, only follow the section for the user's operating system.

### Part 5a: Windows PATH Configuration

**Only follow this if Codex is not found** (i.e., `where codex` didn't work in Part 1a)

1. **Find the actual Codex path:**
   ```powershell
   where codex
   ```

   If this works, Codex is already in PATH - no action needed.

   If not found, find npm bin directory:
   ```powershell
   npm config get prefix
   ```

   Expected: `C:\Users\USERNAME\AppData\Roaming\npm`

2. **Add npm bin directory to PATH (temporary - current session only):**
   ```powershell
   $npmBin = (npm config get prefix) + "\node_modules\.bin"
   $env:Path = "$npmBin;$env:Path"

   # Verify
   where codex
   ```

3. **Add npm bin directory to PATH (permanent - all sessions):**

   **Using PowerShell (Recommended):**
   ```powershell
   $npmPrefix = npm config get prefix
   $npmBin = "$npmPrefix"

   # Check if already in PATH
   if ($env:Path -notcontains $npmBin) {
       [Environment]::SetEnvironmentVariable(
           "Path",
           [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::User) + ";$npmBin",
           [EnvironmentVariableTarget]::User
       )
       Write-Host "Added to PATH: $npmBin"
       Write-Host "Close and reopen PowerShell for changes to take effect"
   } else {
       Write-Host "Already in PATH"
   }
   ```

   **Alternative: System Properties UI**
   - Press `Win + X`, select "System"
   - Click "Advanced system settings"
   - Click "Environment Variables"
   - Under "User variables", click "New"
   - Variable name: `Path`
   - Variable value: `C:\Users\USERNAME\AppData\Roaming\npm` (replace USERNAME)
   - Click OK and restart PowerShell

4. **Verify Codex is now in PATH:**
   ```powershell
   where codex
   codex --version
   ```

---

### Part 5b: Linux PATH Configuration

**Only follow this if Codex is not found** (i.e., `which codex` didn't work in Part 1b)

1. **Find the actual Codex path:**
   ```bash
   which codex
   ```

   If this works, Codex is already in PATH - no action needed.

   If not found, check npm prefix:
   ```bash
   npm config get prefix
   ```

2. **Add npm bin directory to PATH (temporary - current session only):**
   ```bash
   export PATH="$(npm config get prefix)/bin:$PATH"

   # Verify
   which codex
   ```

3. **Add npm bin directory to PATH (permanent - all sessions):**

   **Step 1: Determine your shell:**
   ```bash
   echo $SHELL
   ```

   - If shows `/bin/bash`: Edit `~/.bashrc`
   - If shows `/bin/zsh`: Edit `~/.zshrc`
   - If shows `/bin/sh`: Edit `~/.profile`

   **Step 2: Add the export line:**

   **For bash users:**
   ```bash
   echo 'export PATH="$(npm config get prefix)/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

   **For zsh users:**
   ```bash
   echo 'export PATH="$(npm config get prefix)/bin:$PATH"' >> ~/.zshrc
   source ~/.zshrc
   ```

   **For sh users:**
   ```bash
   echo 'export PATH="$(npm config get prefix)/bin:$PATH"' >> ~/.profile
   source ~/.profile
   ```

4. **Verify Codex is now in PATH:**
   ```bash
   which codex
   codex --version
   ```

---

### Part 5c: macOS PATH Configuration

**Only follow this if Codex is not found** (i.e., `which codex` didn't work in Part 1c)

1. **Find the actual Codex path:**
   ```bash
   which codex
   ```

   If this works, Codex is already in PATH - no action needed.

   If installed via Homebrew and not found:
   ```bash
   brew --prefix codex
   ```

2. **Determine your shell:**
   ```bash
   echo $SHELL
   ```

   - **Catalina and newer (default zsh):** Edit `~/.zshrc`
   - **Older macOS (bash):** Edit `~/.bash_profile`

3. **Add to PATH (permanent):**

   **For zsh (macOS 10.15+):**
   ```bash
   echo 'export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"' >> ~/.zshrc
   source ~/.zshrc
   ```

   **For bash (macOS < 10.15):**
   ```bash
   echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile
   source ~/.bash_profile
   ```

4. **For npm-installed Codex (if not using Homebrew):**
   ```bash
   npmPrefix=$(npm config get prefix)
   echo "export PATH=\"$npmPrefix/bin:\$PATH\"" >> ~/.zshrc  # or ~/.bash_profile
   source ~/.zshrc  # or source ~/.bash_profile
   ```

5. **Verify Codex is now in PATH:**
   ```bash
   which codex
   codex --version
   ```

---

## Part 0a: Authenticate with Codex Subscription

Claude, help the user authenticate with their Codex subscription:

1. **Verify Codex subscription is active:**
   User should confirm their Codex subscription is active and valid
   (Check their Codex account dashboard)

2. **Run Codex login:**

   **All OS (same command):**
   ```bash
   codex login
   ```

   This command will:
   - Launch a device-based OAuth authentication flow
   - Direct user to browser to authenticate with their Codex account
   - Store authentication tokens in:
     - **Windows**: `C:\Users\USERNAME\.codex\auth.json`
     - **Linux & macOS**: `~/.codex/auth.json`
   - This is a one-time setup per machine

3. **Verify authentication works:**

   **All OS:**
   ```bash
   codex login status
   ```

   Should show: "You are authenticated as [your@email.com]"

   Or check the authentication file directly:

   **Windows (PowerShell):**
   ```powershell
   Get-Content $env:USERPROFILE\.codex\auth.json | Select-String "email"
   ```

   **Linux & macOS:**
   ```bash
   cat ~/.codex/auth.json | grep -i "email"
   ```

**Note:** Device-based OAuth means you'll be given a code to enter in your browser. This is the normal Codex authentication flow.

---

## Part 6: Verify Setup

### Part 6a: Windows Verification

Claude, verify the entire setup on Windows:

1. **Verify Codex is installed and in PATH:**
   ```powershell
   where codex
   codex --version
   ```
   Expected: Should show path and version number

2. **Verify Codex subscription authentication:**
   ```powershell
   codex login status
   ```
   Expected: "You are authenticated as [your-email@example.com]"

   Or check file:
   ```powershell
   Get-Content $env:USERPROFILE\.codex\auth.json
   ```

3. **Verify configuration file exists and is valid:**
   ```powershell
   $configPath = "$env:USERPROFILE\.codex\config.toml"
   if (Test-Path $configPath) {
       Write-Host "Config file exists"
       Get-Content $configPath
   } else {
       Write-Host "ERROR: Config file not found at $configPath"
   }
   ```

4. **Verify git initialization:**
   ```bash
   git status
   ```
   Expected: Should show "On branch main" or similar, not "fatal: not a git repository"

5. **Test Codex basic functionality:**
   ```powershell
   codex exec -p claude "echo 'Codex setup verification successful'"
   ```
   Expected: Should execute without "trusted directory" errors

---

### Part 6b: Linux Verification

Claude, verify the entire setup on Linux:

1. **Verify Codex is installed and in PATH:**
   ```bash
   which codex
   codex --version
   ```
   Expected: Should show path and version number

2. **Verify Codex subscription authentication:**
   ```bash
   codex login status
   ```
   Expected: "You are authenticated as [your-email@example.com]"

   Or check file:
   ```bash
   cat ~/.codex/auth.json
   ```

3. **Verify configuration file exists and is valid:**
   ```bash
   if [ -f ~/.codex/config.toml ]; then
       echo "Config file exists:"
       cat ~/.codex/config.toml
   else
       echo "ERROR: Config file not found at ~/.codex/config.toml"
   fi
   ```

4. **Verify git initialization:**
   ```bash
   git status
   ```
   Expected: Should show "On branch main" or similar, not "fatal: not a git repository"

5. **Test Codex basic functionality:**
   ```bash
   codex exec -p claude "echo 'Codex setup verification successful'"
   ```
   Expected: Should execute without "trusted directory" errors

---

### Part 6c: macOS Verification

Claude, verify the entire setup on macOS:

1. **Verify Codex is installed and in PATH:**
   ```bash
   which codex
   codex --version
   ```
   Expected: Should show path and version number

2. **Verify Codex subscription authentication:**
   ```bash
   codex login status
   ```
   Expected: "You are authenticated as [your-email@example.com]"

   Or check file:
   ```bash
   cat ~/.codex/auth.json
   ```

3. **Verify configuration file exists and is valid:**
   ```bash
   if [ -f ~/.codex/config.toml ]; then
       echo "Config file exists:"
       cat ~/.codex/config.toml
   else
       echo "ERROR: Config file not found at ~/.codex/config.toml"
   fi
   ```

4. **Verify git initialization:**
   ```bash
   git status
   ```
   Expected: Should show "On branch main" or similar, not "fatal: not a git repository"

5. **Test Codex basic functionality:**
   ```bash
   codex exec -p claude "echo 'Codex setup verification successful'"
   ```
   Expected: Should execute without "trusted directory" errors

---

## Part 7: Test Two-Way Communication

Claude, test that Codex can interact with the project:

1. **Test reading project files:**
   ```bash
   codex exec -p claude "List the main files and directories in this project"
   ```

2. **Test analyzing documentation (if docs exist):**
   ```bash
   codex exec -p claude "Read any documentation files in this project and provide a one-paragraph summary"
   ```

3. **Test asking clarifying questions:**
   ```bash
   codex exec -p claude "
   Analyze the current project.
   Then ask me 3 clarifying questions about the team size, timeline, and technical constraints.
   I will answer these questions in the next prompt."
   ```

---

## Success Criteria

Claude, please verify all of the following are true:

✅ User has active Codex subscription

✅ Operating system detected (Windows / Linux / macOS)

✅ Node.js v18+ installed

✅ npm v8+ installed

✅ Git installed

✅ `codex --version` returns a version number

✅ `codex login status` shows user is authenticated with their Codex account

✅ `~/.codex/auth.json` (or Windows equivalent) exists with authentication tokens

✅ `~/.codex/config.toml` (or Windows equivalent) exists and is valid TOML

✅ Current project directory is a git repository (git status works)

✅ Codex is in system PATH (command works from any directory)

✅ `codex exec -p claude "test"` runs without "trusted directory" errors

✅ All setup parts completed successfully for the user's OS

---

## Troubleshooting by Operating System

### Windows Troubleshooting

**Problem: "codex: The term 'codex' is not recognized"**
- Cause: Codex not in PATH
- Solution: Follow Part 5a to add npm bin directory to PATH
- Verify: Close PowerShell completely, reopen, then try `where codex`

**Problem: "npm install permission denied"**
- Cause: Insufficient permissions
- Solution: Run PowerShell as Administrator
- Verify: Run `whoami` - should show admin status

**Problem: "cannot find path because it does not exist"**
- Cause: Path syntax error in config.toml (backslashes not escaped)
- Solution: Ensure all backslashes in paths are doubled: `"C:\\Users\\..."` not `"C:\Users\..."`
- Verify: Use Part 3 PowerShell script to regenerate config.toml

**Problem: "User profile path incorrect"**
- Solution: Check actual path with `echo $env:USERPROFILE` in PowerShell
- Update config.toml with correct path

---

### Linux Troubleshooting

**Problem: "command not found: codex"**
- Cause: npm global bin not in PATH
- Solution: Follow Part 5b to add to PATH
- Verify: Run `which codex` - should show path

**Problem: "sudo: npm: command not found"**
- Cause: npm not installed or not in root's PATH
- Solution: Use regular npm without sudo, or check npm installation
- Verify: `npm -g bin` should show where global packages install

**Problem: "Permission denied" during npm install**
- Cause: npm prefix is /usr/local but no sudo
- Solution: Either use `sudo npm install -g` or reconfigure npm to use home directory
- Alternative: `npm config set prefix ~/.npm-global`

**Problem: Config file not readable**
- Cause: File permissions too restrictive
- Solution: `chmod 644 ~/.codex/config.toml`
- Verify: `ls -la ~/.codex/config.toml` should show readable permissions

---

### macOS Troubleshooting

**Problem: "codex: command not found"**
- If installed via Homebrew: Run `brew link codex`
- If installed via npm: Follow Part 5c PATH configuration
- Verify: `which codex` should return path

**Problem: "zsh: command not found: codex"**
- Cause: Shell cache not updated after PATH change
- Solution: Run `hash -r` to clear shell cache, or restart Terminal
- Verify: Close Terminal, reopen, then try `which codex`

**Problem: "permission denied: /usr/local/bin"**
- Cause: Homebrew or npm needs permissions
- Solution: `sudo chown -R $(whoami):admin /usr/local/bin`
- Alternative: Use Homebrew to install instead of npm

**Problem: "M1/M2 (Apple Silicon) codex not working"**
- Cause: Architecture mismatch or npm prefix pointing to wrong location
- Solution: Check `npm config get prefix` - should be `/opt/homebrew` for Apple Silicon
- Fix: `npm config set prefix /opt/homebrew`
- Verify: `which codex` should show `/opt/homebrew/bin/codex`

---

## Success Indicators

After setup, you should be able to:

- ✅ Run `codex --version` from any directory
- ✅ Run `codex login status` and see your email
- ✅ Run `codex exec -p claude "any command"` without PATH errors
- ✅ Access `~/.codex/config.toml` (or Windows equivalent) in any editor
- ✅ Have git initialized in your project directory

---

## Summary of What Was Set Up

After completing these steps, you will have:

- ✅ OS-appropriate Codex installation (Windows/Linux/macOS)
- ✅ Codex added to system PATH
- ✅ Codex configuration directory at `~/.codex` (or Windows equivalent)
- ✅ Codex configuration file at `~/.codex/config.toml` (or Windows equivalent)
- ✅ Project directories marked as trusted
- ✅ Codex authenticated with active subscription
- ✅ Git repository initialized
- ✅ Profile "claude" configured with GPT-5 and high reasoning
- ✅ Two-way communication capability enabled
- ✅ Ready to use Codex for project analysis and planning

---

## How to Use Codex Now

Once setup is complete, you can ask Claude Code to:

**Example requests:**
- "Have Codex analyze the project structure and provide recommendations"
- "Ask Codex to review the Phase 0 plan and suggest priorities"
- "Have Codex ask clarifying questions about team size and timeline"
- "Request Codex to create a technical specification"

Claude will automatically:
1. Invoke Codex with appropriate prompts
2. Capture the output
3. Provide summaries and recommendations
4. Execute any follow-up actions based on Codex's suggestions

---

## Environment Variables

For reference, here are the key environment variables and paths used:

**Windows:**
- `%USERPROFILE%` = `C:\Users\USERNAME` (home directory)
- Codex config: `%USERPROFILE%\.codex\` (e.g., `C:\Users\john\.codex\`)
- npm global: `%APPDATA%\npm\` (usually)

**Linux:**
- `$HOME` = `/home/username` (home directory)
- Codex config: `~/.codex/` (e.g., `/home/john/.codex/`)
- npm global: varies based on configuration

**macOS:**
- `$HOME` = `/Users/username` (home directory)
- Codex config: `~/.codex/` (e.g., `/Users/john/.codex/`)
- npm global: `/usr/local/bin` or `/opt/homebrew/bin` (Apple Silicon)

---

## Additional Notes

- **Codex Version:** 0.57.0 or later required
- **Node.js Version:** v18.0.0 or later recommended
- **npm Version:** v8.0.0 or later recommended
- **Model:** Uses GPT-5 with high reasoning effort
- **Safety Mode:** Set to "danger-full-access" (change to "workspace-write" for production)
- **Configuration Format:** TOML (case-sensitive, require exact syntax)

---

## Part 8: Persistent Session Monitoring Setup

**Purpose:** Enable Claude Code to automatically monitor Codex task execution with real-time visibility

### What This Does

Sets up infrastructure for Claude Code to:
- Keep sessions open while Codex works on background tasks
- Poll task status every 45 seconds
- Log progress and blockers in real-time
- Alert on failures or timeout conditions
- Capture full outputs upon completion

### Monitoring Configuration

Create a monitoring configuration file that Claude Code will read:

**Linux/macOS:**
```bash
mkdir -p ~/.codex/monitoring
cat > ~/.codex/monitoring/config.json << 'EOF'
{
  "monitoring_enabled": true,
  "polling_interval_seconds": 45,
  "max_task_duration_hours": 8,
  "escalation_threshold_multiplier": 2,
  "log_directory": "~/.codex/monitoring/logs",
  "session_persistence": true
}
EOF
```

**Windows (PowerShell):**
```powershell
$monitoringDir = "$env:USERPROFILE\.codex\monitoring"
New-Item -ItemType Directory -Force -Path $monitoringDir | Out-Null

$config = @{
    "monitoring_enabled" = $true
    "polling_interval_seconds" = 45
    "max_task_duration_hours" = 8
    "escalation_threshold_multiplier" = 2
    "log_directory" = "$monitoringDir\logs"
    "session_persistence" = $true
} | ConvertTo-Json

$config | Out-File -FilePath "$monitoringDir\config.json" -Encoding UTF8
```

### How Claude Code Uses This

When Claude Code spawns a Codex task, it will:

1. **Record task metadata** to `~/.codex/monitoring/logs/task-<id>.json`
2. **Start polling loop** (every 45 seconds):
   ```
   Check status → Log transition → Check for blockers → Repeat until completion
   ```
3. **Keep session open** during task execution (don't exit CLI)
4. **Report status** periodically to user
5. **Capture output** immediately upon completion

### Example Session Flow

```
[12:45:00] Task spawned (ID: c54860)
[12:45:00] Monitoring enabled, polling every 45s
[12:45:45] [POLL 1] Status: running
[12:46:30] [POLL 2] Status: running (reading file: generators/fastify.ts)
[12:47:15] [POLL 3] Status: running (modifying: run-smoke-tests.ts)
[12:48:00] [POLL 4] Status: running (building CLI)
[12:48:45] [POLL 5] Status: completed
→ Full output captured
→ Logged to task-c54860.json
→ Ready for handoff to next phase
```

### Environment Variables (Optional)

Set these if you want custom monitoring behavior:

```bash
export CODEX_MONITOR_INTERVAL=45          # polling interval in seconds
export CODEX_MONITOR_TIMEOUT=28800        # max task duration in seconds (8 hours)
export CODEX_MONITOR_LOG_DIR="~/.codex/monitoring/logs"
export CODEX_KEEP_SESSION_OPEN=true       # keep CLI session open during tasks
```

### Task Log Location

All task execution logs are stored at:
- **Linux/macOS:** `~/.codex/monitoring/logs/task-<id>.json`
- **Windows:** `%USERPROFILE%\.codex\monitoring\logs\task-<id>.json`

Each log contains:
- Task ID, start/end times
- Status history with timestamps
- Key milestones and blockers
- Full output upon completion
- Handoff requirements

---

## Part 9: Verify Monitoring Setup (All OS)

After Part 8, verify monitoring is ready:

```bash
# Check monitoring directory exists
ls -la ~/.codex/monitoring/

# Check config file
cat ~/.codex/monitoring/config.json

# Create logs directory if missing
mkdir -p ~/.codex/monitoring/logs
```

**Expected output:**
```
total X
-rw-r--r-- 1 user user  XXX Nov 12 12:45 config.json
drwxr-xr-x 1 user user  XXX Nov 12 12:45 logs
```

---

## Next Steps After Setup

1. Claude Code can now spawn Codex tasks with automatic monitoring
2. Sessions will stay open while tasks run
3. Status updates logged every 45 seconds
4. Full outputs captured upon completion
5. Ready for autonomous task coordination

### Typical Workflow

```
User: "Proceed with next task"
       ↓
Claude Code: Spawns Codex task (with monitoring enabled)
       ↓
Claude Code: Keeps session open, polls every 45s
       ↓
Claude Code: Logs progress: "Status: running → completed"
       ↓
Claude Code: Captures full output and prepares handoff
       ↓
Claude Code: Reports completion to user
```

---

## Part 10: Create/Update AGENTS.md Coordination Protocol

**Purpose:** Set up the Codex & Claude Code collaboration protocol in the project root

Claude, create or update the `AGENTS.md` file in the current project directory with the complete coordination protocol:

**All OS (same for all):**

```bash
# Create AGENTS.md in the project root
cat > AGENTS.md << 'EOF'
# Codex & Claude Code Collaboration Protocol

**Version:** 1.0
**Date:** November 12, 2025
**Status:** Active - Read by Codex at session start

---

## Overview

This document defines the persistent collaboration framework between **Codex** (OpenAI's code agent) and **Claude Code** (Anthropic's CLI for Claude). It ensures clear two-way communication, consistent task allocation, and explicit handoff points.

**Key principle:** Codex and Claude Code work as complementary agents with distinct capabilities. This protocol prevents duplication, confusion, and ensures tasks reach the right agent.

---

## Part 1: Core Capabilities & Limitations

### Codex Capabilities

- **Repository work:** Read/search files, analyze code, refactor, add features, fix bugs, update docs, write tests, and produce diffs via `apply_patch`
- **Shell execution:** Run commands, build/test/lint, inspect environments, parse logs, and script workflows
- **Planning:** Maintain step-by-step plans and status via the plan tool; keep progress visible and auditable
- **Analysis:** Diagnose failures, trace flows, assess complexity, find dead code, and spot security issues
- **Images:** Inspect local images by path when relevant to the codebase (e.g., assets, diagrams)
- **Network (when enabled):** Install dependencies, run package managers, and fetch artifacts as needed
- **Protocol discipline:** Follow this AGENTS.md, keep changes minimal and in-style, avoid unrelated fixes, respect file/style conventions

### Codex Limitations

- **External systems:** No direct access to SaaS dashboards, org tools, or any account-bound services without credentials or explicit connectors
- **Secrets/credentials:** Cannot create, manage, or assume secrets unless provided securely
- **GUI/manual workflows:** No browser-driven manual QA or GUI interactions unless scripted via CLI
- **Long-running/interactive work:** Cannot babysit background jobs outside this session; needs explicit logging and handoff
- **Output windowing:** Large files/outputs are read in chunks; commands and file reads should be scoped
- **Policy/legal/business:** Cannot make policy or legal decisions; requires human or external agent review
- **External service integration:** No native ability to call third-party APIs, create PRs, manage CI/CD, or handle cloud consoles

### Claude Code Capabilities

- **External service integration:** GitHub/GitLab PR creation, ticketing, CI/CD admin, cloud consoles, API calls
- **Secrets and access management:** Provision tokens, vault setup, permissions, org policy alignment
- **Manual QA and UX:** Cross-browser testing, visual diffs, design sign-off, user feedback synthesis
- **Cross-repo/org architecture:** Multi-repo refactors, dependency policy shifts, team process design
- **Long-running job monitoring:** Deployments, backfills, migrations, incident response coordination
- **Legal/compliance/security:** Policy reviews, vendor evaluations, contract implications, security approvals
- **Specialized task agents:** Access to domain-specific agents (backend-dev, frontend-dev, ml-developer, etc.)
- **Advanced search and exploration:** Use Explore agent for codebase discovery and context gathering

---

## Part 2: Task Allocation Framework

### What Codex Should Handle

- In-repo code changes, tests, refactors, and fixes
- Deterministic CLI tasks: builds, linters, formatters, migrations, local databases
- Targeted debugging: reproduce failures, write minimal repros, add logging, propose patches
- Security/code quality passes: static analysis, dependency pinning, small hardening steps
- Local documentation: READMEs, examples, dev scripts, runbooks
- Generating concise change summaries, release notes from commits, and diff explanations
- Analyzing existing code, design patterns, and architectural decisions within the repo

### What Claude Code Should Handle

- **External services:** GitHub PR creation, issue management, CI/CD admin, cloud deployments
- **Secrets and access:** Provisioning tokens, vault setup, permissions alignment, security policies
- **Manual testing:** Cross-browser QA, visual regression testing, UX reviews, stakeholder demos
- **Org-level changes:** Multi-repo coordination, dependency policy shifts, team processes, standards
- **Long-running pipelines:** Monitor deployments, handle backfills, manage migrations, respond to incidents
- **Approvals and reviews:** Legal/compliance sign-off, security reviews, policy alignment, vendor evaluation
- **Ambiguity resolution:** When requirements are unclear, acceptance criteria missing, or instructions conflict
- **Specialized domain work:** Invoke backend-dev, frontend-dev, ml-developer, or other specialized agents as needed
- **Strategic planning:** High-level architecture decisions, tech stack choices, scaling strategies

---

## Part 3: Communication Structure

### Message Tags for Clarity

Use these tags to structure all communications between Codex and Claude Code:

- **`[CONTEXT]`** — Background information, constraints, external links, system state
- **`[OBJECTIVE]`** — Explicit success criteria and what "done" looks like
- **`[PLAN]`** — Step-by-step action items (4–7 words each, 3–7 steps total)
- **`[ACTION]`** — What needs to happen right now; explicit request to one agent
- **`[HANDOFF]`** — When Codex is blocked and needs Claude Code to intervene
- **`[RESULT]`** — Summary of changes, where they are, how they were verified
- **`[BLOCKED]`** — What's missing or failing; options for unblocking

### File & Command Precision

- Reference files with paths and optional line numbers: `src/app.ts:42`, `backend/services/users.ts:104`
- Provide commands exactly as runnable: `npm test`, `pytest -q`, `docker build -t myapp .`
- For large outputs, request the specific slice: "Show lines 50–75 of `config.ts`"
- When providing diffs, include file paths and context

### Update Cadence

- **Before grouped shell work:** Send a 1–2 sentence preamble explaining what's about to run
- **Multi-step work:** Update plan status periodically and provide short progress notes (1–3 sentences)
- **End of work:** Summarize changes with a diff-oriented narrative and how they were verified

### Task Contract Format

When initiating a new task, structure the request as follows:

\`\`\`
[CONTEXT]
Repository path(s), system info, relevant constraints, external links

[OBJECTIVE]
What success looks like; explicit acceptance criteria

[SCOPE]
What's in scope (files/areas); what's explicitly out of scope

[ACCEPTANCE]
Tests passing, performance budgets, specific behaviors, security requirements

[ENV]
Commands to run locally, environment variables, data setup

[PRIORITY]
Deadline or sequencing (e.g., "blocking," "nice-to-have," "due by Friday")

[ACTION]
Explicit request (e.g., "Codex, please implement feature X" or "Claude Code, create a PR with these changes")
\`\`\`

---

## Part 4: Key Handoff Points

Codex defers to Claude Code when any of the following are true:

### Credentials & Secrets

- Third-party API keys, private registries, cloud resource credentials, CI/CD secrets
- Vault setup, token provisioning, key rotation, secure credential storage

### External Approvals

- Security reviews or compliance checks
- Policy/legal/business decision sign-off
- Production change windows or deployment approvals
- Vendor evaluations or contract implications

### GUI & Manual Testing

- Cross-browser or cross-device QA
- Visual regression testing, UI/UX reviews, design sign-off
- Manual user journey testing or stakeholder demos
- Screenshot/video capture for documentation or bug reports

### Org-Level Changes

- Multi-repo refactors or dependency policy shifts
- Team process changes, standards, or governance
- Shared library updates affecting multiple projects
- Monorepo reorganization or cross-team coordination

### Long-Running Pipelines

- Deployments to staging/production needing real-time observation
- Data backfills or large migrations requiring checkpoint monitoring
- CI/CD job failures needing investigation or escalation
- Incident response coordination across teams

### Sandbox/Network Constraints

- When network/filesystem limits block progress (e.g., package installs fail due to network)
- When compute limits are exceeded or timeouts occur
- When ephemeral session constraints prevent task completion

### Ambiguity or Conflicting Instructions

- Unclear requirements or missing acceptance criteria
- Instructions that conflict with this AGENTS.md or project conventions
- Requests that straddle Codex and Claude Code capabilities (need clarification)

### Handoff Format

When Codex needs to hand off, it sends:

\`\`\`
[HANDOFF]
What external action is needed (e.g., "create PR", "add secret", "approve deployment")

[ARTIFACTS]
Branch name, diff summary, build artifacts, logs, or other supporting materials

[INSTRUCTIONS]
Exact steps or URL targets for Claude Code to follow

[DONE WHEN]
Condition that confirms completion (e.g., "PR merged", "secret available in CI/CD", "deployment succeeds")
\`\`\`

---

## Part 5: Primer Prompt (Drop-In)

**Use this prompt at the start of every new session or task to align quickly.**

\`\`\`
You are Codex, a code agent. Claude Code is the Anthropic CLI for Claude.

Read and follow AGENTS.md in this repo. It defines:
- Your capabilities and limitations
- Task allocation (what you handle vs. Claude Code handles)
- Communication structure (message tags, precision, handoff format)
- Key handoff points (when to defer to Claude Code)

Collaboration Protocol:
- Start by confirming you understand this task, list assumptions, propose [PLAN] with 3–7 steps
- Maintain your [PLAN] using the plan tool; update it as you work
- Send a 1–2 sentence preamble before grouped shell actions
- Reference files precisely (e.g., api/routes.ts:42) and provide runnable commands
- Summarize changes with a diff-oriented narrative and how you verified them
- When blocked, send [HANDOFF] with: what's needed, exact steps/URLs, artifacts, and "done when" criteria

Task Contract (fill this in):
- [CONTEXT]: repo path(s), system info, constraints
- [OBJECTIVE]: clear success criteria
- [SCOPE]: in/out of scope, files/areas
- [ACCEPTANCE]: tests, perf, behaviors, security
- [ENV]: commands to run, env vars
- [PRIORITY]: deadline or sequencing

Ready to begin?
\`\`\`

---

## Part 6: Example Task Kickoff

This is how a well-formed task looks when passed to Codex:

\`\`\`
[CONTEXT]
Monorepo at /mnt/storage/saasgen, Node 20, pnpm, CI via GitHub Actions.
Current branch: main. No uncommitted changes.

[OBJECTIVE]
Add pagination to GET /users endpoint (server + tests).
Success = new tests pass, existing tests unaffected, response time ≤ 100ms.

[SCOPE]
Files: backend/routes/users.ts, backend/tests/users.test.ts
Out of scope: frontend, UI components, database schema changes

[ACCEPTANCE]
- New pagination tests pass (offset, limit, total_count)
- All existing tests pass
- No breaking changes to response structure
- Performance: response time unchanged or improved

[ENV]
cd /mnt/storage/saasgen
pnpm install
pnpm test

[PRIORITY]
Due by end of week; not blocking other work

[ACTION]
Codex, please implement pagination for GET /users and add comprehensive tests.
\`\`\`

---

## Part 7: Constraints & Guardrails

### What Codex Must NOT Do

- Do not commit or push to remote unless explicitly asked
- Do not change branches unless explicitly asked
- Do not add unrelated fixes; call them out separately instead
- Do not make policy or business decisions; defer to Claude Code
- Do not assume secrets or credentials; ask for them explicitly
- Do not run destructive commands (force push, hard reset, drop tables) without explicit confirmation

### What Claude Code Must NOT Do

- Do not ask Codex to access external services or manage credentials
- Do not assume Codex can run GUI tools or perform manual QA
- Do not ask Codex to work outside the repo or across multiple repos without explicit coordination
- Do not force Codex to make policy/legal/business decisions

---

## Part 8: Success Indicators

After a task is complete, Codex and Claude Code should both confirm:

- ✅ All acceptance criteria met (tests pass, perf targets hit, security checks done)
- ✅ Changes are minimal and in-style (no unrelated fixes)
- ✅ Large files read in chunks; outputs scoped appropriately
- ✅ Documentation updated (READMEs, examples, inline comments as needed)
- ✅ Verification steps completed (tests run, builds succeed, code reviewed)
- ✅ If handoffs occurred, all artifacts transferred and "done when" conditions met
- ✅ Communication was clear (message tags used, files/commands precise, progress tracked)

---

## Part 9: Escalation & Ambiguity

**If ambiguity arises:**

1. Codex identifies the ambiguity and sends \`[BLOCKED]\` with options
2. Claude Code clarifies and responds with updated task contract
3. Both agents confirm understanding before proceeding

**If a task requires both Codex and Claude Code:**

1. Codex handles the in-repo, deterministic parts first
2. Codex sends \`[HANDOFF]\` when external action is needed
3. Claude Code takes over (e.g., creates PR, manages CI/CD, approves)
4. Claude Code confirms completion and resumes Codex if further code work is needed

---

## Part 10: References & Versions

- **Protocol Version:** 1.0
- **Codex Version:** 0.57.0+
- **Claude Code:** Anthropic Claude model
- **Last Updated:** November 12, 2025

---

## Quick Reference

| Task Type | Codex? | Claude Code? |
|-----------|--------|--------------|
| Code changes, tests, refactors | ✅ | ❌ |
| Build, lint, format, migrate | ✅ | ❌ |
| Debug, analyze, trace flows | ✅ | ❌ |
| GitHub PRs, CI/CD admin | ❌ | ✅ |
| Secrets, tokens, vault | ❌ | ✅ |
| Manual QA, cross-browser testing | ❌ | ✅ |
| Multi-repo coordination | ❌ | ✅ |
| Legal/compliance approvals | ❌ | ✅ |
| Ambiguous requirements | ❌ | ✅ |

---

**End of AGENTS.md**
EOF

echo "Created/Updated: AGENTS.md"
```

**Expected output:**
```
Created/Updated: AGENTS.md
```

**Verify the file was created:**

```bash
# Check file exists
test -f AGENTS.md && echo "✅ AGENTS.md exists" || echo "❌ AGENTS.md not found"

# Show first 10 lines
head -20 AGENTS.md
```

Expected: File exists and contains the collaboration protocol header.

---

**Document Version:** 2.2 (With AGENTS.md Creation)
**Date:** November 12, 2025
**Status:** Ready for Claude Code Execution
**Supported OS:** Windows, Linux, macOS
**Monitoring:** 45-second polling with session persistence
**New:** Automatic AGENTS.md coordination protocol creation
