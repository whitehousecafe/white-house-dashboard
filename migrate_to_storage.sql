-- SQL Script to migrate all 142 product images to Supabase Storage with backup & verification
-- Run this in the Supabase SQL Editor

BEGIN;

-- 1. Create a backup of the current products table with today's date
CREATE TABLE public.products_image_backup_20260726 AS
SELECT id, name, image
FROM public.products;

-- 2. Verify backup and perform updates in a secure block
DO $$
DECLARE
  backup_count INTEGER;
  product_count INTEGER;
  missing_ids_count INTEGER;
BEGIN
  -- Check backup row count
  SELECT COUNT(*) INTO backup_count FROM public.products_image_backup_20260726;
  IF backup_count <> 142 THEN
    RAISE EXCEPTION 'Backup row count is % (expected 142). Aborting migration.', backup_count;
  END IF;
  
  RAISE NOTICE 'Backup verified successfully with 142 rows. Performing updates...';
  
  -- Execute the updates
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/1.jpg' WHERE id = 1;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/2.jpg' WHERE id = 2;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/3.jpg' WHERE id = 3;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/4.jpg' WHERE id = 4;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/5.jpg' WHERE id = 5;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/6.jpg' WHERE id = 6;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/7.jpg' WHERE id = 7;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/8.jpg' WHERE id = 8;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/9.jpg' WHERE id = 9;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/10.jpg' WHERE id = 10;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/11.jpg' WHERE id = 11;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/12.jpg' WHERE id = 12;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/13.jpg' WHERE id = 13;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/14.jpg' WHERE id = 14;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/15.jpg' WHERE id = 15;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/16.jpg' WHERE id = 16;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/17.jpg' WHERE id = 17;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/18.jpg' WHERE id = 18;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/19.jpg' WHERE id = 19;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/20.jpg' WHERE id = 20;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/21.jpg' WHERE id = 21;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/22.jpg' WHERE id = 22;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/23.jpg' WHERE id = 23;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/24.jpg' WHERE id = 24;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/25.jpg' WHERE id = 25;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/26.jpg' WHERE id = 26;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/27.jpg' WHERE id = 27;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/28.jpg' WHERE id = 28;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/29.jpg' WHERE id = 29;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/30.jpg' WHERE id = 30;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/31.jpg' WHERE id = 31;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/32.jpg' WHERE id = 32;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/33.jpg' WHERE id = 33;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/34.jpg' WHERE id = 34;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/35.jpg' WHERE id = 35;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/36.jpg' WHERE id = 36;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/37.jpg' WHERE id = 37;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/38.jpg' WHERE id = 38;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/39.jpg' WHERE id = 39;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/40.jpg' WHERE id = 40;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/41.jpg' WHERE id = 41;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/42.jpg' WHERE id = 42;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/43.jpg' WHERE id = 43;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/44.jpg' WHERE id = 44;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/45.jpg' WHERE id = 45;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/46.jpg' WHERE id = 46;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/47.jpg' WHERE id = 47;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/48.jpg' WHERE id = 48;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/49.jpg' WHERE id = 49;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/50.jpg' WHERE id = 50;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/51.jpg' WHERE id = 51;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/52.jpg' WHERE id = 52;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/53.jpg' WHERE id = 53;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/54.jpg' WHERE id = 54;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/55.jpg' WHERE id = 55;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/56.jpg' WHERE id = 56;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/57.jpg' WHERE id = 57;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/58.jpg' WHERE id = 58;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/59.jpg' WHERE id = 59;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/60.jpg' WHERE id = 60;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/61.jpg' WHERE id = 61;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/62.jpg' WHERE id = 62;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/63.jpg' WHERE id = 63;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/64.jpg' WHERE id = 64;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/65.jpg' WHERE id = 65;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/66.jpg' WHERE id = 66;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/67.jpg' WHERE id = 67;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/68.jpg' WHERE id = 68;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/69.jpg' WHERE id = 69;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/70.jpg' WHERE id = 70;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/71.jpg' WHERE id = 71;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/72.jpg' WHERE id = 72;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/73.jpg' WHERE id = 73;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/74.jpg' WHERE id = 74;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/75.jpg' WHERE id = 75;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/76.jpg' WHERE id = 76;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/77.jpg' WHERE id = 77;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/78.jpg' WHERE id = 78;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/79.jpg' WHERE id = 79;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/80.jpg' WHERE id = 80;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/81.jpg' WHERE id = 81;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/82.jpg' WHERE id = 82;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/83.jpg' WHERE id = 83;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/84.jpg' WHERE id = 84;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/85.jpg' WHERE id = 85;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/86.jpg' WHERE id = 86;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/87.jpg' WHERE id = 87;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/88.jpg' WHERE id = 88;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/89.jpg' WHERE id = 89;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/90.jpg' WHERE id = 90;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/91.jpg' WHERE id = 91;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/92.jpg' WHERE id = 92;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/93.jpg' WHERE id = 93;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/94.jpg' WHERE id = 94;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/95.jpg' WHERE id = 95;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/96.jpg' WHERE id = 96;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/97.jpg' WHERE id = 97;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/98.jpg' WHERE id = 98;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/99.jpg' WHERE id = 99;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/100.jpg' WHERE id = 100;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/101.jpg' WHERE id = 101;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/102.jpg' WHERE id = 102;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/103.jpg' WHERE id = 103;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/104.jpg' WHERE id = 104;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/105.jpg' WHERE id = 105;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/106.jpg' WHERE id = 106;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/107.jpg' WHERE id = 107;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/108.jpg' WHERE id = 108;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/109.jpg' WHERE id = 109;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/110.jpg' WHERE id = 110;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/111.jpg' WHERE id = 111;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/112.jpg' WHERE id = 112;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/113.jpg' WHERE id = 113;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/114.jpg' WHERE id = 114;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/115.jpg' WHERE id = 115;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/116.jpg' WHERE id = 116;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/117.jpg' WHERE id = 117;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/118.jpg' WHERE id = 118;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/119.jpg' WHERE id = 119;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/120.jpg' WHERE id = 120;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/121.jpg' WHERE id = 121;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/122.jpg' WHERE id = 122;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/123.jpg' WHERE id = 123;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/124.jpg' WHERE id = 124;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/125.jpg' WHERE id = 125;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/126.jpg' WHERE id = 126;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/127.jpg' WHERE id = 127;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/128.jpg' WHERE id = 128;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/129.jpg' WHERE id = 129;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/130.jpg' WHERE id = 130;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/131.jpg' WHERE id = 131;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/132.jpg' WHERE id = 132;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/133.jpg' WHERE id = 133;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/134.jpg' WHERE id = 134;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/135.jpg' WHERE id = 135;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/136.jpg' WHERE id = 136;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/137.jpg' WHERE id = 137;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/138.jpg' WHERE id = 138;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/139.jpg' WHERE id = 139;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/140.jpg' WHERE id = 140;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/141.jpg' WHERE id = 141;
  UPDATE public.products SET image = 'https://owsgxvgauuecyffiewhn.supabase.co/storage/v1/object/public/product-images/142.jpg' WHERE id = 142;
  
  -- Check post-update product count
  SELECT COUNT(*) INTO product_count FROM public.products;
  IF product_count <> 142 THEN
    RAISE EXCEPTION 'Post-update product count is % (expected 142). Aborting and rolling back.', product_count;
  END IF;
  
  -- Check that all IDs from 1 to 142 still exist
  SELECT COUNT(*) INTO missing_ids_count 
  FROM generate_series(1, 142) as expected_id
  LEFT JOIN public.products p ON p.id = expected_id
  WHERE p.id IS NULL;
  
  IF missing_ids_count > 0 THEN
    RAISE EXCEPTION 'Post-update verification failed. % expected product IDs are missing. Aborting and rolling back.', missing_ids_count;
  END IF;
  
  RAISE NOTICE 'Migration successfully verified. Committing...';
END $$;

COMMIT;
