-- Sesiones de estimulación cognitiva (Génesis, martes y jueves + fines de semana)
-- Crea una tabla aparte para no mezclar estas sesiones con el reporte diario.
--
-- Ejecutar en: Supabase Dashboard > SQL Editor > New query

create table if not exists sesiones_cognitivas (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  fecha date not null default current_date,
  cuidadora text,
  hora_inicio text,
  duracion text,
  actividades text[] not null default '{}',
  otra_actividad text,
  animo text,
  participacion text,
  manos text,
  nota text,
  materiales text
);

create index if not exists sesiones_cognitivas_fecha_idx
  on sesiones_cognitivas (fecha desc, created_at desc);

alter table sesiones_cognitivas enable row level security;

create policy "Cualquiera puede leer las sesiones"
  on sesiones_cognitivas for select
  to anon
  using (true);

create policy "Cualquiera puede enviar una sesion"
  on sesiones_cognitivas for insert
  to anon
  with check (true);

-- Borrado desde el historial (protegido con el PIN del sitio, igual que los reportes)
create policy "Cualquiera puede borrar una sesion"
  on sesiones_cognitivas for delete
  to anon
  using (true);
