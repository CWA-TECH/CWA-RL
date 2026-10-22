// Añade al proyecto Android lo que pide AdMob. Se puede ejecutar las veces que haga falta.
// Para publicar: cambia ADMOB_APP_ID por el identificador de tu app en AdMob (lleva una virgulilla ~).
const fs = require('fs');
const path = require('path');

const ADMOB_APP_ID = process.env.ADMOB_APP_ID || 'ca-app-pub-3940256099942544~3347511713'; // el de PRUEBA de Google

const raiz = path.join(__dirname, '..', 'android', 'app', 'src', 'main');
const manifiesto = path.join(raiz, 'AndroidManifest.xml');
const strings = path.join(raiz, 'res', 'values', 'strings.xml');

let m = fs.readFileSync(manifiesto, 'utf8');
if (!m.includes('com.google.android.gms.ads.APPLICATION_ID')) {
  m = m.replace(/<application([^>]*)>/, '<application$1>\n        <meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" android:value="@string/admob_app_id"/>');
  fs.writeFileSync(manifiesto, m);
  console.log('Manifiesto: añadido el identificador de AdMob');
}

let s = fs.readFileSync(strings, 'utf8');
if (s.includes('name="admob_app_id"')) {
  s = s.replace(/<string name="admob_app_id">[^<]*<\/string>/, `<string name="admob_app_id">${ADMOB_APP_ID}</string>`);
} else {
  s = s.replace('</resources>', `    <string name="admob_app_id">${ADMOB_APP_ID}</string>\n</resources>`);
}
fs.writeFileSync(strings, s);
console.log('strings.xml: admob_app_id = ' + ADMOB_APP_ID);
