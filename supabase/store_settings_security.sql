-- SQL Migration: Secure store_settings Table & Enable Realtime Updates
-- Run this in the Supabase SQL Editor (https://owsgxvgauuecyffiewhn.supabase.co)

-- 1. Enable Row Level Security (RLS) on store_settings
ALTER TABLE public.store_settings ENABLE ROW LEVEL SECURITY;

-- 2. Create Policy: Allow anyone (anonymous and authenticated users) to read store settings
CREATE POLICY "Allow select for all" 
ON public.store_settings
FOR SELECT 
USING (true);

-- 3. Create Policy: Allow only authenticated users (Admin Panel) to update store settings
CREATE POLICY "Allow update for authenticated only" 
ON public.store_settings
FOR UPDATE 
TO authenticated 
USING (true)
WITH CHECK (true);

-- 4. Enable Realtime updates for store_settings via the supabase_realtime publication
ALTER PUBLICATION supabase_realtime ADD TABLE public.store_settings;
