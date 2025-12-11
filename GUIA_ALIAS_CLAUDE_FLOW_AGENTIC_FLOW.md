# Guía de Alias de Claude Flow y Agentic Flow

Este documento proporciona una referencia completa para todos los alias de shell y funciones de utilidad configuradas para **Claude-Flow v2.5.0 Alpha 130** y **Agentic-Flow**. Estos atajos optimizan tu flujo de trabajo y hacen que interactuar con ambos frameworks sea más rápido e intuitivo.

**Nota de Rendimiento**: Claude-Flow v2.5.0 introduce una aceleración de 100-600x a través de la integración del SDK de Claude Code, bifurcación de sesiones y servidores MCP en proceso. Agentic-Flow agrega enrutamiento multi-modelo con hasta 99% de ahorro en costos.

---

## Tabla de Contenidos

- [Alias de Claude-Flow](#alias-de-claude-flow)
- [Alias de Agentic-Flow](#alias-de-agentic-flow)
- [Guía de Inicio Rápido](#guía-de-inicio-rápido)
- [Comparación de Despliegue](#comparación-de-despliegue)
- [Ejemplos de Optimización de Costos](#ejemplos-de-optimización-de-costos)

---

# Alias de Claude-Flow

## Comandos Principales

Comandos primarios para interactuar con Claude-Flow, envolviendo automáticamente las solicitudes con el contexto necesario.

| Alias | Comando | Descripción |
|-------|---------|-------------|
| `cf` | `./cf-with-context.sh` | Comando base. Ejecuta cualquier comando `claude-flow` con contexto auto-cargado (CLAUDE.md, CCFOREVER.md, agents). |
| `cf-swarm` | `./cf-with-context.sh swarm` | Inicia un enjambre de agentes en una tarea con contexto auto-cargado. |
| `cf-hive` | `./cf-with-context.sh hive-mind spawn` | Genera una sesión hive-mind para tareas complejas con contexto auto-cargado. |
| `cf-dsp` | `claude --dangerously-skip-permissions` | Atajo para Claude Code CLI, omitiendo solicitudes de permisos. |
| `dsp` | `claude --dangerously-skip-permissions` | Alias aún más corto para `cf-dsp`. |

**Ejemplo de Uso:**
```bash
cf swarm "Construir una API REST con autenticación"
cf-hive "Implementar arquitectura de microservicios empresariales"
dsp  # Acceso rápido a Claude Code sin permisos
```

---

## Operaciones de Hive-Mind

Para gestionar sesiones complejas multi-agente con memoria persistente.

| Alias | Comando | Descripción |
|-------|---------|-------------|
| `cf-spawn` | `npx claude-flow@alpha hive-mind spawn` | Genera una nueva sesión hive-mind. |
| `cf-wizard` | `npx claude-flow@alpha hive-mind wizard` | Inicia asistente interactivo para configurar una sesión hive-mind. |
| `cf-resume` | `npx claude-flow@alpha hive-mind resume` | Reanuda una sesión hive-mind previamente guardada. |
| `cf-status` | `npx claude-flow@alpha hive-mind status` | Verifica el estado de la sesión hive-mind actual. |

---

## Gestión de Memoria

Para interactuar con el sistema de memoria a largo plazo del agente basado en SQLite.

| Alias | Comando | Descripción |
|-------|---------|-------------|
| `cf-memory-stats` | `npx claude-flow@alpha memory stats` | Muestra estadísticas sobre uso de memoria. |
| `cf-memory-list` | `npx claude-flow@alpha memory list` | Lista todos los elementos en memoria. |
| `cf-memory-query` | `npx claude-flow@alpha memory query` | Consulta memoria con un término de búsqueda específico. |
| `cfm` | `cf-memory-stats` | Atajo rápido para estadísticas de memoria. |

---

# Alias de Agentic-Flow

## Comandos Principales

Comandos primarios para interactuar con Agentic-Flow y su sistema de envoltura de contexto.

| Alias | Comando | Descripción |
|-------|---------|-------------|
| `af` | `./af-with-context.sh` | Comando base. Ejecuta cualquier comando `agentic-flow` con contexto auto-cargado. |
| `agentic-flow` | `npx agentic-flow` | Acceso directo a CLI agentic-flow sin envoltura de contexto. |

---

## Optimización de Modelos

Comandos para selección inteligente de modelos y optimización de costos.

| Alias | Comando | Descripción |
|-------|---------|-------------|
| `af-optimize` | `npx agentic-flow --optimize` | Auto-selecciona el modelo óptimo para la tarea (calidad/costo equilibrados). |
| `af-optimize-cost` | `npx agentic-flow --optimize --priority cost` | Prioriza los modelos más económicos (99% de ahorro). |
| `af-optimize-quality` | `npx agentic-flow --optimize --priority quality` | Prioriza los modelos de mayor calidad. |
| `af-optimize-speed` | `npx agentic-flow --optimize --priority speed` | Prioriza los modelos de respuesta más rápida. |
| `af-optimize-privacy` | `npx agentic-flow --optimize --priority privacy` | Usa solo modelos ONNX locales (100% offline). |

**Prioridades de Optimización:**
- **quality**: 70% calidad, 20% velocidad, 10% costo
- **balanced**: 40% calidad, 40% costo, 20% velocidad (predeterminado)
- **cost**: 70% costo, 20% calidad, 10% velocidad
- **speed**: 70% velocidad, 20% calidad, 10% costo
- **privacy**: Solo local, cero llamadas a API en la nube

**Ejemplo de Uso:**
```bash
afo --agent coder --task "Construir API"  # Atajo para optimize
af-optimize-cost --agent tester --task "Escribir pruebas"
af-optimize-privacy --agent researcher --task "Analizar datos médicos"
```

---

## Selección de Proveedor

Comandos para seleccionar proveedores de modelos de IA específicos.

| Alias | Comando | Descripción |
|-------|---------|-------------|
| `af-openrouter` | `npx agentic-flow --model` | Usar modelos OpenRouter (99% de ahorro en costos). |
| `af-gemini` | `npx agentic-flow --provider gemini` | Usar modelos Google Gemini (98% de ahorro en costos). |
| `af-onnx` | `npx agentic-flow --provider onnx` | Usar modelos ONNX locales (100% gratis). |
| `af-anthropic` | `npx agentic-flow --provider anthropic` | Usar modelos Anthropic Claude (calidad premium). |

**Comparación de Proveedores:**
- **Anthropic**: $3-15 por 1M tokens, calidad premium
- **OpenRouter**: $0.06-0.55 por 1M tokens, 97-99% de ahorro
- **Gemini**: $0.075-1.25 por 1M tokens, 95-98% de ahorro
- **ONNX**: $0 (gratis), inferencia local, enfocado en privacidad

---

## Gestión de Servidores MCP

Comandos para gestionar servidores del Protocolo de Contexto de Modelo (MCP) (213 herramientas en total).

| Alias | Comando | Descripción |
|-------|---------|-------------|
| `af-mcp-start` | `npx agentic-flow mcp start` | Iniciar todos los servidores MCP (213 herramientas). |
| `af-mcp-stop` | `npx agentic-flow mcp stop` | Detener todos los servidores MCP. |
| `af-mcp-status` | `npx agentic-flow mcp status` | Verificar estado de servidores MCP. |
| `af-mcp-list` | `npx agentic-flow mcp list` | Listar todas las 213 herramientas MCP disponibles. |

**Servidores MCP Disponibles:**
- `claude-flow` - 101 herramientas (redes neuronales, GitHub, flujos de trabajo)
- `flow-nexus` - 96 herramientas (sandboxes en la nube, enjambres distribuidos)
- `agentic-payments` - 10 herramientas (autorización de pagos, firmas)
- `claude-flow-sdk` - 6 herramientas (memoria en proceso, coordinación)

---

## Tipos de Agentes (150+ Agentes)

### Agentes de Desarrollo Principal

| Alias | Comando | Descripción |
|-------|---------|-------------|
| `af-coder` | `npx agentic-flow --agent coder` | Especialista en implementación de código limpio y eficiente. |
| `af-reviewer` | `npx agentic-flow --agent reviewer` | Revisión de código y aseguramiento de calidad. |
| `af-tester` | `npx agentic-flow --agent tester` | Pruebas exhaustivas con 90%+ de cobertura. |
| `af-researcher` | `npx agentic-flow --agent researcher` | Investigación profunda y recopilación de información. |
| `af-planner` | `npx agentic-flow --agent planner` | Planificación estratégica y descomposición de tareas. |

### Agentes de Desarrollo Especializado

| Alias | Comando | Descripción |
|-------|---------|-------------|
| `af-backend` | `npx agentic-flow --agent backend-dev` | Desarrollo de API REST/GraphQL. |
| `af-mobile` | `npx agentic-flow --agent mobile-dev` | Aplicaciones móviles React Native. |
| `af-ml` | `npx agentic-flow --agent ml-developer` | Creación de modelos de aprendizaje automático. |
| `af-architect` | `npx agentic-flow --agent system-architect` | Diseño y arquitectura de sistemas. |

**Para ver todos los 150+ agentes**: `af-list`

---

## Comandos Rápidos

Alias de una letra y abreviados para operaciones comunes.

| Alias | Comando Base | Descripción |
|-------|--------------|-------------|
| `cfs` | `cf-swarm` | Atajo rápido para operaciones de enjambre. |
| `cfh` | `cf-hive` | Atajo rápido para generar hive-mind. |
| `cfm` | `cf-memory-stats` | Atajo rápido para estadísticas de memoria. |
| `afc` | `af-coder` | Atajo rápido para agente coder. |
| `afo` | `af-optimize` | Atajo rápido para optimización. |
| `afm` | `af-mcp-list` | Atajo rápido para lista de herramientas MCP. |

---

## Guía de Inicio Rápido

### 1. Instalación
```bash
# Ejecutar el script de configuración (instala Claude-Flow y Agentic-Flow)
./setup.sh

# Activar alias
source ~/.bashrc
```

### 2. Establecer Claves API
```bash
# Requerido para modelos Claude
export ANTHROPIC_API_KEY=sk-ant-...

# Opcional: Para 99% de ahorro en costos
export OPENROUTER_API_KEY=sk-or-v1-...

# Opcional: Para optimización de velocidad
export GOOGLE_GEMINI_API_KEY=xxxxx
```

### 3. Inicializar Claude-Flow
```bash
cf-init              # Inicializar entorno Claude-Flow
```

### 4. Iniciar Servidores MCP (Opcional)
```bash
af-mcp-start         # Inicia todas las 213 herramientas
```

### 5. Ejecuta tus Primeros Agentes

**Claude-Flow (Coordinación de Enjambre):**
```bash
# Enjambre simple
cfs "Construir API REST con autenticación"

# Hive-mind complejo
cf-wizard
cf-spawn "Construir sistema de microservicios empresariales"
```

**Agentic-Flow (Agentes Optimizados en Costo):**
```bash
# Ejecución básica
afc --task "Construir API REST" --stream

# Con optimización (recomendado)
af-optimize --agent coder --task "Construir API REST"

# Máximo ahorro en costos
af-cheap coder "Construir función simple"

# Modo privacidad (offline)
af-private researcher "Analizar datos sensibles"
```

---

## Ejemplos de Optimización de Costos

### Escenario 1: Sin Optimización (Siempre Claude Sonnet 4.5)
```bash
# 100 revisiones de código/día × $0.08 cada una = $8/día = $240/mes
npx agentic-flow --agent reviewer --task "Revisar PR"
```

### Escenario 2: Con Optimización (DeepSeek R1)
```bash
# 100 revisiones de código/día × $0.012 cada una = $1.20/día = $36/mes
# Ahorro: $204/mes (reducción del 85%)
af-optimize --agent reviewer --task "Revisar PR"
```

### Escenario 3: Máximo Ahorro (Llama 3.1 8B)
```bash
# 100 tareas simples/día × $0.001 cada una = $0.10/día = $3/mes
# Ahorro: $237/mes (reducción del 99%)
af-cheap tester "Escribir pruebas unitarias"
```

### Escenario 4: Costo Cero (ONNX Local)
```bash
# 100 tareas privadas/día × $0.00 cada una = $0/mes
# Ahorro: $240/mes (reducción del 100%)
af-private researcher "Analizar datos confidenciales"
```

---

## Comparación de Despliegue

| Característica | Claude-Flow | Agentic-Flow |
|----------------|-------------|--------------|
| **Uso Principal** | Coordinación de enjambre multi-agente | Agentes individuales optimizados en costo |
| **Herramientas MCP** | 213 (todos los servidores) | 213 (todos los servidores) |
| **Opciones de Modelo** | Solo Claude | Claude, OpenRouter, Gemini, ONNX |
| **Optimización de Costos** | ❌ No | ✅ Sí (hasta 99% de ahorro) |
| **Modo Privacidad** | ❌ No | ✅ Sí (ONNX local) |
| **Soporte de Enjambre** | ✅ Avanzado (hive-mind) | ✅ Básico (paralelo) |
| **Sistema de Memoria** | ✅ SQLite persistente | ✅ Memoria compartida |
| **Mejor Para** | Tareas complejas multi-agente | Flujos de trabajo sensibles al costo |

---

## Flujos de Trabajo Comunes

### Flujo de Trabajo 1: Desarrollo Optimizado en Costos
```bash
# Inicializar entorno
cf-init
af-mcp-start

# Tareas de desarrollo (modelos económicos)
af-cheap coder "Implementar CRUD de usuario"
af-cheap tester "Escribir pruebas unitarias"

# Revisión de código (modelo de calidad)
af-optimize --agent reviewer --task "Revisar seguridad" --priority quality

# Desplegar
cf-github-pr create "Nueva implementación de característica"
```

### Flujo de Trabajo 2: Análisis Enfocado en Privacidad
```bash
# Todo el procesamiento permanece local
af-private researcher "Analizar registros médicos de pacientes"
af-private coder "Procesar datos financieros confidenciales"
af-private tester "Probar algoritmos sensibles"
```

### Flujo de Trabajo 3: Sistema Multi-Agente Complejo
```bash
# Claude-Flow para coordinación
cf-wizard
cf-hive-topology mesh --agents 12
cf-spawn "Construir plataforma de microservicios distribuidos"

# Monitorear progreso
cf-hive-monitor
cfst  # Verificar estado
```

---

## Solución de Problemas

### Problema: Agente No Encontrado
```bash
# Listar todos los agentes disponibles
af-list              # Agentes Agentic-Flow
cfa                  # Agentes Claude-Flow
```

### Problema: Herramientas MCP No Funcionan
```bash
# Verificar estado del servidor MCP
af-mcp-status        # o cf-mcp-status

# Reiniciar servidores MCP
af-mcp-stop
af-mcp-start
```

### Problema: Altos Costos de API
```bash
# Habilitar optimización
af-optimize --agent coder --task "tu tarea"

# O usar prioridad de costo
af-cheap coder "tu tarea"

# O ir completamente offline
af-private coder "tu tarea"
```

---

## Recursos Adicionales

### Claude-Flow
- **Documentación**: https://github.com/ruvnet/claude-flow/wiki
- **GitHub**: https://github.com/ruvnet/claude-flow

### Agentic-Flow
- **GitHub**: https://github.com/ruvnet/agentic-flow
- **Paquete npm**: https://npmjs.com/package/agentic-flow

---

## Resumen

Esta guía cubre **todos los alias** del script `aliases.sh`:

**Claude-Flow (cf-*):**
- 80+ alias para coordinación de enjambre, operaciones hive-mind, gestión de memoria, y más
- 10 funciones de utilidad para flujos de trabajo avanzados

**Agentic-Flow (af-*):**
- 60+ alias para agentes optimizados en costo, enrutamiento multi-modelo, gestión MCP, y agentes especializados
- 10 funciones de utilidad para optimización de costos y privacidad

**Beneficios Clave:**
- **Claude-Flow**: Aceleración de rendimiento 100-600x, coordinación avanzada multi-agente
- **Agentic-Flow**: Hasta 99% de ahorro en costos, inferencia local enfocada en privacidad
- **Combinado**: Lo mejor de ambos mundos - coordinación rápida + optimización de costos

**Comenzar:**
```bash
source ~/.bashrc              # Activar todos los alias
cf-init                       # Inicializar Claude-Flow
af-mcp-start                  # Iniciar 213 herramientas MCP

# Claude-Flow: Coordinación compleja
cfs "Construir sistema distribuido"

# Agentic-Flow: Tareas optimizadas en costo
af-cheap coder "Construir API REST"

# Agentic-Flow: Enfoque en privacidad
af-private researcher "Analizar datos sensibles"
```
