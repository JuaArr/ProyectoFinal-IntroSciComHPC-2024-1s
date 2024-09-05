# LINK DE LA SUSTENTACIÓN:
## https://youtu.be/-qipzMt7ynk

# ¿Cómo ejecutar la simulación?

## Parte 1: Creación y ejecución del Docker

### A. Creación y ejecución del Docker por primera vez

1. Crear la imagen: Utiliza el siguiente comando:

```bash
docker build -t proyecto_final .
```

2. Luego, se tiene que ejecutar el contenedor a partir de la imagen:

```bash
docker run -it --name mi-contenedor proyecto_final:latest bash
```


Aquí tienes el código completo de todo el README.md:

markdown
Copiar código

# ¿Cómo ejecutar la simulación?

## Parte 1: Creación y ejecución del Docker

### A. Creación y ejecución del Docker por primera vez

1. Crear la imagen: Utiliza el siguiente comando:

   ```bash
   docker build -t proyecto_final .
Luego, se tiene que ejecutar el contenedor a partir de la imagen:

```bash
docker run -it --name mi-contenedor proyecto_final:latest bash
```

### B. Ejecución de un Docker ya creado

1. Para ejecutar un Docker creado anteriormente, necesitas conocer la ID del Docker. Puedes usar el siguiente comando:

```bash
docker ps -a
```

2. Con la ID conocida, puedes ejecutar el Docker con el siguiente comando:

```bash
docker start [ID_Docker]
```

Por ejemplo: 

```bash
docker start 215d
```

## Parte 2: Pre y procesamiento de la simulación

# Paso 1: Preparación

```bash
bash parallel_simulation/runPre.sh [n Threads]
```

Ejemplo: 

```bash
bash parallel_simulation/runPre.sh 16
```

## Paso 2: Simulación de los datos en cada paso de tiempo
Información necesaria para visualizar la simulación en ParaView:

```bash
bash parallel_simulation/runAll.sh
```

## Parte 3: Generación de métricas de la paralelización
Generación de métricas:

```bash
bash scaling.sh
```

## Parte 4: Exportación de los datos para visualizar la simulación en ParaView desde un computador local

1.1 Salir del contenedor:

```bash
exit
```
1.2 Crear una carpeta para almacenar los resultados y lo necesario para simular en ParaView:

```bash
mkdir datos
```
```bash
cd datos/
```
1.3 Extraer los resultados y lo necesario para la simulación:

```bash
docker cp [docker_ID]:[Ruta] .
```
```bash
for i in 0 $(seq [desde_donde] [en_tanto] [hasta_donde]); do
  docker cp [docker_ID]:[Ruta]/$i [Destino]
done
```

Ejemplo:

```bash
for i in 0 $(seq 250 250 50000); do
  docker cp a6c2:/home/jovyan/parallel_simulation/$i .
done
```
Ejemplo:

```bash
docker cp 3807:/home/jovyan/scaling/ .
docker cp 3807:/home/jovyan/parallel_simulation/system .
docker cp 3807:/home/jovyan/parallel_simulation/constant .
docker cp 3807:/home/jovyan/parallel_simulation/case.foam .
```

2. Exportar los documentos a tu espacio en la Salafis:

```bash
scp -P [puerto] -r [carpeta] [usuario]@[dirección_de_la_salafis]:[ruta]
```

Ejemplo:

```bash
scp -P 443 -r parallel_simulation agonzalezva@168.176.35.111:/home/agonzalezva/
```

3. Exportar los datos de la Salafis a tu computador:

```bash
scp -P [puerto] -r [usuario]@[dirección_de_la_salafis]:[ruta_de_la_carpeta_a_copiar] .
```

Ejemplo:

```bash
scp -P 443 -r agonzalezva@168.176.35.111:/home/agonzalezva/datos .
```
Con esto, solo queda abrir ParaView en tu computador, buscar la carpeta en la ruta donde se copió ("C:\Users\Usuario"), seleccionar el archivo case.foam, y la simulación estará lista para visualizarse.
