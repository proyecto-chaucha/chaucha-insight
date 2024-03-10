# Chaucha Insight

Este es un explorador de la red chaucha
te permitirá visualizar los bloques
e información adicional de las transacciones.

Nota: Si deseas compilar tu propio insight
puedes ir a la carpeta _patches_.

![imagen](https://github.com/proyecto-chaucha/chaucha-insight/assets/292738/76c9c006-6bd5-4580-8795-6d43affae84d)

## Requisitos
- Node 8.17
- Ubuntu 16.04 (Recomendado)

## Recomendaciones
- Si el archivo litecore-node.json no ejecuta bien el chauchad, se recomienda ejecutar primero chauchad y luego ejecutar el comando start del insight

## Directorio Insight
- `cd insight`

### Comandos

- `docker-compose build`: Construye la imagen de Docker para ejecutar el Insight.

- `docker-compose up`: Ejecuta el servidor. `http://localhost:3001`.
