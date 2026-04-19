-- Align default shift type colors with Toss palette (see SPEC.md §2.3)

UPDATE shift_type SET color = '#3182F6', bg_color = '#E8F3FF'
WHERE abbreviation = '오전' OR abbreviation = 'MD';

UPDATE shift_type SET color = '#FF9A3C', bg_color = '#FFF4E6'
WHERE abbreviation = '오후' OR abbreviation = 'AF';

UPDATE shift_type SET color = '#8B95A1', bg_color = '#F2F4F6'
WHERE abbreviation = '휴무' OR abbreviation = 'HD';
