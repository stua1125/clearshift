-- Add time fields to shift_type
ALTER TABLE shift_type ADD COLUMN start_time VARCHAR(5);
ALTER TABLE shift_type ADD COLUMN end_time VARCHAR(5);

-- Update default shift types for 삼성 강북점 to match new Figma design
UPDATE shift_type SET name = '오전 근무', abbreviation = 'MD', color = '#0064FF', bg_color = '#E8F0FE',
    category = 'WORK', start_time = '09:00', end_time = '18:00', sort_order = 0
WHERE abbreviation = 'D' AND branch_id = '00000000-0000-0000-0000-000000000001';

UPDATE shift_type SET name = '오후 근무', abbreviation = 'AF', color = '#FF9100', bg_color = '#FFF3E0',
    category = 'WORK', start_time = '14:00', end_time = '22:00', sort_order = 1
WHERE abbreviation = 'N' AND branch_id = '00000000-0000-0000-0000-000000000001';

UPDATE shift_type SET name = '야간 근무', abbreviation = 'NI', color = '#6C5CE7', bg_color = '#F0EDFF',
    category = 'WORK', start_time = '22:00', end_time = '07:00', sort_order = 2
WHERE abbreviation = 'OFF' AND branch_id = '00000000-0000-0000-0000-000000000001';

UPDATE shift_type SET name = '휴무', abbreviation = 'HD', color = '#94A3B8', bg_color = '#F1F5F9',
    category = 'OFF', start_time = NULL, end_time = NULL, sort_order = 3
WHERE abbreviation = 'V' AND branch_id = '00000000-0000-0000-0000-000000000001';

-- Remove training shift type (soft delete)
UPDATE shift_type SET is_active = false
WHERE abbreviation = 'T' AND branch_id = '00000000-0000-0000-0000-000000000001';
