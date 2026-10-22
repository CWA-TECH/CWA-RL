# Rumbaluz · app de Android

*Hallaca, gaita y pan de jamón.* La app de Android de [navidad.rumbaluz.org](https://navidad.rumbaluz.org), hecha con Capacitor.
Toda la app es un solo archivo: `www/index.html`, el mismo que la web pero con el modo testers visible.

- Paquete: `org.rumbaluz.app` (no se puede cambiar después de la primera subida a Google Play).
- Anuncios: AdMob, ahora mismo con los **códigos de prueba de Google** (salen anuncios «Test Ad»; no generan dinero ni riesgo).

## Conseguir la APK de prueba (sin instalar nada)

Cada vez que se sube un cambio a `main`, GitHub compila la app solo.

1. En GitHub, pestaña **Actions** → la última ejecución de **APK de prueba** (tiene que estar en verde).
2. Abajo, en **Artifacts**, descarga `rumbaluz-apk-de-prueba` (es un .zip con `app-debug.apk` dentro).
3. Pásala al teléfono y ábrela. Android pedirá permiso para «instalar apps de origen desconocido»: acéptalo para esa vez.

Para relanzarla a mano: Actions → APK de prueba → **Run workflow**.

## Qué probar

- Abajo, un banner con el rótulo «Test Ad», y la barra de pestañas justo encima.
- Cada 3 a 8 cambios de pestaña o juego, un anuncio a pantalla completa (nunca dos en menos de un minuto, ni en el primer minuto).
- En Calendario, desde el 18 de noviembre: «Ver un anuncio y abrir la de mañana». Para verlo antes: bandera → «Ver la app como si fuera» → una fecha de diciembre.
- «Compartir imagen» en cualquier postal: debe abrir el menú de compartir de Android con la imagen.
- «Opciones de anuncios» al pie: abre el aviso de consentimiento (fuera de Europa dirá que no hay nada que ajustar).
- La arepa no sale en la app (Google Play no permite pagos por enlace externo); en la web sí.

## Antes de publicar en Google Play

1. En `www/index.html`, bloque `anuncios`: los tres códigos reales de AdMob (`banner`, `completo`, `premiado`) y `pruebas: false`.
2. El identificador de la app de AdMob: en la compilación, variable `ADMOB_APP_ID` (o cambiarlo en `scripts/ajustes-android.js`).
3. `testers: false` en `www/index.html`.
4. Versión firmada (AAB) para Google Play: hace falta una clave de firma. Se prepara en un paso aparte; **la clave no se sube nunca al repositorio**.
5. Política de privacidad publicada (en creativewildartists.com) y `app-ads.txt` en la raíz del dominio que figure como sitio web del desarrollador.

## Trabajar en tu ordenador (opcional)

Con Node.js y Android Studio: `npm run preparar` y luego `npm run abrir`.
