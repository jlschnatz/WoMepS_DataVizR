

## Notes 2 Do

-   Du musst noch deine Angaben anpassen auf der Folie 4

-   **Wo sollen wir den Aufbau von cat and num Variablen einbauen? --\> bei Überblick?**

-   Slide 9: Beispiel (Bild) --\> Ich lade einige Beispiele aus Papern

    -   Verständnis der Daten: Datenvisualisierung hilft uns, Muster und Trends in den Daten zu erkennen und zu verstehen. Eine Grafik kann oft mehrere Variablen in einem Bild darstellen und uns helfen, Beziehungen zwischen den Variablen zu erkennen, die in einer reinen Tabelle schwierig zu sehen wären.

-   Slide 10: Beispiel (Bild)

    -   Datenvisualisierung ist eine effektive Möglichkeit, um Daten auf eine klare und prägnante Weise zu kommunizieren. Eine gut gestaltete Grafik kann helfen, komplexe Ergebnisse und Erkenntnisse schnell und leicht verständlich zu vermitteln, auch für Menschen, die keine Experten in der Datenanalyse sind.

-   Slide 11: Beispiel (Bild)

    -   Entscheidungsfindung: Datenvisualisierung kann bei der Entscheidungsfindung helfen, indem sie uns dabei unterstützt, Trends, Muster und Zusammenhänge in den Daten zu identifizieren. Durch die Visualisierung von Daten können wir auch potenzielle Probleme oder Chancen erkennen, die in den Daten verborgen sein könnten.

-   Slide 12: Beispiel (Bild)

    -   Fehlererkennung: Datenvisualisierung kann auch helfen, Fehler und Ausreißer in den Daten zu identifizieren. Grafiken ermöglichen es uns, schnell abnormale Datenpunkte zu erkennen, die möglicherweise falsch oder ungewöhnlich sind. Durch die Identifizierung dieser Ausreißer können wir bessere Entscheidungen treffen und die Qualität der Daten verbessern.

-   Slide 15: Beispiel Code und **direkter Vorführung in R**

```{r}
ggplot(DATA, aes(x=var1, y=var2))

ggplot(DATA, aes(x=var1, y=var2, colour=gender))

ggplot(DATA, aes(x=var1, y=var2, group=counties))
```

-   Slide 16: siehe Punkt drüber!

```{r}
ggplot(DATA, aes(x=var1))+
  geom_point()

ggplot(DATA, aes(x=var1))+
  geom_line()

ggplot(DATA, aes(x=var1))+
  geom_boxplot()

ggplot(DATA, aes(x=var1))+
  geom_bar()s
```

-   Slide 17: Hier hat sich einiges geändert

    -   Hier muss ich nochmal nachgucken, die "stat" Befehle als solches gibt es nicht mehr :(

-   Slide 18:

    -   Im Grunde wie die Slides davor

## Notes Ablauf

-   Innerhalb der Theorie, kommen schon einige Beispiele, was alles möglich ist mit ggplot

    -   Karten, 3D, shiny usw.

-   Beim Überblick sollen einige **einfache** Beispiele schon gezeigt werden (Slides 15 to 18)

-   Nach dem schnellen Überblick kommt Pause (30 Minuten)

-   Nach der Pause gibt es eine kleine Einführung in den Datensatz, welche Variablen usw.

-   Danach bekommen die Aufgaben, die die Grundlagen aus dem Überblick inkludieren und aber etwas weiter gehen sollen, innerhalb dieser Basics (ausgenommen Themes)

    -   Bsp.

        -   Bar Plot with Errorbars

        -   Plot nach Gruppen

        -   Plot nach Gruppen und Geschlecht (facets)

        -   usw.

-   Sie haben 30 Minuten Zeit für die Aufgaben oder Aufgabe

    -   Ergebnisse zeigen erklären lassen (sehr kurz)

    -   Besprechung der Schwierigkeiten, Peer Teaching usw.

    -   Ausblick Tag 2
