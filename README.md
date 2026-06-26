# Dotfiles (Home-based)

Este repositorio contiene mi configuración personal del sistema y aplicaciones, gestionada directamente dentro de mi carpeta de usuario (`$HOME`).

La idea es simple: el repositorio vive en el HOME, y los scripts aplican enlaces simbólicos o copias según archivos de mapeo.

---

## ⚙️ Concepto

Cada sistema se configura a partir de un archivo de mapeo con el formato:

```
action source -> destination
```

Ejemplo:

```
copy zed/settings.json -> %APPDATA%/Zed/settings.json
```

---

## 🧠 Filosofía

- El HOME es el repositorio.
- Todo lo importante se gestiona explícitamente.
- Solo se instala lo que está mapeado.
- Se permite personalización local según el tipo de acción (`link` o `copy`).

---

## 🚀 Instalación

### Linux

```bash
chmod +x ~/setup/scripts/install-linux.sh
~/setup/scripts/install-linux.sh
```

### Windows (PowerShell)

```powershell
.\setup\scripts\install-windows.ps1
```

---

## 🔁 Comportamiento del instalador

Cuando el destino ya existe:

- Si ya es el enlace correcto → se omite.
- Si es distinto → se pregunta si deseas reemplazarlo.
- Si eliges reemplazar → se sobrescribe.
- Si no → se mantiene intacto.

---

## 🧾 Ejemplo de mapeo (Windows)

```
copy zed/settings.json -> %APPDATA%/Zed/settings.json
link powershell/Microsoft.PowerShell_profile.ps1 -> %USERPROFILE%/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1
```

---

## 🪟 Windows vs Linux

Cada sistema tiene su propio archivo de mapeo:

- `setup/mappings/linux.map`
- `setup/mappings/windows.map`

Esto permite diferencias en rutas y configuraciones por sistema operativo.

---

## ⚠️ Notas importantes

- El repositorio debe clonarse directamente en `$HOME`.
- Evita incluir archivos sensibles sin cifrado o separación.
- En Windows, la creación de symlinks puede requerir permisos de administrador.

---

## 🚀 Clonación

### Linux

```bash
git clone https://github.com/JGCaceres97/dotfiles.git ~
```

### Windows (PowerShell)

```powershell
git clone https://github.com/JGCaceres97/dotfiles.git $HOME
```

---

## 🔧 Posibles mejoras futuras

- `--dry-run` para simulación
- backups automáticos con timestamp
- soporte de variables en mappings
- sincronización inversa (exportar configuración del sistema al repo)

---

## 🧩 Idea general

Este sistema busca ser:

> simple, explícito y completamente controlado por el usuario, sin dependencias externas.
