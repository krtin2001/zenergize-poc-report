-- ============================================================
-- Zenergize POC Weekly Report — Supabase setup
-- Run this once in the Supabase SQL editor (Project → SQL Editor)
-- ============================================================

-- 1. Table
create table public.poc_entries (
  id          bigint generated always as identity primary key,
  week_label  text not null,
  client      text not null,
  model       text,
  location    text,
  status      text,
  next_steps  text,
  kwh         text,
  health      text,
  created_at  timestamptz not null default now()
);

-- 2. Row Level Security
-- This is an internal tool with no login yet, so we allow the anon
-- (publishable) key to read and write freely. Revisit this once
-- authentication is added — anon-key write access is appropriate
-- only for trusted, non-public deployments.
alter table public.poc_entries enable row level security;

create policy "Public read access"
  on public.poc_entries for select
  using (true);

create policy "Public insert access"
  on public.poc_entries for insert
  with check (true);

create policy "Public update access"
  on public.poc_entries for update
  using (true)
  with check (true);

create policy "Public delete access"
  on public.poc_entries for delete
  using (true);
