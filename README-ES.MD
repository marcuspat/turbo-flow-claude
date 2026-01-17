# Turbo Flow Claude v2.0.0

**Entorno de desarrollo de agentes — Claude Flow V3**

---

## Arquitectura

```
┌───────────────────────────────────────────────────────────────────────────┐
│ TURBO FLOW v2.0.0 │
├───────────────────────────────────────────────────────────────────────────────┤
│ INTERFAZ: Claude Code (CLI) │ Navegador de desarrollo │ HeroUI │
├────────────────────────────────────────────────────────────────────────────────┤
│ ORQUESTACIÓN: Claude Flow V3 │
│ Más de 54 agentes nativos │ MCP unificado │ Trabajadores en segundo plano │
├──────────────────────────────────────────────────────────────────────────────┤
│ PRUEBAS: QE agéntico (19 agentes) │ Escritor (pruebas de IA) │
├────────────────────────────────────────────────────────────────────────────────┤
│ SEGURIDAD: Analizador de Seguridad │ Integración con Codex │
├───────────────────────────────────────────────────────────────────────────────────┤
│ ESPECIFICACIONES: Kit de especificaciones │ OpenSpec │
└──────────────────────────────────────────────────────────────────────────┘
```

---

## Inicio rápido

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

## Pila principal

| Herramienta | Alias ​​| Descripción |
|------|-------|-------------|
| Claude Code | `claude`, `dsp` | CLI de codificación de IA de Anthropic |
| Claude Flow V3 | `cf`, `cf-swarm` | Orquestación de agentes (más de 54 agentes) |
| Agentic QE | `aqe` | Canal de pruebas (19 agentes) |
| Playwriter | `playwriter` | La IA genera pruebas de Playwright |
| Dev-Browser | `devb-start` | Desarrollo visual con IA |
| Analizador de seguridad | — | Escaneo de vulnerabilidades (habilidad de Claude) |
| Spec-Kit | `sk` | Desarrollo basado en especificaciones |
| OpenSpec | `os` | Flujo de trabajo de especificaciones de Fission AI |
| Codex | `codex` | Agente de código de OpenAI (opcional) |

---

## Configuración de MCP

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

## Comandos de teclado

```bash
# Código de Claude
claude # Iniciar Claude
dsp # Omitir modo de permisos

# Claude Flow V3
cf-init # Inicializar espacio de trabajo
cf-swarm # Enjambre jerárquico
cf-mesh # Malla Enjambre
cf-agent <type> "task" # Ejecutar agente específico
cf-list # Listar agentes
cf-daemon # Iniciar demonio en segundo plano
cf-memory-status # Comprobar el sistema de memoria
cf-security # Análisis de seguridad

# prd2build (en código de Claude)
/prd2build prd.md # Generar documentación desde PRD
/prd2build prd.md --build # Generar documentación + compilación

# Pruebas
aqe-generate # Generar pruebas
aqe-gate # Control de calidad

# Codex (opcional)
codex-run "task" # Ejecutar con el perfil de Claude
codex-check # Comprobar el estado de la configuración

# Estado
turbo-status # Comprobar todas las herramientas
turbo-help # Referencia rápida
```

---

## Estructura del proyecto

```
/workspaces/turbo-flow-claude/
├── src/ # Fuente Código
├── tests/ # Archivos de prueba
├── docs/ # Documentación generada
├── plans/ # Investigación y arquitectura
├── .claude-flow/ # Configuración de Claude Flow V3
├── AGENTS.md # Protocolo de colaboración Codex/Claude
└── CLAUDE.md # Contexto del proyecto
```

---

## Pasos manuales después de la configuración

1. **Extensión de Chrome para Playwriter**
https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe

2. **Codex (opcional)**
```bash
npm install -g @openai/codex
codex login
```

---

## Recursos

| Recurso | URL | |----------|-----|
| Claude Flow V3 | github.com/ruvnet/claude-flow |
| Turbo Flow Claude | github.com/marcuspat/turbo-flow-claude |
| Agentic QE | npmjs.com/package/agentic-qe |
| Dramaturgo | github.com/remorses/playwriter |
| HeroUI | heroui.com |
