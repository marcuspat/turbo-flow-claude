# 🚀 Turbo-Flow Claude v1.0.6 Alpha

**Entorno de Desarrollo Ágil Lean — Potenciado por RuvVector**  
*DevPods • GitHub Codespaces • Google Cloud Shell*

[![DevPod](https://img.shields.io/badge/DevPod-Listo-blue)](https://devpod.sh)
[![Claude Flow v3](https://img.shields.io/badge/Claude%20Flow-v3%20RuvVector-purple)](https://github.com/ruvnet/claude-flow)
[![Lean Stack](https://img.shields.io/badge/Stack-Lean%2060%25%20Más%20Pequeño-green)](https://github.com/marcuspat/turbo-flow-claude)
[![HeroUI](https://img.shields.io/badge/Frontend-HeroUI%20%2B%20Tailwind-cyan)](https://heroui.com)

---

## Novedades en v1.0.6

### 🧠 **Motor Neural RuvVector**
- ✅ **Claude Flow v3** - Reescritura completa con capacidades neurales de autoaprendizaje
- ✅ **Memoria Vectorial HNSW** - Recuperación de patrones 150x más rápida
- ✅ **Autoaprendizaje SONA** - Se adapta en <0.05ms, aprende de cada tarea
- ✅ **Memoria EWC++** - Previene el olvido catastrófico
- ✅ **54+ Agentes Nativos** - Ya no se necesitan bibliotecas de agentes externos
- ✅ **Multi-Proveedor Nativo** - OpenAI, Google, Ollama integrados (sin necesidad de claudish/PAL)

### 🎯 **Stack Lean (60% Más Pequeño)**
- ❌ **Eliminados**: claudish, PAL MCP, agtrace, n8n-mcp, chrome-devtools-mcp, @playwright/mcp
- ✅ **Un Solo MCP**: Claude Flow v3 maneja todo internamente
- ✅ **4 paquetes npm** en lugar de 12
- ✅ **2 registros MCP** en lugar de 5

### 🎨 **Nuevo Stack Frontend**
- ✅ **Playwriter** - IA genera pruebas Playwright desde lenguaje natural
- ✅ **Dev-Browser** - Entorno de desarrollo visual potenciado por IA
- ✅ **HeroUI + Tailwind** - Biblioteca de componentes moderna y accesible
- ✅ **Analizador de Seguridad** - MCP de escaneo de vulnerabilidades

---

## Arquitectura

```
┌─────────────────────────────────────────────────────────────────┐
│                    TURBO FLOW v1.0.6                            │
├─────────────────────────────────────────────────────────────────┤
│  CAPA DE INTERFAZ                                               │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐             │
│  │ Claude Code │  │ Dev-Browser │  │   HeroUI    │             │
│  │    (CLI)    │  │  (Visual)   │  │(Componentes)│             │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘             │
├─────────┴────────────────┴────────────────┴─────────────────────┤
│  ORQUESTACIÓN: Claude Flow v3 (Motor Neural RuvVector)          │
│  ┌────────────────────────────────────────────────────────────┐│
│  │  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐          ││
│  │  │  SONA   │ │  HNSW   │ │   MoE   │ │  EWC++ │          ││
│  │  │Aprende  │ │ Memoria │ │ Enrutam.│ │Sin Olvido│         ││
│  │  └─────────┘ └─────────┘ └─────────┘ └─────────┘          ││
│  │  54+ Agentes Nativos │ Enrutamiento Multi-Proveedor Nativo ││
│  │  MCP Único Unificado │ Workers en Segundo Plano (12 auto)  ││
│  └────────────────────────────────────────────────────────────┘│
├─────────────────────────────────────────────────────────────────┤
│  CAPA DE PRUEBAS                                                │
│  ┌───────────────────────┐  ┌───────────────────────┐          │
│  │      Agentic QE       │  │      Playwriter       │          │
│  │ (19 agentes, 11 TDD)  │  │(Generación IA pruebas)│          │
│  └───────────────────────┘  └───────────────────────┘          │
├─────────────────────────────────────────────────────────────────┤
│  CAPA DE SEGURIDAD                                              │
│  ┌───────────────────────┐  ┌───────────────────────┐          │
│  │ Analizador Seguridad  │  │    v3 AIDefence       │          │
│  │   (escaneo MCP)       │  │ (amenazas runtime)    │          │
│  └───────────────────────┘  └───────────────────────┘          │
├─────────────────────────────────────────────────────────────────┤
│  CAPA DE ESPECIFICACIONES                                       │
│  ┌───────────────────────┐  ┌───────────────────────┐          │
│  │       Spec-Kit        │  │       OpenSpec        │          │
│  └───────────────────────┘  └───────────────────────┘          │
└─────────────────────────────────────────────────────────────────┘
```

---

## ⚡ Inicio Rápido

### DevPod (Recomendado)

```bash
# Instalar DevPod
# macOS: brew install loft-sh/devpod/devpod 
# Windows: choco install devpod
# Linux: curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64" && sudo install devpod /usr/local/bin

# Lanzar espacio de trabajo
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

---

## 🛠️ Qué se Instala

### Stack Principal (Lean)

| Herramienta | Alias | Descripción |
|-------------|-------|-------------|
| Claude Code | `claude`, `dsp` | CLI de codificación IA de Anthropic |
| Claude Flow v3 | `cf`, `cf-swarm`, `cf-train` | Orquestación con RuvVector (54+ agentes, memoria HNSW) |
| Agentic QE | `aqe`, `aqe-generate` | Pipeline de pruebas de primera clase (19 agentes, 11 subagentes TDD) |
| AI Agent Skills | `skills-list` | 38+ habilidades instalables para Claude Code |

### Stack Frontend

| Herramienta | Alias | Descripción |
|-------------|-------|-------------|
| Playwriter | `pw-test` | IA genera pruebas Playwright desde lenguaje natural |
| Dev-Browser | `dev-browser` | Entorno de desarrollo visual potenciado por IA |
| HeroUI | (npm) | Biblioteca de componentes React moderna con Tailwind |
| Analizador de Seguridad | `sec-audit` | Escaneo de vulnerabilidades y auditorías de seguridad |

### Desarrollo Guiado por Especificaciones

| Herramienta | Alias | Descripción |
|-------------|-------|-------------|
| Spec-Kit | `sk`, `sk-here` | Desarrollo guiado por especificaciones de GitHub |
| OpenSpec | `os`, `os-init` | Flujo de especificaciones de Fission AI |

### Configuración MCP (Mínima)

Solo **2 servidores MCP** en lugar de 5:

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
    }
  }
}
```

El MCP unificado de Claude Flow v3 maneja Playwright, automatización de navegador y más de 170 herramientas internamente.

---

## 🎯 Flujos de Trabajo

### Claude Flow v3 (RuvVector)

```bash
# Inicializar un enjambre con topología jerárquica
cf-swarm

# Ejecutar agentes específicos
cf-agent coder --task "Implementar autenticación de usuario"
cf-agent tester --task "Escribir pruebas para módulo de auth"
cf-agent security-architect --task "Auditar vulnerabilidades"

# Entrenamiento de patrones neurales
cf-train                              # Entrenar desde código base
cf-pretrain --model-type moe          # Inicializar enrutamiento MoE

# Enrutamiento inteligente de tareas (aprende con el tiempo)
cf-route "optimizar consultas de base de datos"  # Enruta al mejor agente

# Verificar estado de implementación v3
cf-progress --detailed
```

### Generación de Pruebas con IA (Playwriter)

```bash
# Generar prueba Playwright desde descripción
pw-test "probar que el login falla con contraseña incorrecta"

# Salida: Archivo de prueba Playwright completo generado automáticamente

# Combinar con Agentic QE
aqe-generate                          # Generar suite de pruebas
aqe-gate                              # Verificación de calidad
aqe-flaky                             # Buscar pruebas inestables
```

### Desarrollo Visual (Dev-Browser)

```bash
# Lanzar entorno de desarrollo visual con IA
dev-browser

# Abre IDE en navegador con:
# - Vista previa en vivo
# - Asistencia de IA
# - Biblioteca de componentes HeroUI
```

### Flujo de Seguridad

```bash
# Escaneo completo de vulnerabilidades
security-scan

# Auditoría integrada con Claude Flow v3
sec-audit

# AIDefence de v3 maneja amenazas en tiempo de ejecución automáticamente
```

### Desarrollo Guiado por Especificaciones

```bash
# Inicializar especificaciones
sk-here                               # Spec-Kit
os-init                               # OpenSpec

# Seguir flujo de trabajo
/speckit.constitution                 # Definir principios
/speckit.specify                      # Escribir especificaciones
/speckit.plan                         # Planificar implementación
/speckit.implement                    # Construirlo
```

---

## 📋 Todos los Alias

### Claude Flow v3 (RuvVector)

```bash
# Principal
cf                        # Comando base
cf-init                   # Inicializar espacio de trabajo
cf-mcp                    # Iniciar servidor MCP
cf-status                 # Estado del sistema
cf-progress               # Progreso de implementación V3

# Enjambre y Agentes
cf-swarm                  # Iniciar enjambre jerárquico
cf-mesh                   # Iniciar topología mesh
cf-agent <tipo>           # Ejecutar agente específico
cf-coder                  # Agente programador
cf-reviewer               # Agente de revisión de código
cf-tester                 # Agente de pruebas
cf-security               # Arquitecto de seguridad
cf-list                   # Listar todos los 54+ agentes

# Neural (RuvVector)
cf-neural                 # Subsistema neural
cf-train                  # Entrenar patrones
cf-patterns               # Ver patrones aprendidos
cf-pretrain               # Inicializar inteligencia
cf-route "tarea"          # Enrutamiento inteligente
cf-memory                 # Buscar en memoria vectorial

# Workers y Hooks
cf-hooks                  # Sistema de hooks
cf-worker                 # Despachar worker en segundo plano
cf-daemon                 # Iniciar daemon en segundo plano

# Función rápida
cf-task coder "implementar X"  # Tarea rápida de agente
```

### Pruebas

```bash
# Agentic QE
aqe                       # Comando base
aqe-init                  # Inicializar
aqe-generate              # Generar pruebas
aqe-flaky                 # Buscar pruebas inestables
aqe-gate                  # Puerta de calidad

# Playwriter
playwriter                # Modo interactivo
pw-test "descripción"     # Generar prueba desde descripción
```

### Frontend

```bash
dev-browser               # Lanzar desarrollo visual
devb                      # Alias corto
security-scan             # Escaneo de vulnerabilidades
sec-audit                 # Auditoría de seguridad
```

### Especificaciones

```bash
# Spec-Kit
sk                        # CLI de Specify
sk-here                   # Iniciar en directorio actual
sk-check                  # Verificar instalación

# OpenSpec
os                        # CLI de OpenSpec
os-init                   # Inicializar
os-list                   # Listar cambios
os-validate               # Validar cambio
```

### Habilidades

```bash
skills                    # Comando base
skills-list               # Listar 38+ habilidades
skills-install <nombre>   # Instalar habilidad
```

### Funciones de Ayuda

```bash
turbo-init                # Inicializar espacio de trabajo completo
turbo-help                # Referencia rápida
turbo-status              # Verificar todas las herramientas
```

---

## 📁 Estructura del Proyecto

```
/workspaces/turbo-flow-claude/
├── src/                    # Código fuente
├── tests/                  # Archivos de prueba  
├── docs/                   # Documentación
├── scripts/                # Scripts de utilidad
├── config/                 # Configuración
├── devpods/                # Configuración DevPod
│   └── setup.sh            # Script principal de configuración (v10)
├── .claude-flow/           # Configuración de Claude Flow v3
├── .specify/               # Especificaciones de Spec-kit
├── openspec/               # Especificaciones de OpenSpec
├── package.json            # Node.js (módulos ES)
├── tsconfig.json           # Configuración de TypeScript
├── tailwind.config.js      # Configuración de Tailwind CSS
└── CLAUDE.md               # Contexto del proyecto generado
```

---

## 🔄 Migración desde v1.0.5

### Eliminados (No Requiere Acción)

Estos fueron eliminados para un stack más lean - Claude Flow v3 los maneja internamente:

| Eliminado | Reemplazo |
|-----------|-----------|
| `claudish` | Enrutamiento multi-proveedor nativo de v3 |
| `pal-mcp-server` | Enrutamiento multi-proveedor nativo de v3 |
| `agtrace` | Línea de estado + métricas de v3 |
| `n8n-mcp` | Integración MCP de v3 |
| `@playwright/mcp` | Automatización de navegador nativa de v3 |
| `chrome-devtools-mcp` | Automatización de navegador nativa de v3 |
| `610ClaudeSubagents` | v3 tiene 54+ agentes nativos |

### Comandos Actualizados

| v1.0.5 | v1.0.6 |
|--------|--------|
| `cf-hive` | `cf-swarm` |
| `cf-spawn` | `cf-agent <tipo>` |
| `claudish --model X` | Integrado en enrutamiento v3 |
| `agt-watch` | `cf-progress` |

### Nuevos Comandos

```bash
cf-train                  # Entrenamiento de patrones neurales
cf-route "tarea"          # Enrutamiento inteligente
cf-pretrain               # Inicializar inteligencia
pw-test "descripción"     # Generación de pruebas con IA
dev-browser               # Desarrollo visual
sec-audit                 # Auditoría de seguridad
```

---

## 📊 Comparación v1.0.5 vs v1.0.6

| Métrica | v1.0.5 | v1.0.6 | Cambio |
|---------|--------|--------|--------|
| Paquetes npm globales | 12 | 4 | **-67%** |
| Registros MCP | 5 | 2 | **-60%** |
| Clones Git | 2 | 3 | +50% (mejores herramientas) |
| Alias Bash | 50+ | 35 | **-30%** |
| Tiempo de configuración | ~120s | ~80s | **-33%** |
| Agentes nativos | 0 | 54+ | **+54** |
| Memoria vectorial | Ninguna | HNSW 150x | **Nuevo** |
| Autoaprendizaje | Ninguno | SONA <0.05ms | **Nuevo** |

---

## 🔧 Solución de Problemas

### Verificar Instalación

```bash
turbo-status              # Verificar todas las herramientas
```

### Problemas con Claude Flow v3

```bash
# Reinicializar
cf-init

# Verificar progreso
cf-progress --detailed

# Reentrenar patrones neurales
cf-pretrain
```

### Problemas con Playwriter

```bash
# Reinstalar
rm -rf ~/.playwriter
git clone https://github.com/remorses/playwriter ~/.playwriter
cd ~/.playwriter && npm install
```

### Problemas con Dev-Browser

```bash
# Reinstalar
rm -rf ~/.dev-browser
git clone https://github.com/SawyerHood/dev-browser ~/.dev-browser
cd ~/.dev-browser && npm install
```

### Node.js < 20

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-get install -y nodejs
```

---

## 📚 Recursos

### Principal
- [Claude Flow v3](https://github.com/ruvnet/claude-flow) - Motor neural RuvVector
- [Agentic QE](https://www.npmjs.com/package/agentic-qe) - Pipeline de pruebas

### Frontend
- [Playwriter](https://github.com/remorses/playwriter) - Generación de pruebas con IA
- [Dev-Browser](https://github.com/SawyerHood/dev-browser) - Desarrollo visual
- [HeroUI](https://heroui.com) - Biblioteca de componentes

### Seguridad
- [Security Analyzer](https://github.com/Cornjebus/security-analyzer) - Escaneo de vulnerabilidades

### Especificaciones
- [Spec-Kit](https://github.com/github/spec-kit) - Desarrollo guiado por especificaciones de GitHub
- [OpenSpec](https://github.com/Fission-AI/OpenSpec) - Flujo de especificaciones de Fission AI

### Habilidades
- [AI Agent Skills](https://github.com/skillcreatorai/Ai-Agent-Skills) - Repositorio universal de habilidades

---

## 📦 Resumen de Instalación

| Categoría | Cantidad |
|-----------|----------|
| Paquetes npm globales | 4 |
| Herramientas clonadas con Git | 3 |
| Herramientas Python (vía uv) | 1 |
| Registros MCP | 2 |
| Alias Bash | 35 |
| Paquetes Frontend | 4 |

### Lista Completa de Paquetes

**npm global:**
- @anthropic-ai/claude-code
- agentic-qe
- ai-agent-skills
- @fission-ai/openspec

**Clonados con Git:**
- playwriter (~/.playwriter)
- dev-browser (~/.dev-browser)
- security-analyzer (~/.security-analyzer)

**Python (vía uv):**
- specify-cli (spec-kit)

**Frontend (local):**
- @heroui/react
- framer-motion
- tailwindcss
- autoprefixer

---

## ¿Listo para empezar?

```bash
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

Luego:

```bash
source ~/.bashrc
turbo-help
claude
```

---

<p align="center">
  <b>Turbo Flow v1.0.6</b> — Lean, Rápido, Inteligente<br>
  Potenciado por el Motor Neural RuvVector
</p>
