# ¿Afecta la turisitificación al comercio local?

Repositorio de datos, scripts y visualizaciones del grupo sobre el comercio local, del [Taller de
datos de la turistificación Madrid 2018](https://wiki.montera34.com/airbnb/datos-turistificacion-madrid-jpd18)

## Datos

La carpeta `data/` contiene:

- datos en bruto, en `raw/`
  - `actividades-comerciales/`, datos de actividades comerciales en Madrid
  - `airbnb/`, datos proporcionados en el taller con los anuncios de Airbnb a fecha de abril 2018,
    procesados por Montera 34 para incluir el barrio y el distrito del anuncio. Datos obtenidos de
    InsideAirBnb y Datahippo.
- datos limpios, en `output/`
- scripts de limpieza, en `scripts/`
- [desc_epigrafes.csv]() Descripción de los epígrafes de actividad

### Limpieza

Los scripts de limpieza realizan las siguientes tareas:

- Eliminan NAs
- Eliminan locales sin actividad
- Filtran por distritos: Arganzuela, Usera y Centro
- Clasifican las actividades en:
  - Mecanico
  - Tienda de ropa
  - Arreglo de ropa
  - Escuela
  - Idiomas
  - Autoescuela
  - Farmacia
  - Carniceria
  - Pescaderia
  - OTROS
- Elimina las filas OTROS

## Análisis

_TODO_
