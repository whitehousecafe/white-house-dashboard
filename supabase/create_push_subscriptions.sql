-- SQL Migration: Create push_subscriptions Table & Configure Row Level Security
-- Run this script in the Supabase SQL Editor (https://owsgxvgauuecyffiewhn.supabase.co)

-- 1. Create push subscriptions table
CREATE TABLE IF NOT EXISTS public.push_subscriptions (
  id bigint generated always as identity primary key,
  endpoint text not null unique,
  keys jsonb not null,
  user_id uuid,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Enable Row Level Security (RLS)
ALTER TABLE public.push_subscriptions ENABLE ROW LEVEL SECURITY;

-- Policy 1: Allow any client device to register/insert its subscription endpoint
CREATE POLICY "Allow anonymous inserts" 
ON public.push_subscriptions 
FOR INSERT 
WITH CHECK (true);

-- Policy 2: Allow ONLY the authorized admin (admin@whitehousecafe.com) to view subscription list via Client API
CREATE POLICY "Allow admin select" 
ON public.push_subscriptions 
FOR SELECT 
USING (auth.jwt() ->> 'email' = 'admin@whitehousecafe.com');

-- Policy 3: Allow ONLY the authorized admin (admin@whitehousecafe.com) to delete subscription endpoints via Client API
CREATE POLICY "Allow admin delete" 
ON public.push_subscriptions 
FOR DELETE 
USING (auth.jwt() ->> 'email' = 'admin@whitehousecafe.com');


-- 2. Create processed pushes log table for duplicate protection (idempotency)
CREATE TABLE IF NOT EXISTS public.push_notifications_log (
  order_id bigint primary key,
  sent_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Enable Row Level Security (RLS) on log table
ALTER TABLE public.push_notifications_log ENABLE ROW LEVEL SECURITY;

-- Allow read/write for server service role only (no public access policies)
