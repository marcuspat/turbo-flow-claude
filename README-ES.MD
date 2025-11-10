# 🚀 Turbo-Flow Claude v1.0.2 Alpha: 
# Entorno Avanzado de Desarrollo Agéntico

**¡Soporta Devpods, Github Codespaces, y más!**

**¡Presenta 600+ agentes de IA, Claude Flow, metodología SPARC, y carga automática de contexto!**


[![DevPod](https://img.shields.io/badge/DevPod-Listo-blue?style=flat-square)](https://devpod.sh) [![Claude Flow](https://img.shields.io/badge/Claude%20Flow-SPARC-purple?style=flat-square)](https://github.com/ruvnet/claude-flow) [![Agents](https://img.shields.io/badge/Agentes-600+-green?style=flat-square)](https://github.com/ChrisRoyse/610ClaudeSubagents)

---

## ⚡ Inicio Rápido Devpods

```bash
# 1. Instalar DevPod
# macOS: brew install loft-sh/devpod/devpod 
# Windows: choco install devpod
# Linux: curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64" && sudo install devpod /usr/local/bin

# 2. Configurar proveedor y configuración de Devpod.

# 3. Lanzar espacio de trabajo
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

¡Eso es todo! Ahora tienes un entorno de desarrollo en la nube listo para usar.

---

## ⚡ Inicio Rápido Codespaces

```bash

# 1. Crear un nuevo Codespace
# 2. Lanzar el Codespace en VS Code.
# 3. Subir el Script de Arranque de Codespace y Ejecutar el Script.

Ver el github_codespaces_setup.md en la raíz de este proyecto.
```
---

## ⚡ Inicio Rápido Google Cloud Shell

```bash

# 1. Lanzar Google Cloud Shell en Navegador o VS Code
# 2. Subir el Script de Arranque de Codespace y Ejecutar el Script.

Ver el google_cloud_shell_setup.md en la raíz de este proyecto.
```
---

## 🔧 La Magia: Carga Automática de Contexto

```bash
Después de la configuración, usa estos **comandos mejorados** que cargan automáticamente archivos de contexto:

### 🎯 **Comandos Principales**
```bash
cf-swarm "construir un juego de tic-tac-toe"    # Enjambre con contexto auto-cargado
cf-hive "crear una API REST"                     # Hive-mind con contexto auto-cargado  
cf "estadísticas de memoria"                     # Cualquier comando Claude Flow con contexto
dsp                                              # claude --dangerously-skip-permissions
```

### 🤖 **Lo Que Se Carga Automáticamente**
- **CLAUDE.md** - Reglas y patrones de desarrollo
- **doc-planner.md** - Agente de planificación (metodología SPARC)
- **microtask-breakdown.md** - Agente de descomposición de tareas
- **Biblioteca de Agentes** - Información sobre 600+ agentes disponibles

### 🔄 **Antes vs Después**
```bash
# ❌ FORMA ANTIGUA
(cat CLAUDE.md && cat agents/doc-planner.md && cat agents/microtask-breakdown.md) | npx claude-flow@alpha swarm "construir juego" --claude

# ✅ NUEVA FORMA
cf-swarm "construir juego"
```

---

## 🎯 Ejemplos de Uso

```bash
# 🎮 Desarrollo de juegos
cf-swarm "construir un tic-tac-toe multijugador con actualizaciones en tiempo real"

# 🌐 Desarrollo web  
cf-hive "crear un blog full-stack con autenticación y panel de administración"

# 🔍 Tareas de análisis
cf "analizar esta base de código y sugerir mejoras"

# 📊 Descubrimiento de agentes
cf-swarm "Primero descubrir agentes relevantes con 'find agents/ -name \"*game*\"' luego construir un juego de space invaders"
```

---

## 🌟 Lo Que Está Incluido

### 🔥 **Características Principales**
- **600+ Agentes de IA** - De [610ClaudeSubagents](https://github.com/ChrisRoyse/610ClaudeSubagents) + adiciones personalizadas
- **Metodología SPARC** - Flujo de trabajo de desarrollo sistemático
- **Carga Automática de Contexto** - No más piping manual de archivos
- **Integración Claude Flow** - Orquestación avanzada de IA
- **Integración Playwright** - Verificación visual para trabajo de UI
- **Monitoreo Avanzado** - Seguimiento de uso con [Claude Monitor](https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor)

### 🛠️ **Herramientas de Desarrollo**
- **Claude Code CLI** - Herramientas oficiales de desarrollo Claude
- **Docker-in-Docker** - Soporte para desarrollo de contenedores
- **Node.js y TypeScript** - Desarrollo JavaScript moderno
- **Playwright** - Pruebas automatizadas y capturas de pantalla
- **Espacio de Trabajo tmux** - Configuración de terminal de 4 ventanas

---

## 🚀 Opciones de Configuración

### 🎯 **Opción 1: Espacio de Trabajo Independiente (Recomendado)**
```bash
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```
Perfecto para nuevos proyectos o desarrollo dedicado de Claude.

### 🔄 **Opción 2: Agregar a Proyecto Existente**
```bash
# Clonar configuración
git clone https://github.com/marcuspat/turbo-flow-claude claude-config

# Copiar a tu proyecto
cp -r claude-config/.devcontainer ./
cp -r claude-config/devpods ./

# Lanzar
devpod up . --ide vscode
```

---

## 🌍 Configuración de Proveedor en la Nube

Elige tu proveedor en la nube preferido:

### 🌊 **DigitalOcean (Recomendado)**
```bash
devpod provider add digitalocean
devpod provider use digitalocean
devpod provider update digitalocean --option DIGITALOCEAN_ACCESS_TOKEN=tu_token
devpod provider update digitalocean --option DROPLET_SIZE=s-4vcpu-8gb  # $48/mes
```

### ☁️ **AWS**
```bash
devpod provider add aws
devpod provider use aws
devpod provider update aws --option AWS_INSTANCE_TYPE=t3.medium  # $30/mes
```

### 🔵 **Azure** | 🌥️ **GCP** | 🏢 **Rackspace** | 🖥️ **Docker Local**
📋 ¿Necesitas instrucciones de configuración? Consulta nuestra Guía Completa de Proveedores DevPod para pasos de configuración detallados.
[**📖 Guía de Configuración**](https://github.com/marcuspat/turbo-flow-claude/blob/main/devpod_provider_setup_guide.md)

---

## 🖥️ Qué Sucede Después de la Configuración

### 🔄 **Instalación Automática**
- Instala Claude Code, Claude Flow, y 600+ agentes
- Configura espacio de trabajo tmux con 4 ventanas
- Configura carga automática de contexto
- Instala herramientas de desarrollo (Playwright, TypeScript, etc.)

### 🖥️ **Espacio de Trabajo tmux**
- **Ventana 0**: Espacio de trabajo principal de Claude
- **Ventana 1**: Espacio de trabajo secundario de Claude
- **Ventana 2**: Monitor de uso de Claude
- **Ventana 3**: Monitor del sistema (htop)

Acceder con: `tmux attach -t workspace`

---

## 🎯 Ejemplos Completos de Prompting

### 🌟 **Patrón Maestro**
Siempre incluye esto para máxima efectividad:
```
"Identifica todos los subagentes que podrían ser útiles para esta tarea y utiliza el hivemind de claude-flow para maximizar tu capacidad de cumplir la tarea."
```

### 🚀 **Desarrollo Completo de Proyecto**
```
"Necesito construir una API REST para una aplicación de tareas pendientes. Busca en agents/ y:
1. Identifica todos los subagentes útiles para esta tarea
2. Crea un plan de desarrollo completo con visualizaciones
3. Utiliza el hivemind de claude-flow para maximizar nuestra capacidad
4. Encadena agentes para planificación, implementación, pruebas, despliegue"
```

### 🏗️ **Proyecto de Infraestructura**
```
"Investiga usando Kubernetes para desplegar servicios LLM. Pon la salida en la carpeta research/.
- Extrae de transcripciones de YouTube, repositorios GitHub, publicaciones de blog
- Genera 5 agentes para trabajar concurrentemente
- Sigue iterando hasta que exista una ruta de implementación clara"
```

---

## 📁 Estructura de Archivos

Después de la configuración:
```
/workspaces/turbo-flow-claude/
├── 🤖 agents/              # 600+ agentes de IA
├── 📋 CLAUDE.md            # Reglas de desarrollo
├── 📋 FEEDCLAUDE.md        # Instrucciones simplificadas
├── ⚡ claude-flow          # Herramientas de flujo de trabajo SPARC
├── 🔧 cf-with-context.sh   # Envoltura de carga de contexto
└── 📁 [tus archivos de proyecto]
```

---

## 🎛️ Comandos de Gestión

```bash
# Crear/eliminar espacio de trabajo
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
devpod delete turbo-flow-claude --force

# Iniciar/detener (ahorra dinero)
devpod stop turbo-flow-claude      # Detener facturación
devpod up turbo-flow-claude --ide vscode  # Reanudar

# Listar espacios de trabajo
devpod list
```

---

## 🔧 Solución de Problemas

### 🔐 **Problemas de Permisos**
```bash
sudo chown -R $(whoami):staff ~/.devpod && \
find ~/.devpod -type d -exec chmod 755 {} \; && \
find ~/.devpod -name "*provider*" -type f -exec chmod +x {} \;
```

### 🔗 **Problemas de Conexión**
```bash
killall "Code"  # Cerrar VSCode
devpod up turbo-flow-claude --ide vscode  # Reintentar
```

### ✅ **Verificar Instalación**
```bash
echo "Agentes: $(ls -1 /workspaces/turbo-flow-claude/agents/*.md 2>/dev/null | wc -l)"
echo "Claude-code: $(which claude && echo '✓' || echo '✗')"
echo "Claude-monitor: $(which claude-monitor && echo '✓' || echo '✗')"
```

---

## 📚 Recursos y Documentación

- [Documentación DevPod](https://devpod.sh/docs) - Entornos-de-Desarrollo-Como-Código de Código Abierto
- [Claude Flow SPARC](https://github.com/ruvnet/claude-flow) - plataforma de orquestación de IA de nivel empresarial por Reuven Cohen
- [610ClaudeSubagents](https://github.com/ChrisRoyse/610ClaudeSubagents) - Subagentes por Christopher Royse
- [Claude Monitor](https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor) - Claude Monitor por Maciek-roboblog
- [Guía de Alias de Turbo Flow](https://github.com/marcuspat/turbo-flow-claude/blob/main/claude-flow-aliases-guide.md) - Alias en Turbo Flow
- [Guía de Configuración de Github Codespaces](https://github.com/marcuspat/turbo-flow-claude/blob/main/github_codespaces_setup.md) - Configuración para Github CodeSpaces 
- [Guía de Configuración de Google Cloud Shell](https://github.com/marcuspat/turbo-flow-claude/blob/main/google_cloud_shell_setup.md) - Configuración para Google Cloud Shell
- [Guía de Configuración de Rackspace Spot](https://github.com/marcuspat/turbo-flow-claude/blob/main/spot_rackspace_setup_guide.md) - Configuración para Rackspace Spot


---

## 📦 Configuración Detallada de Proveedores

<details>
<summary>Haz clic para expandir las instrucciones completas de configuración de proveedores</summary>

### 🌊 **Proveedor DigitalOcean**
1. Regístrate en [DigitalOcean](https://www.digitalocean.com/)
2. Genera token API con permisos de lectura/escritura
3. Configurar:
```bash
devpod provider add digitalocean
devpod provider use digitalocean
devpod provider update digitalocean --option DIGITALOCEAN_ACCESS_TOKEN=tu_token
devpod provider update digitalocean --option DROPLET_SIZE=s-4vcpu-8gb
```

### ☁️ **Proveedor AWS**
```bash
pip install awscli
aws configure
devpod provider add aws
devpod provider use aws
devpod provider update aws --option AWS_INSTANCE_TYPE=t3.medium
devpod provider update aws --option AWS_REGION=us-east-1
```

### 🔵 **Proveedor Azure**
```bash
brew install azure-cli  # macOS
az login
devpod provider add azure
devpod provider use azure
devpod provider update azure --option AZURE_VM_SIZE=Standard_B2s
devpod provider update azure --option AZURE_LOCATION=eastus
```

### 🌥️ **Proveedor Google Cloud**
```bash
curl https://sdk.cloud.google.com | bash
gcloud auth login
devpod provider add gcp
devpod provider use gcp
devpod provider update gcp --option GOOGLE_PROJECT_ID=tu-proyecto
devpod provider update gcp --option GOOGLE_MACHINE_TYPE=e2-medium
```

### 🖥️ **Proveedor Docker Local**
```bash
devpod provider add docker
devpod provider use docker
# No se necesita configuración adicional
```

</details>

---

🎯 **¿Listo para potenciar tu desarrollo con 600+ agentes de IA?**

```bash
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

## Historial de Estrellas

[![Gráfico de Historial de Estrellas](https://api.star-history.com/svg?repos=marcuspat/turbo-flow-claude&type=Date)](https://www.star-history.com/#marcuspat/turbo-flow-claude&Date)
