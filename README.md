# SolGraphX

## Descripción
SolGraphX es un script que genera gráficos de dependencias, herencia, llamadas y flujo de control para contratos Solidity. Utiliza herramientas como `surya` y `slither` para analizar los contratos y `dot` para generar las visualizaciones.

## Características
- Generación de gráficos de:
  - **Dependencias**
  - **Herencia**
  - **Call Graph**
  - **Control Flow Graphs (CFGs)**
- Formatos de salida disponibles: `png`, `svg`, `pdf`, `jpg`
- Interfaz interactiva con selección de formato
- Animación durante la generación de los gráficos
- Organización de los archivos generados en la carpeta `graphs/`

## Requisitos
Asegúrate de tener instaladas las siguientes herramientas:

```bash
npm install -g surya
pip install slither-analyzer
dpkg --get-selections | grep graphviz || sudo apt install graphviz -y
```

## Instalación
Clona el repositorio y accede al directorio:

```bash
git clone https://github.com/ExoHaeck/SolGraphX.git
cd SolGraphX
```

Dale permisos de ejecución al script:

```bash
chmod +x SolGraphX.sh
```

Para hacerlo accesible desde cualquier lugar del sistema, copia el script a `/usr/bin/`:

```bash
sudo cp SolGraphX.sh /usr/bin/SolGraphX
```

## Uso
Ejecuta el script y sigue las instrucciones en pantalla:

```bash
SolGraphX
```

Selecciona el formato de salida y espera a que se generen los gráficos.

## Salida
Los gráficos generados se almacenarán en la carpeta `graphs/` con el formato seleccionado.

## Contacto
Este script fue desarrollado por **HackSyndicate S.A.S.**.



