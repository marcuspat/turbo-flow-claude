# 🚀 Guías de Configuración de Turbo Flow
## Configuración para Múltiples Entornos

---

## Tabla de Contenidos

1. [Configuración para Google Cloud Shell](#-configuración-para-google-cloud-shell)
2. [Configuración para GitHub Codespaces](#-configuración-para-github-codespaces)
3. [Configuración Rápida para macOS/Linux](#-configuración-rápida-para-macoslinux)
4. [Lo Que Se Instala](#-lo-que-se-instala)
5. [Comandos Disponibles](#-comandos-disponibles)
6. [Espacio de Trabajo Tmux](#-espacio-de-trabajo-tmux)
7. [Prueba Rápida](#-prueba-rápida)
8. [Solución de Problemas](#-solución-de-problemas)

---

# ☁️ Configuración para Google Cloud Shell

## ⚡ Método de Configuración Rápida

Después de que Google Cloud Shell se inicie, ejecuta este comando:
```bash
touch boot.sh && chmod +x boot.sh && vi boot.sh
```

Luego pega el script a continuación y ejecútalo para terminar de configurar Turbo Flow en Google Cloud Shell:

```bash
#!/bin/bash
# Clonar el repositorio
echo "Clonando repositorio..."
git clone https://github.com/marcuspat/turbo-flow-claude.git

# Verificar si la clonación fue exitosa
if [ $? -ne 0 ]; then
    echo "Error: Falló al clonar repositorio"
    exit 1
fi

# Navegar al directorio clonado
cd turbo-flow-claude

# Mover directorio devpods al directorio padre
echo "Moviendo directorio devpods..."
mv devpods ..

# Regresar al directorio padre
cd ..

# Eliminar el repositorio clonado
echo "Eliminando directorio turbo-flow-claude..."
rm -rf turbo-flow-claude

# Hacer ejecutables todos los scripts shell en devpods
echo "Haciendo scripts ejecutables..."
chmod +x ./devpods/*.sh

# Ejecutar el script de configuración
echo "Ejecutando codespace_setup.sh..."
./devpods/codespace_setup.sh

echo "¡Script completado!"
```

### Pasos de Instalación

1. **Copia el script de arranque** en tu Google Cloud Shell
2. **Ejecuta**: `bash boot.sh`
3. **Espera** a que la instalación se complete (~5-10 minutos)
4. **Conéctate al espacio de trabajo tmux**: `tmux attach -t workspace`

---

# 💻 Configuración para GitHub Codespaces

## ⚡ Método de Configuración Rápida

Después de que el codespace se inicie, ejecuta este comando:
```bash
touch boot.sh && chmod +x boot.sh && vi boot.sh
```

Luego pega el script a continuación y ejecútalo para terminar de configurar Turbo Flow en GitHub Codespaces:

```bash
#!/bin/bash
# Clonar el repositorio
echo "Clonando repositorio..."
git clone https://github.com/marcuspat/turbo-flow-claude.git

# Verificar si la clonación fue exitosa
if [ $? -ne 0 ]; then
    echo "Error: Falló al clonar repositorio"
    exit 1
fi

# Navegar al directorio clonado
cd turbo-flow-claude

# Mover directorio devpods al directorio padre
echo "Moviendo directorio devpods..."
mv devpods ..

# Regresar al directorio padre
cd ..

# Eliminar el repositorio clonado
echo "Eliminando directorio turbo-flow-claude..."
rm -rf turbo-flow-claude

# Hacer ejecutables todos los scripts shell en devpods
echo "Haciendo scripts ejecutables..."
chmod +x ./devpods/*.sh

# Ejecutar el script de configuración
echo "Ejecutando codespace_setup.sh..."
./devpods/codespace_setup.sh

echo "¡Script completado!"
```

### Pasos de Instalación

1. **Crea un nuevo Codespace** desde tu repositorio
2. **Copia el script de arranque** en la terminal del codespace
3. **Ejecuta**: `bash boot.sh`
4. **Espera** a que la instalación se complete (~5-10 minutos)
5. **Conéctate al espacio de trabajo tmux**: `tmux attach -t workspace`

### Opción: Usar Dev Container

Alternativamente, puedes usar la configuración de devcontainer incluida:

1. **Agrega `.devcontainer/devcontainer.json`** a tu repositorio
2. **Abre en Codespace** - se configurará automáticamente
3. **Espera** a que se complete la configuración del contenedor
4. **Comienza a trabajar** - todo estará preconfigurado

---

# 🖥️ Configuración Rápida para macOS/Linux

## Instalación Local

Para configuración local en tu máquina macOS o Linux:

### 1. Clonar el Repositorio
```bash
git clone https://github.com/marcuspat/turbo-flow-claude.git
```

### 2. Ejecutar el Instalador

Navega al directorio `devpods`:
```bash
cd turbo-flow-claude/devpods
```

Haz los scripts de arranque ejecutables (solo necesitas hacer esto una vez):
```bash
chmod +x boot_macosx.sh boot_linux.sh
```

Ejecuta el script correcto para tu sistema operativo:

**En 🍎 macOS:**
```bash
./boot_macosx.sh
```

**En 🐧 Linux:**
```bash
./boot_linux.sh
```

### 3. Después de Que el Script Termine

El script de instalación termina lanzándote directamente a una **sesión TMux** llamada `workspace`. Tmux es un multiplexor de terminal que te permite ejecutar y gestionar múltiples ventanas de terminal dentro de una sola sesión.

---

## 📁 Lo Que Se Instala

```
tu-proyecto/
├── devpods/                    # Scripts de configuración
├── agents/                     # Biblioteca de agentes IA
├── cf-with-context.sh         # Envoltura de contexto
├── CLAUDE.md                  # Reglas de desarrollo Claude
├── FEEDCLAUDE.md              # Instrucciones simplificadas
└── [archivos del proyecto]    # Tu entorno configurado
```

### Componentes Instalados

✅ **Node.js** (última LTS)  
✅ **Claude Code CLI** (claude)  
✅ **Claude Monitor** (seguimiento de uso)  
✅ **Claude-Flow v2.5.0 Alpha 130**  
✅ **Agentic-Flow** (última versión)  
✅ **612 Agentes IA** (biblioteca completa)  
✅ **Scripts de Envoltura de Contexto**  
✅ **Todos los Alias de Shell**  
✅ **Playwright** para pruebas  
✅ **TypeScript** configurado  
✅ **Configuración de Tmux**  

---

## 🎯 Comandos Disponibles

### Comandos Claude-Flow
```bash
cf "cualquier tarea"           # Coordinación IA general
cf-swarm "construir función"   # Implementación enfocada
cf-hive "planificación compleja" # Coordinación multi-agente
claude-monitor                 # Seguimiento de uso
```

### Comandos Agentic-Flow
```bash
af-optimize "tarea"            # Optimización automática de modelo
af-cheap "tarea"               # Máximo ahorro de costos (99%)
af-private "tarea"             # Modo privacidad (offline)
af-mcp-start                   # Iniciar servidores MCP (213 herramientas)
```

### Comandos Rápidos
```bash
cfs "tarea"                    # Enjambre rápido
cfh "tarea"                    # Hive-mind rápido
afc --task "tarea"             # Codificador rápido
afo --task "tarea"             # Optimización rápida
```

---

## 🖥️ Espacio de Trabajo Tmux

### Conectarse Después de la Configuración
```bash
tmux attach -t workspace
```

### Configuración de Ventanas

Tu sesión `tmux` está preconfigurada con las siguientes ventanas:

- **Ventana 0: `Claude-1`** - Espacio de trabajo principal
- **Ventana 1: `Claude-2`** - Espacio de trabajo secundario
- **Ventana 2: `Claude-Monitor`** - Ejecuta `claude-monitor`
- **Ventana 3: `htop`** - Monitor del sistema

### Comandos Básicos de Tmux

| Acción | Comando |
|--------|---------|
| **Cambiar Ventanas** | `Ctrl+b` luego `0-3` |
| **Siguiente Ventana** | `Ctrl+b` luego `n` |
| **Ventana Anterior** | `Ctrl+b` luego `p` |
| **Separar Sesión** | `Ctrl+b` luego `d` |
| **Reconectar** | `tmux a -t workspace` |
| **Ayuda** | `Ctrl+b` luego `?` |

### Navegación

- **Cambiar a ventana específica**: Presiona `Ctrl+b`, suelta, luego presiona el número de ventana (ej., `0`, `1`, `2`)
- **Siguiente ventana**: Presiona `Ctrl+b`, suelta, luego presiona `n` (para siguiente)
- **Separar (Dejar sesión ejecutándose)**: Presiona `Ctrl+b`, suelta, luego presiona `d` (para separar)
- **Reconectar**: Desde tu terminal normal, escribe `tmux a -t workspace` para volver a tu sesión

---

## 💡 Prueba Rápida

```bash
# Después de la configuración y conectar a tmux:
source ~/.bashrc
cf "¡Hola! Muéstrame los agentes disponibles"
```

### Pruebas de Ejemplo

**Probar Claude-Flow:**
```bash
cf-swarm "Construir una API REST simple con autenticación"
```

**Probar Agentic-Flow (Optimizado en Costos):**
```bash
af-optimize --agent coder --task "Crear función CRUD para usuarios"
```

**Probar Modo Privacidad (Offline):**
```bash
af-private researcher "Analizar datos de muestra"
```

---

## ⚠️ Solución de Problemas

### No Puede Conectar a Tmux
```bash
tmux list-sessions

# Si falta, ejecutar:
./devpods/tmux-workspace.sh
tmux attach -t workspace
```

### Comandos No Encontrados
```bash
source ~/.bashrc
```

### Alias No Funcionan
```bash
# Recargar alias
source ~/.bashrc

# Verificar si los alias están cargados
alias | grep cf-
alias | grep af-
```

### Scripts No Ejecutables
```bash
chmod +x ./devpods/*.sh
```

### Node.js No Instalado
```bash
# macOS
brew install node

# Linux (Ubuntu/Debian)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### Claude Code No Funciona
```bash
# Reinstalar Claude Code CLI
npm install -g @anthropic-ai/claude-code

# Verificar instalación
claude --version
```

### Servidores MCP No Inician
```bash
# Verificar estado
af-mcp-status

# Reiniciar servidores
af-mcp-stop
af-mcp-start
```

### Memoria SQLite Corrupta
```bash
# Exportar y reimportar memoria
cf-memory-export backup.db
cf-memory-clear
cf-memory-import backup.db
```

---

## 🎉 ¡Estás Listo!

### Flujo de Trabajo Recomendado

1. **Configuración**: Usa devcontainer O ejecuta `boot.sh`
2. **Conectar**: `tmux attach -t workspace`  
3. **Construir**: `cf-swarm "Ayúdame a construir mi app"`

### Características

✅ Entorno de desarrollo IA completo  
✅ Biblioteca extensa de agentes  
✅ Herramientas de monitoreo  
✅ Espacio de trabajo tmux de 4 ventanas  
✅ Optimización de costos (hasta 99% de ahorro)  
✅ Modo privacidad (inferencia local)  
✅ 213 herramientas MCP  
✅ Coordinación multi-agente  

### Siguientes Pasos

1. **Explorar Agentes**: `af-list` o `cfa`
2. **Iniciar Proyecto**: `cf-swarm "Mi primera tarea"`
3. **Optimizar Costos**: `af-optimize --agent coder --task "Mi tarea"`
4. **Monitorear Uso**: Verificar ventana `Claude-Monitor` en tmux
5. **Leer Documentación**: Revisar `CLAUDE.md` y `FEEDCLAUDE.md`

---

## 📚 Recursos Adicionales

### Documentación
- **Claude-Flow**: https://github.com/ruvnet/claude-flow/wiki
- **Agentic-Flow**: https://github.com/ruvnet/agentic-flow
- **Turbo-Flow-Claude**: https://github.com/marcuspat/turbo-flow-claude

### Guías
- **Guía de Alias**: Ver `GUIA_ALIAS_CLAUDE_FLOW_AGENTIC_FLOW.md`
- **Guía DevPod**: Ver `GUIA_COMPLETA_DEVPOD_RACKSPACE.md`
- **Guía K8s**: Ver `GUIA_SUPERVIVENCIA_RACKSPACE_KUBERNETES.md`

### Soporte
- **GitHub Issues**: https://github.com/marcuspat/turbo-flow-claude/issues
- **Discusiones**: https://github.com/marcuspat/turbo-flow-claude/discussions

---

## 💰 Ahorro de Costos

### Sin Optimización
- **Claude Sonnet 4.5**: $0.08 por tarea
- **100 tareas/día**: $8/día = **$240/mes**

### Con Optimización (af-optimize)
- **DeepSeek R1**: $0.012 por tarea
- **100 tareas/día**: $1.20/día = **$36/mes**
- **Ahorro**: $204/mes (85%)

### Máximo Ahorro (af-cheap)
- **Llama 3.1 8B**: $0.001 por tarea
- **100 tareas/día**: $0.10/día = **$3/mes**
- **Ahorro**: $237/mes (99%)

### Costo Cero (af-private)
- **ONNX Local**: $0.00 por tarea
- **100 tareas/día**: $0/día = **$0/mes**
- **Ahorro**: $240/mes (100%)

---

## 🔐 Modo Privacidad

### Características

- ✅ **100% Local** - Sin llamadas a API en la nube
- ✅ **GDPR/HIPAA Compliant** - Datos nunca salen de tu máquina
- ✅ **Costo Cero** - Sin cargos API
- ✅ **Inferencia Rápida** - 6-300 tokens/seg

### Uso

```bash
# Analizar datos sensibles
af-private researcher "Analizar registros médicos de pacientes"

# Procesar información confidencial
af-private coder "Procesar datos financieros de clientes"

# Probar en privacidad
af-private tester "Ejecutar pruebas en datos privados"
```

---

## 🚀 Características de Rendimiento

### Claude-Flow (v2.5.0)
- **Bifurcación de Sesión**: 10-20x generación más rápida de agentes paralelos
- **Emparejadores de Hooks**: 2-3x ejecución más rápida de hooks selectivos
- **MCP en Proceso**: 50-100x llamadas más rápidas de herramientas
- **Aceleración Combinada**: Ganancia potencial de 100-600x

### Agentic-Flow
- **Selección de Modelo**: <100ms sobrecarga
- **ONNX Local**: 6-300 tokens/seg
- **APIs en la Nube**: 1-3s primer token
- **Optimización**: Enrutamiento inteligente automático

---

**¡Recuerda!** Siempre trabaja dentro de tmux para la mejor experiencia. Todos tus nuevos alias (como `dsp`, `cf-swarm`, `cfs`, etc.) ahora están activos y listos para usar *dentro* de esta sesión `tmux`.

---

## 📝 Notas de Versión

**Turbo Flow Claude**
- Versión: 1.0.0
- Última actualización: Agosto 2025

**Claude-Flow**
- Versión: 2.5.0 Alpha 130
- Características: Bifurcación de sesión, MCP en proceso, SAFLA, GOAP

**Agentic-Flow**
- Versión: Última
- Características: Optimización multi-modelo, modo privacidad, 150+ agentes

---

## 🎯 Inicio Rápido de 5 Minutos

```bash
# 1. Clonar e instalar (1 minuto)
git clone https://github.com/marcuspat/turbo-flow-claude.git
cd turbo-flow-claude/devpods
./boot_linux.sh  # o boot_macosx.sh

# 2. Conectar a tmux (10 segundos)
tmux attach -t workspace

# 3. Activar alias (5 segundos)
source ~/.bashrc

# 4. Iniciar servidores MCP (30 segundos)
af-mcp-start

# 5. Ejecutar primera tarea (1-2 minutos)
cf-swarm "Construir una API REST simple"

# ¡Total: ~5 minutos hasta el primer resultado!
```

---

**¡Feliz Codificación con IA!** 🤖✨
