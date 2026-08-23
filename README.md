# Reporte diario — Rosita

Reemplaza el Google Form + Google Sheets de Aracely por un sitio propio,
con el mismo set de preguntas. Ahora lo usan las tres cuidadoras
(Aracely, Ibeth, Carmita) — cada una elige su nombre al enviar el reporte,
así que pueden enviarse varios reportes el mismo día sin mezclarse.
Dos páginas:

- `index.html` — el formulario que Aracely llena cada turno
- `dashboard.html` — el historial, con búsqueda, filtro por fecha y exportar a CSV

## 1. Base de datos (Supabase)

Recomendado: usar el **mismo proyecto Supabase** del inventario de medicamentos
(`ynmikutonikslgtdlbbz.supabase.co`). Es solo una tabla nueva, no toca nada
de lo que ya existe ahí.

1. Entra a tu proyecto en [supabase.com](https://supabase.com/dashboard)
2. Ve a **SQL Editor** → **New query**
3. Pega el contenido de `supabase-schema.sql` y ejecútalo (▶ Run)
4. Ve a **Project Settings → API** y copia la clave **anon public**

### Si ya habías creado la tabla antes de este cambio

Si ya ejecutaste `supabase-schema.sql` en una versión anterior (solo para
Aracely), no hace falta borrar nada. Solo corre `migracion-cuidadora.sql`
en el SQL Editor — agrega la columna `cuidadora` sin tocar los reportes
que ya tienes guardados.

### Modo administrador (eliminar reportes)

El historial ahora tiene un botón **"Modo administrador"**. Al hacer clic,
pide un PIN — si es correcto, aparece un botón "Eliminar este reporte"
dentro de cada tarjeta al expandirla.

1. Corre `migracion-borrar.sql` en el SQL Editor (agrega el permiso de borrado)
2. En `config.js`, cambia `ADMIN_PIN` por el número que prefieras
3. El PIN queda guardado en tu navegador mientras dura la sesión — si cierras
   la pestaña, tendrás que ingresarlo de nuevo la próxima vez

Importante: este PIN es solo una barrera de uso — vive en el código del
sitio, así que no es seguridad real contra alguien con conocimientos
técnicos. Si más adelante quieres protección real (que ni viendo el código
se pueda borrar sin credenciales), la forma correcta es agregar login con
Supabase Auth en vez de este PIN visual — dímelo si llegado el momento
quieres eso.

## 2. Conectar el sitio a la base de datos

Abre `config.js` y pega tu clave donde dice `PEGA_AQUI_TU_ANON_KEY`:

```js
const SUPABASE_URL = "https://ynmikutonikslgtdlbbz.supabase.co";
const SUPABASE_ANON_KEY = "tu-clave-anon-aqui";
```

(Si prefieres un proyecto Supabase distinto, cambia también `SUPABASE_URL`.)

## 3. Publicar en Netlify

La forma más simple, sin usar terminal ni Git:

1. Ve a [app.netlify.com/drop](https://app.netlify.com/drop)
2. Arrastra esta carpeta completa (con `index.html`, `dashboard.html`, `config.js`, `netlify.toml`) a la página
3. Netlify te da un enlace al instante, por ejemplo `algo-random.netlify.app`
4. Opcional: en **Site settings → Change site name** puedes ponerle algo como
   `reporte-rosita.netlify.app`

Cada vez que quieras actualizar el sitio, vuelve a arrastrar la carpeta a la
misma página de Netlify (o conecta un repositorio de GitHub si prefieres
actualizarlo así — dímelo y armamos ese flujo).

## Notas

- No hay PIN: cualquiera con el enlace puede enviar un reporte y ver el
  historial, tal como pediste. Los reportes ya enviados no se pueden editar
  ni borrar desde el sitio (solo leer e insertar), para que nadie los altere
  por accidente.
- Los campos son exactamente los del formulario original: estado general,
  desayuno / almuerzo / merienda, hidratación, medicación, presión arterial,
  actividades del día, estado de la casa y observaciones.
- Si más adelante quieres poder editar un reporte ya enviado, o agregar un
  PIN de administrador (como en el panel de medicamentos), dímelo y lo
  agregamos.
