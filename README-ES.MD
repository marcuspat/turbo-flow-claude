# 🚀 Turbo-Flow Claude v1.0.4 Alpha

**Entorno de Desarrollo Agéntico Avanzado**  
*DevPods • GitHub Codespaces • Google Cloud Shell*

[![DevPod](https://img.shields.io/badge/DevPod-Listo-blue)](https://devpod.sh)
[![Claude Flow](https://img.shields.io/badge/Claude%20Flow-Alpha-purple)](https://github.com/anthropics/claude-flow)
[![Agentes](https://img.shields.io/badge/Agentes-610+-green)](https://github.com/ChrisRoyse/610ClaudeSubagents)
[![Spec-Kit](https://img.shields.io/badge/Spec--Kit-Habilitado-orange)](https://github.com/github/spec-kit)

---

## Novedades en v1.0.4

- ✅ **Inicialización de Claude Flow Corregida** - Ahora se inicializa en el directorio de trabajo correcto (correcciones del script v7)
- ✅ **Claudish** - Utilidades de shell para Claude añadidas
- ✅ **Fiabilidad Mejorada** - Limpieza de caché npm síncrona, caché npx preservada, verificaciones con rutas absolutas
- ✅ **Mejor Reporte de Estado** - Muestra el estado real de inicialización con comandos de corrección si es necesario
- ✅ **Integración Spec-Kit** - Flujo de desarrollo basado en especificaciones de GitHub (comandos `/speckit.*`)
- ✅ **Habilidades de Agentes IA** - Más de 38 habilidades instalables para Claude Code vía `ai-agent-skills`
- ✅ **Servidor n8n-MCP** - Construye flujos de trabajo n8n con asistencia de IA
- ✅ **Servidor PAL MCP** - Orquestación de IA multi-modelo (Gemini + GPT + Grok + Ollama)
- ✅ **Arquitectura Basada en Habilidades** - Claude Code ahora usa habilidades; scripts wrapper eliminados
- ✅ **CLAUDE.md Dinámico** - Generado desde especificaciones en lugar de precargado

---

## ⚡ Inicio Rápido

### DevPod

```bash
# Instalar DevPod
# macOS: brew install loft-sh/devpod/devpod 
# Windows: choco install devpod
# Linux: curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64" && sudo install devpod /usr/local/bin

# Iniciar espacio de trabajo
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

### GitHub Codespaces

Ver [github_codespaces_setup.md](github_codespaces_setup.md)

### Google Cloud Shell

Ver [google_cloud_shell_setup.md](google_cloud_shell_setup.md)

---

## 🛠️ Qué Se Instala

### Herramientas Principales

| Herramienta | Alias | Descripción |
|-------------|-------|-------------|
| Claude Code | `claude`, `dsp` | CLI de codificación con IA de Anthropic |
| Claude Flow | `cf`, `cf-swarm`, `cf-hive` | Orquestación de IA con metodología SPARC |
| Agentic Flow | `af`, `af-run`, `af-coder` | Automatización de flujos de trabajo con agentes |
| Agentic QE | `aqe`, `aqe-mcp` | Framework de pruebas potenciado por IA |
| Agentic Jujutsu | `aj` | Asistente de operaciones Git |
| Claude Usage | `cu`, `claude-usage` | Seguimiento de uso de API |
| Claudish | - | Utilidades de shell para Claude |

### Nuevo en v1.0.4

| Herramienta | Alias | Descripción |
|-------------|-------|-------------|
| Spec-Kit | `sk`, `sk-init`, `sk-check`, `sk-here` | Desarrollo basado en especificaciones de GitHub |
| AI Agent Skills | `skills`, `skills-list`, `skills-search`, `skills-install`, `skills-info` | Más de 38 habilidades para Claude/Cursor/Codex |
| n8n-MCP | `n8n-mcp` | Automatización de flujos de trabajo n8n vía MCP |
| PAL MCP | `pal`, `pal-setup` | IA multi-modelo (Gemini, GPT, Grok, Ollama) |

### Servidores MCP (Auto-Configurados)

| Servidor | Alias | Descripción |
|----------|-------|-------------|
| Playwright MCP | `mcp-playwright` | Automatización de navegador |
| Chrome DevTools MCP | `mcp-chrome` | Integración con Chrome |
| n8n-MCP | `n8n-mcp` | Automatización de flujos de trabajo |
| PAL MCP | `pal` | Orquestación de IA multi-modelo |

### Recursos

- **Más de 610 Agentes IA** - Subagentes especializados para cualquier tarea
- **Configuración TypeScript** - Preconfigurado con `tsconfig.json`
- **Estructura de Proyecto** - `src/`, `tests/`, `docs/`, `scripts/`, `examples/`, `config/`

---

## 🎯 Flujo de Trabajo Recomendado

### Desarrollo Basado en Especificaciones

```bash
# 1. Inicializar spec-kit en tu proyecto
sk-here                              # o: specify init . --ai claude

# 2. Generar CLAUDE.md (contexto dinámico del proyecto)
./devpods/generate-claude-md.sh      # o: generate-claude-md

# 3. Iniciar Claude Code
claude

# 4. Seguir el flujo de trabajo de spec-kit
/speckit.constitution               # Definir principios del proyecto
/speckit.specify                    # Escribir especificaciones  
/speckit.plan                       # Crear plan de implementación
/speckit.tasks                      # Desglosar en tareas
/speckit.implement                  # ¡Construirlo!

# 5. Regenerar CLAUDE.md después de cambios en specs
generate-claude-md                   # Actualiza con las últimas specs
```

### Generación Dinámica de CLAUDE.md

El script `generate-claude-md.sh` crea un archivo `CLAUDE.md` optimizado analizando tu proyecto:

```bash
# Uso básico - genera CLAUDE.md en el directorio actual
./devpods/generate-claude-md.sh

# Ubicación de salida personalizada
./devpods/generate-claude-md.sh -o docs/CLAUDE.md

# Modo detallado - muestra vista previa del archivo generado
./devpods/generate-claude-md.sh -v

# Mostrar ayuda
./devpods/generate-claude-md.sh -h
```

**Qué detecta:**
- Especificaciones spec-kit (directorio `.specify/`)
- Tipo de proyecto (Node.js, Python, Rust, Go, etc.)
- Gestor de paquetes (npm, yarn, pnpm, uv, pip, cargo)
- Frameworks (React, Vue, Next.js, FastAPI, etc.)
- Scripts disponibles de package.json
- Estructura de directorios
- Configuración CI/CD
- Configuración de contenedores (Docker, DevContainer)
- Información del repositorio Git

**Secciones generadas:**
- Resumen del Proyecto (tabla con todos los atributos detectados)
- Especificaciones Spec-Kit (contenido completo de `.specify/`)
- Estructura del Proyecto (árbol de directorios)
- Scripts Disponibles (de package.json)
- Comandos de Desarrollo (específicos del gestor de paquetes)
- Guías de Codificación
- Instrucciones para Claude
- Herramientas MCP Disponibles

### IA Multi-Modelo con PAL

```bash
# Configurar PAL (solo la primera vez)
pal-setup                           # Instala dependencias

# Editar configuración de PAL con tus claves API
nano ~/.pal-mcp-server/.env

# Iniciar servidor PAL
pal

# Usar PAL para colaboración multi-modelo
# En Claude: "Usa pal para analizar esto con gemini pro y o3"
# En Claude: "Obtén consenso de múltiples modelos sobre este enfoque"
```

### Descubrimiento de Agentes

```bash
# Explorar habilidades disponibles
skills-list

# Instalar una habilidad
skills-install frontend-design

# Buscar habilidades
skills-search "code review"

# Obtener detalles de una habilidad
skills-info frontend-design
```

---

## 📋 Todos los Alias Disponibles

### Claude Code

```bash
claude                    # Iniciar Claude Code
claude-hierarchical       # claude --dangerously-skip-permissions
dsp                       # claude --dangerously-skip-permissions (corto)
```

### Claude Flow

```bash
cf                        # Comando base de Claude Flow
cf-init                   # Inicializar claude-flow (--force)
cf-swarm                  # Ejecutar modo enjambre
cf-hive                   # Generar agentes hive-mind
cf-spawn                  # Generar hive-mind (alias)
cf-status                 # Verificar estado de hive-mind
cf-help                   # Mostrar ayuda
cf-task "tarea"           # Tarea rápida de enjambre (función)
```

### Herramientas Agénticas

```bash
af                        # Agentic Flow
af-run                    # Ejecutar con agente
af-coder                  # Ejecutar agente programador
af-help                   # Ayuda de Agentic Flow
af-task "agente" "tarea"  # Tarea agéntica rápida (función)
aqe                       # Pruebas Agentic QE
aqe-mcp                   # Servidor MCP de Agentic QE
aj                        # Agentic Jujutsu (git)
cu                        # Estadísticas de uso de Claude
claude-usage              # Estadísticas de uso de Claude (completo)
```

### Spec-Kit

```bash
sk                        # CLI de Specify
sk-init                   # Inicializar nuevo proyecto
sk-check                  # Verificar herramientas instaladas
sk-here                   # Inicializar en directorio actual con Claude
```

### Habilidades de Agentes IA

```bash
skills                    # Comando base
skills-list               # Listar las más de 38 habilidades
skills-search "consulta"  # Buscar habilidades
skills-install <nombre>   # Instalar una habilidad
skills-info <nombre>      # Obtener detalles de habilidad
```

### Servidores MCP

```bash
n8n-mcp                   # MCP de flujos de trabajo n8n
pal                       # Iniciar servidor PAL MCP multi-modelo
pal-setup                 # Configurar dependencias de PAL (uv sync)
mcp-playwright            # MCP de Playwright
mcp-chrome                # MCP de Chrome DevTools
```

### Funciones Auxiliares

```bash
cf-task "tarea"           # Tarea rápida de enjambre
af-task "agente" "tarea"  # Tarea agéntica rápida con streaming
generate-claude-md        # Generar CLAUDE.md desde análisis del proyecto
```

### Script Generar CLAUDE.md

```bash
./devpods/generate-claude-md.sh           # Generar CLAUDE.md
./devpods/generate-claude-md.sh -v        # Modo detallado con vista previa
./devpods/generate-claude-md.sh -o ARCHIVO # Ruta de salida personalizada
./devpods/generate-claude-md.sh -h        # Mostrar ayuda
```

---

## 📁 Estructura del Proyecto

```
/workspaces/turbo-flow-claude/
├── agents/                 # Más de 610 definiciones de agentes IA
├── src/                    # Código fuente
├── tests/                  # Archivos de prueba
├── docs/                   # Documentación
├── scripts/                # Scripts de utilidad
├── examples/               # Código de ejemplo
├── config/                 # Archivos de configuración
├── devpods/                # Scripts de configuración DevPod
│   ├── setup.sh            # Script principal de configuración (v7)
│   └── generate-claude-md.sh  # Script generador de CLAUDE.md
├── .specify/               # Especificaciones spec-kit (después de sk-here)
├── .claude-flow/           # Configuración Claude Flow (después de cf-init)
├── package.json            # Configuración Node.js (módulos ES)
├── tsconfig.json           # Configuración TypeScript
└── CLAUDE.md               # Contexto del proyecto generado para Claude
```

---

## 🔧 Configuración

### PAL MCP (IA Multi-Modelo)

Editar `~/.pal-mcp-server/.env`:

```bash
GEMINI_API_KEY=tu-clave      # Google Gemini
OPENAI_API_KEY=tu-clave      # GPT-4, GPT-5, O3
OPENROUTER_API_KEY=tu-clave  # Más de 50 modelos
XAI_API_KEY=tu-clave         # Grok
ANTHROPIC_API_KEY=tu-clave   # Claude (para orquestación PAL)
```

### n8n-MCP

Para gestión de flujos de trabajo, establecer variables de entorno:

```bash
N8N_API_URL=https://tu-n8n.com
N8N_API_KEY=tu-clave-api
```

### Servidores MCP

Auto-configurados en `~/.config/claude/mcp.json`:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"]
    },
    "chrome-devtools": {
      "command": "npx",
      "args": ["chrome-devtools-mcp@latest"]
    },
    "chrome-mcp": {
      "type": "streamable-http",
      "url": "http://127.0.0.1:12306/mcp"
    },
    "n8n-mcp": {
      "command": "npx",
      "args": ["-y", "n8n-mcp"],
      "env": {
        "MCP_MODE": "stdio",
        "LOG_LEVEL": "error"
      }
    }
  }
}
```

---

## 🎛️ Gestión de DevPod

```bash
# Crear espacio de trabajo
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode

# Detener (ahorra costos)
devpod stop turbo-flow-claude

# Reanudar
devpod up turbo-flow-claude --ide vscode

# Eliminar
devpod delete turbo-flow-claude --force

# Listar espacios de trabajo
devpod list
```

---

## 🌍 Proveedores de Nube

### DigitalOcean (Recomendado)

```bash
devpod provider add digitalocean
devpod provider use digitalocean
devpod provider update digitalocean --option DIGITALOCEAN_ACCESS_TOKEN=tu_token
devpod provider update digitalocean --option DROPLET_SIZE=s-4vcpu-8gb
```

### AWS

```bash
devpod provider add aws
devpod provider use aws
devpod provider update aws --option AWS_INSTANCE_TYPE=t3.medium
```

### Otros Proveedores

Ver [devpod_provider_setup_guide.md](devpod_provider_setup_guide.md) para Azure, GCP, Rackspace y configuración local con Docker.

---

## 🔧 Solución de Problemas

### Verificar Instalación

```bash
# Verificar todas las herramientas
claude --version
specify check
skills-list
echo "Agentes: $(ls -1 agents/*.md 2>/dev/null | wc -l)"

# Verificar inicialización de Claude Flow
ls -la .claude-flow/ 2>/dev/null || echo "Claude Flow no inicializado"
```

### Claude Flow No Inicializado

Si el resumen de configuración muestra `❌ no inicializado` para Claude Flow:

```bash
cd $WORKSPACE_FOLDER && npx -y claude-flow@alpha init --force
```

### Spec-Kit No Encontrado

Si el comando `specify` no se encuentra:

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

### Problemas de Permisos

```bash
sudo chown -R $(whoami):staff ~/.devpod
```

### Recargar Alias

```bash
source ~/.bashrc
```

### Problemas de Bloqueo npm

```bash
rm -rf ~/.npm/_locks
```

---

## 📚 Recursos

- [Documentación de Spec-Kit](https://github.com/github/spec-kit) - Desarrollo basado en especificaciones
- [AI Agent Skills](https://github.com/anthropics/ai-agent-skills) - Repositorio universal de habilidades
- [n8n-MCP](https://github.com/n8n-io/n8n-mcp) - Automatización de flujos de trabajo n8n
- [PAL MCP Server](https://github.com/BeehiveInnovations/pal-mcp-server) - IA multi-modelo
- [Claude Flow](https://github.com/anthropics/claude-flow) - Orquestación de IA
- [610 Claude Subagents](https://github.com/ChrisRoyse/610ClaudeSubagents) - Biblioteca de agentes
- [Documentación de DevPod](https://devpod.sh/docs) - Entornos de desarrollo como código

---

## 📦 Historial de Versiones

### v1.0.4 Alpha (Actual)

- **Corregido** Inicialización de Claude Flow (directorio correcto, sin condiciones de carrera)
- **Añadido** Ayudante de shell Claudish
- **Añadido** Alias `pal-setup` para instalación de dependencias de PAL
- **Añadido** Alias `aqe-mcp` para servidor MCP de Agentic QE
- **Añadido** Alias `af-help` para ayuda de Agentic Flow
- **Añadido** `claude-hierarchical` como alias completo para `dsp`
- **Mejorado** Manejo de caché npm (síncrono, preserva caché npx)
- **Mejorado** Reporte de estado con estado real de inicialización
- **Mejorado** Mensajes de error con comandos de corrección manual

### v1.0.3 Alpha

- Añadido Spec-Kit para desarrollo basado en especificaciones
- Añadido AI Agent Skills (más de 38 habilidades)
- Añadido n8n-MCP para automatización de flujos de trabajo
- Añadido PAL MCP para IA multi-modelo
- Eliminados scripts wrapper (Claude Code está basado en habilidades)
- CLAUDE.md ahora se genera desde especificaciones
- Proceso de configuración optimizado de 14 pasos

### v1.0.2 Alpha

- Integración inicial de Claude Flow
- Más de 600 agentes IA
- Soporte de metodología SPARC

---

## 📊 Resumen de Instalación

El script de configuración instala:

| Categoría | Cantidad |
|-----------|----------|
| Paquetes npm globales | 11 |
| Paquetes npm locales de desarrollo | 2 |
| Herramientas Python | 2 |
| Herramientas de shell | 1 |
| Repositorios clonados con git | 2 |
| Habilidades de IA | 3 |
| Archivos de configuración creados | 4 |
| Directorios creados | 9 |
| Alias de Bash | 32 |
| Funciones auxiliares | 3 |
| Registros MCP | 4 |

### Lista Completa de Paquetes

**npm global:**
- @anthropic-ai/claude-code
- claude-usage-cli
- agentic-qe
- agentic-flow
- agentic-jujutsu
- claudish
- ai-agent-skills
- n8n-mcp
- @playwright/mcp
- chrome-devtools-mcp
- mcp-chrome-bridge

**Python (vía uv):**
- uv (gestor de paquetes)
- specify-cli (spec-kit)

**Shell:**
- direnv

**Clonados con git:**
- pal-mcp-server (~/.pal-mcp-server)
- 610ClaudeSubagents (agents/)

**Habilidades instaladas:**
- frontend-design
- mcp-builder
- code-review

---

## ⭐ Historial de Estrellas

[![Star History Chart](https://api.star-history.com/svg?repos=marcuspat/turbo-flow-claude&type=Date)](https://star-history.com/#marcuspat/turbo-flow-claude&Date)

---

## ¿Listo para empezar?

```bash
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```
