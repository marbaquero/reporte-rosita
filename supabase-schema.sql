-- Reporte diario de Aracely — esquema de base de datos
-- Ejecutar en: Supabase Dashboard > SQL Editor > New query
-- Proyecto sugerido: el mismo que ya usas para el inventario de medicamentos
-- (ynmikutonikslgtdlbbz.supabase.co) — esta es solo una tabla nueva, no interfiere
-- con las tablas existentes del inventario.

create table if not exists reportes_aracely (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  fecha date not null default current_date,
  cuidadora text,
  dia_turno text,
  estado_general text[] not null default '{}',
  desayuno text,
  almuerzo text,
  merienda text,
  hidratacion text,
  medicacion text[] not null default '{}',
  presion_arterial text,
  actividades text[] not null default '{}',
  estado_casa text[] not null default '{}',
  observaciones text
);

-- Índice para que el dashboard cargue rápido al ordenar por fecha
create index if not exists reportes_aracely_fecha_idx on reportes_aracely (fecha desc, created_at desc);

-- Row Level Security: el formulario y el panel se comparten por enlace, sin PIN,
-- así que permitimos lectura e inserción anónima, pero NO edición ni borrado
-- (así un reporte ya enviado no se puede alterar por error desde el enlace público).
alter table reportes_aracely enable row level security;

create policy "Cualquiera puede leer los reportes"
  on reportes_aracely for select
  to anon
  using (true);

create policy "Cualquiera puede enviar un reporte"
  on reportes_aracely for insert
  to anon
  with check (true);

-- Nota: si en algún momento quieres poder corregir un reporte ya enviado,
-- dímelo y agregamos una policy de update protegida con el mismo PIN
-- que usa el panel del inventario de medicamentos.
