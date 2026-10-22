#!/usr/bin/env bash
# Deja listo el proyecto Android a partir de www/index.html.
# Lo usa la compilación automática de GitHub y sirve igual en tu ordenador (Git Bash en Windows vale).
set -euo pipefail
cd "$(dirname "$0")/.."

# 1. Versiones: manda el plugin de AdMob. Se instala su última versión y la de Capacitor que él pide,
#    para que nunca haya choque de versiones.
if [ ! -d node_modules/@capacitor/core ]; then
  echo "Consultando versiones…"
  INFO=$(npm view @capacitor-community/admob --json)
  ADMOB=$(node -e "console.log(JSON.parse(process.argv[1]).version)" "$INFO")
  RANGO=$(node -e "const p=JSON.parse(process.argv[1]);console.log((p.peerDependencies||{})['@capacitor/core']||(p.devDependencies||{})['@capacitor/core']||'')" "$INFO")
  MAYOR=$(node -e "const m=String(process.argv[1]).match(/\d+/);console.log(m?m[0]:'')" "$RANGO")
  if [ -z "$MAYOR" ]; then MAYOR=$(npm view @capacitor/core version | cut -d. -f1); fi
  echo "AdMob $ADMOB (pide @capacitor/core «$RANGO») -> Capacitor $MAYOR"
  npm install --save "@capacitor-community/admob@$ADMOB" "@capacitor/core@^$MAYOR" "@capacitor/android@^$MAYOR" "@capacitor/filesystem@^$MAYOR" "@capacitor/share@^$MAYOR"
  npm install --save-dev "@capacitor/cli@^$MAYOR"
fi

# 2. El proyecto Android se genera la primera vez.
[ -d android ] || npx cap add android

# 3. Lo que AdMob necesita en el manifiesto y en strings.xml (sin esto la app se cierra al arrancar).
node scripts/ajustes-android.js

# 4. Icono y pantalla de arranque a partir de assets/. Si falla, se queda el de serie y no pasa nada.
npx --yes @capacitor/assets generate --android --iconBackgroundColor '#16246B' --splashBackgroundColor '#16246B' || echo "AVISO: no se pudieron generar los iconos; se queda el de serie."

# 5. Copia www/ dentro de Android.
npx cap sync android
