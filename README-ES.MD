# Turbo Flow Claude v2.0.0

**Entorno de Desarrollo Agéntico — Claude Flow V3 + RuVector**

---

## Arquitectura

```
┌─────────────────────────────────────────────────────────────────┐
│                    TURBO FLOW v2.0.0                            │
├─────────────────────────────────────────────────────────────────┤
│  INTERFAZ: Claude Code (CLI) │ Dev-Browser │ HeroUI             │
├─────────────────────────────────────────────────────────────────┤
│  MOTOR NEURONAL: RuVector                                       │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐   │
│  │  SONA   │ │  HNSW   │ │   MoE   │ │  EWC++ │ │   GNN   │   │
│  │<0.05ms  │ │  150x   │ │8 expertos│ │95% ret │ │ capas   │   │
│  └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘   │
├─────────────────────────────────────────────────────────────────┤
│  ORQUESTACIÓN: Claude Flow V3                                   │
│  54+ Agentes Nativos │ MCP Unificado │ Workers en Segundo Plano │
├─────────────────────────────────────────────────────────────────┤
│  PRUEBAS: Agentic QE (19 agentes) │ Playwriter (tests con IA)   │
├─────────────────────────────────────────────────────────────────┤
│  SEGURIDAD: Security Analyzer │ Integración con Codex           │
├─────────────────────────────────────────────────────────────────┤
│  ESPECIFICACIONES: Spec-Kit │ OpenSpec                          │
└─────────────────────────────────────────────────────────────────┘
```

---

## Inicio Rápido

### DevPod

```bash
# macOS
brew install loft-sh/devpod/devpod

# Windows
choco install devpod

# Linux
curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64"
sudo install devpod /usr/local/bin

# Iniciar
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

---

## Stack Principal

| Herramienta | Alias | Descripción |
|-------------|-------|-------------|
| RuVector | `ruv` | Base de datos vectorial + GNN + motor neuronal auto-aprendizaje |
| @ruvector/sona | — | Auto-aprendizaje SONA (<0.05ms adaptación) |
| @ruvector/cli | `ruv-*` | Hooks de inteligencia para Claude Code |
| Claude Code | `claude`, `dsp` | CLI de codificación con IA de Anthropic |
| Claude Flow V3 | `cf`, `cf-swarm` | Orquestación de agentes (54+ agentes) |
| Agentic QE | `aqe` | Pipeline de pruebas (19 agentes) |
| Playwriter | `playwriter` | IA genera tests de Playwright |
| Dev-Browser | `devb-start` | Desarrollo visual con IA |
| Security Analyzer | — | Escaneo de vulnerabilidades (skill de Claude) |
| Spec-Kit | `sk` | Desarrollo basado en especificaciones |
| OpenSpec | `os` | Flujo de especificaciones de Fission AI |
| Codex | `codex` | Agente de código de OpenAI (opcional) |

---

## Configuración MCP

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

## Comandos Principales

```bash
# RuVector
ruv                       # Iniciar RuVector
ruv-stats                 # Mostrar estadísticas de aprendizaje
ruv-route "tarea"         # Enrutar tarea al mejor agente
ruv-remember -t edit "X"  # Guardar en memoria semántica
ruv-recall "consulta"     # Buscar en memoria semántica
ruv-learn                 # Registrar trayectoria de aprendizaje
ruvector-status           # Verificar estado de RuVector

# Claude Code
claude                    # Iniciar Claude
dsp                       # Modo sin permisos

# Claude Flow V3
cf-init                   # Inicializar workspace
cf-swarm                  # Enjambre jerárquico
cf-mesh                   # Enjambre en malla
cf-agent <tipo> "tarea"   # Ejecutar agente específico
cf-list                   # Listar agentes
cf-daemon                 # Iniciar daemon en segundo plano
cf-memory-status          # Verificar sistema de memoria
cf-security               # Escaneo de seguridad

# prd2build (en Claude Code)
/prd2build prd.md         # Generar docs desde PRD
/prd2build prd.md --build # Generar docs + construir

# Pruebas
aqe-generate              # Generar tests
aqe-gate                  # Puerta de calidad

# Codex (opcional)
codex-run "tarea"         # Ejecutar con perfil Claude
codex-check               # Verificar configuración

# Estado
turbo-status              # Verificar todas las herramientas
turbo-help                # Referencia rápida
```

---

## Estructura del Proyecto

```
/workspaces/turbo-flow-claude/
├── src/                    # Código fuente
├── tests/                  # Archivos de pruebas
├── docs/                   # Documentación generada
├── plans/                  # Investigación y arquitectura
├── .claude-flow/           # Configuración de Claude Flow V3
├── .ruvector/              # Datos de hooks de RuVector
├── AGENTS.md               # Protocolo de colaboración Codex/Claude
└── CLAUDE.md               # Contexto del proyecto
```

---

## Pasos Manuales Después de la Instalación

1. **Extensión de Chrome para Playwriter**  
   https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe

2. **Codex (opcional)**
   ```bash
   npm install -g @openai/codex
   codex login
   ```

---

## Recursos

| Recurso | URL |
|---------|-----|
| RuVector | github.com/ruvnet/ruvector |
| RuVector npm | npmjs.com/package/ruvector |
| Claude Flow V3 | github.com/ruvnet/claude-flow |
| Turbo Flow Claude | github.com/marcuspat/turbo-flow-claude |
| Agentic QE | npmjs.com/package/agentic-qe |
| Playwriter | github.com/remorses/playwriter |
| HeroUI | heroui.com |
