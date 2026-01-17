
# 🚀 Turbo Flow Claude v2.0.0

**✨ Entorno de Desarrollo Agéntico — Claude Flow V3**

---

## 🏗️ Arquitectura

```diff
+ ┌─────────────────────────────────────────────────────────────────┐
+ │                    TURBO FLOW v2.0.0                            │
+ ├─────────────────────────────────────────────────────────────────┤
+ │  🎨 INTERFAZ: Claude Code (CLI) │ Dev-Browser │ HeroUI         │
+ ├─────────────────────────────────────────────────────────────────┤
+ │  🧠 ORQUESTRACIÓN: Claude Flow V3                               │
+ │  54+ Agentes Nativos │ MCP Unificado │ Trabajadores en 2º plano│
+ ├─────────────────────────────────────────────────────────────────┤
+ │  🧪 PRUEBAS: Agentic QE (19 agentes) │ Playwriter (IA tests)   │
+ ├─────────────────────────────────────────────────────────────────┤
+ │  🔒 SEGURIDAD: Security Analyzer │ Integración Codex            │
+ ├─────────────────────────────────────────────────────────────────┤
+ │  📄 ESPECIFICACIONES: Spec-Kit │ OpenSpec                      │
+ └─────────────────────────────────────────────────────────────────┘
```

---

## ⚡ Inicio Rápido

### 🐳 DevPod

```bash
# 🍎 macOS
brew install loft-sh/devpod/devpod

# 🪟 Windows
choco install devpod

# 🐧 Linux
curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64"
sudo install devpod /usr/local/bin

# 🚀 Lanzar
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

---

## 🛠️ Stack Principal

| 🛠️ Herramienta | 🏷️ Alias | 📝 Descripción |
|------|-------|-------------|
| 🤖 Claude Code | `claude`, `dsp` | CLI de codificación con IA de Anthropic |
| 🧩 Claude Flow V3 | `cf`, `cf-swarm` | Orquestación de agentes (54+ agentes) |
| 🧪 Agentic QE | `aqe` | Pipeline de pruebas (19 agentes) |
| 🎭 Playwriter | `playwriter` | IA genera pruebas de Playwright |
| 🌐 Dev-Browser | `devb-start` | Desarrollo visual con IA |
| 🛡️ Security Analyzer | — | Escaneo de vulnerabilidades (Habilidad Claude) |
| 📋 Spec-Kit | `sk` | Desarrollo basado en especificaciones |
| 📘 OpenSpec | `os` | Flujo de trabajo de especificaciones de Fission AI |
| 🧬 Codex | `codex` | Agente de código de OpenAI (opcional) |

---

## ⚙️ Configuración MCP

```json
{
  "mcpServers": {
    "claude-flow": {
      "command": "npx",
      "args": ["-y", "claude-flow@v3alpha", "mcp", "start"]
    },
    "agentic-qe": {
      "command": "npx",
      "args": ["-y", "aqe-mcp"]
    },
    "playwriter": {
      "command": "npx",
      "args": ["-y", "playwriter@latest"]
    }
  }
}
```

---

## 🎮 Comandos Clave

```diff
+ # Claude Code
+ claude                    # Iniciar Claude
+ dsp                       # Modo omitir permisos

+ # Claude Flow V3
+ cf-init                   # Inicializar espacio de trabajo
+ cf-swarm                  # Enjambre jerárquico
+ cf-mesh                   # Enjambre en malla
+ cf-agent <tipo> "tarea"   # Ejecutar agente específico
+ cf-list                   # Listar agentes
+ cf-daemon                 # Iniciar demonio en segundo plano
+ cf-memory-status          # Verificar sistema de memoria
+ cf-security               # Escaneo de seguridad

+ # prd2build (en Claude Code)
+ /prd2build prd.md         # Generar documentación desde PRD
+ /prd2build prd.md --build # Generar documentación + build

+ # Pruebas
+ aqe-generate              # Generar pruebas
+ aqe-gate                  # Control de calidad

+ # Codex (opcional)
+ codex-run "tarea"         # Ejecutar con perfil Claude
+ codex-check               # Verificar estado de configuración

+ # Estado
+ turbo-status              # Verificar todas las herramientas
+ turbo-help                # Referencia rápida
```

---

## 📂 Estructura del Proyecto

```
/workspaces/turbo-flow-claude/
├── src/                    # 📝 Código fuente
├── tests/                  # 🧪 Archivos de prueba
├── docs/                   # 📚 Documentación generada
├── plans/                  # 📈 Investigación y arquitectura
├── .claude-flow/           # 🧩 Configuración Claude Flow V3
├── AGENTS.md               # 🤖 Protocolo de colaboración Codex/Claude
└── CLAUDE.md               # 🧠 Contexto del proyecto
```

---

## 👣 Pasos Manuales Después de la Instalación

1.  **🎭 Extensión Playwriter para Chrome**  
    https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe

2.  **🧬 Codex (opcional)**
    ```bash
    npm install -g @openai/codex
    codex login
    ```

---

## 🔗 Recursos

| 📚 Recurso | 🔗 URL |
|----------|-----|
| 🧩 Claude Flow V3 | github.com/ruvnet/claude-flow |
| 🚀 Turbo Flow Claude | github.com/marcuspat/turbo-flow-claude |
| 🧪 Agentic QE | npmjs.com/package/agentic-qe |
| 🎭 Playwriter | github.com/remorses/playwriter |
| 🎨 HeroUI | heroui.com |
