## Grundlagen

- ggplot2 basiert auf theoretischen Grundannahmen der "Grammar of Graphics"
- Weg von Excel und SPSS Plots -> Scatterplot | Barplot | Pie-Chart als einzelne Entitäten
- Hin zu: gemeinsamer Foundation von "Graphics" -> gemeinsame Repräsentation und Prinzipien
- Allgemeine Relevanz von Grafiken im wissenschaftlichen Kontext
- Teaser von verschiedenen Grafiken als Übersicht was möglich ist
- Relevanz von ggplot2 als das wichtigste Package zur Datenvisualisierung in R (und darüber hinaus) 

## Layerklärung von ggplot2

### Data

- Tidy-Format
- Long-Data
- Vorherige Datenmanipulation zur idealen Plotten


### Mapping

- Wie Geometrie und Daten aufbereitet werden und miteinander verbunden werden
- Aesthetic mapping: Link variables in data to graphical properties in the geometry.
- Facet mapping: Link variables in the data to panels in the facet layout.

![image](https://drive.google.com/file/d/13m-ybnqQi2wZ62tojb0-0HNvVOrxjdG0/view?pli=1)

### Statistics

- Statistische Transformationen der Input-Variablen zur visuellen Darstellung in der Geometry
- z.B. Barchart Count
- Summary-Statistics für Boxplot
- Kann auch schon vor plotting durch Datenmanipulierung stattfinden

### Scales

- Skalenproperties
- Skalentransformationen
- limits, breaks, labels
- diskret, contionous, binned, date(time)
- Kategorien: z.B. Farbe, Shape, Fill, etc.
- scale_*aestetic*_*second* (z.B. scale_color_manual)

### Geometries

- Interpretation der Ästhetik als graphsiche Repräsentation
-  physical representation of the data, with the combination of stat and geom defining many familiar named graphics: the scatterplot, histogram, contourplot, and so on
- Welche geometrischen Objekte sollen benutzt werden um die Repräsentation zu visualisieren?
- Art der Grafik
- mit der wichtigste Layer

### Facets

- Definition der Anzahl an Panels zur Datenvisualisierung
- Wichtig: zwischen den Panels gleiche Logik
- Kann nützlich sein bei Overplotting
- Kleine Reihen -> Small Multiples (Tufe, 2001) 
- **hier nochmal genauer schauen**

### Coordinates

- Bestimmte in welchen Koordinatensystem die Daten visuell repräsentiert sind
- Kartesianisch, Polar, etc.


### Theme

- nicht verbunden mit den Daten
- Wie der Plot dann am Ende tatsächlich aussieht
- Hintergrund, Schriften, Abstände, etc.
