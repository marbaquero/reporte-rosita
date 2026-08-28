-- Permite borrar reportes desde el panel (protegido con PIN en el sitio).
-- Antes, la tabla solo permitía leer e insertar — esto agrega el permiso
-- de borrado para que el botón de "Eliminar" en modo administrador funcione.
--
-- Ejecutar en: Supabase Dashboard > SQL Editor > New query

create policy "Cualquiera puede borrar un reporte"
  on reportes_aracely for delete
  to anon
  using (true);

-- Nota de seguridad: el PIN que protege el botón de borrar vive en el
-- sitio (config.js), no en la base de datos — es una barrera de uso,
-- no una barrera real de seguridad. Cualquiera con conocimientos técnicos
-- y el enlace podría borrar un reporte sin pasar por el sitio. Si quieres
-- protección real, lo correcto sería agregar autenticación de Supabase
-- (login con contraseña) en vez de RLS abierta + PIN visual. Dímelo si
-- prefieres eso y lo armamos.
