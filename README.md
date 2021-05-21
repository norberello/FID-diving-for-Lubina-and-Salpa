# FID-diving-for-Lubina-and-Salpa

<a href="https://github.com/norberello/FID-diving-for-Lubina-and-Salpa/blob/main/FID%20peces-paired%20data%20test.ipynb">Código </a> y datos para comparar FID entre dos especies de peces.

<p class="aligncenter">
    <img src="https://pescasubmarinayapnea.com/wp-content/uploads/2021/01/Imagen1-696x341.jpg"/>
</p>

**Contexto**: Las distancias a las que los pescadores pueden acercarse a los peces (FID: Flight Innitial Distance) debería ser diferente de acuerdo a la predación humana que estos sufren, si esto fuera cierto, se esperaría que la lubina tuviera distancias más grandes. Utilizamos una muestra de 23 pescadores para analizar estas diferencias en la percepción de la distancias entre las dos especies. Para hacer esta comparación vamos a usar una prueba de comparación de medias parámetrica de medidas dependientes (los datos vienen emparejados: dos observaciones de FID por cada pescador) si los datos cumplen con los supuestos de la prueba (Student t-test), o si no se cumplen, una prueba no paramétrica (Mann Whitney W test). También nos interesa demontrar si hay diferencias en la proporción de pescadores que prefieren pescar peces pequeños frente a peces grandes, debido al tamaño de muestra y la frecuencia tan baja de pescadores que prefieren pequeños (n = 1) se recomienda usar una prueba exacta binomial de bondad de ajuste.
