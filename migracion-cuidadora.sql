-- Migración: agregar la columna "cuidadora" a la tabla ya creada,
-- para que Aracely, Ibeth y Carmita puedan usar el mismo formulario
-- y se puedan enviar varios reportes el mismo día (uno por cada una).
--
-- Ejecutar en: Supabase Dashboard > SQL Editor > New query

alter table reportes_aracely
  add column if not exists cuidadora text;

-- Los reportes que ya enviaste antes de este cambio quedan con
-- cuidadora = NULL. Si quieres, puedes marcarlos como de Aracely
-- (ya que hasta ahora solo ella lo había usado) descomentando esto:

-- update reportes_aracely set cuidadora = 'Aracely' where cuidadora is null;

create index if not exists reportes_aracely_cuidadora_idx on reportes_aracely (cuidadora);
