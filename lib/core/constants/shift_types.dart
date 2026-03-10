import '../../shared/models/shift_type.dart';
import '../theme/app_colors.dart';

final List<ShiftType> defaultShiftTypes = [
  const ShiftType(
    id: 'morning',
    name: '오전 근무',
    abbreviation: 'MD',
    color: AppColors.shiftMorning,
    bgColor: AppColors.shiftMorningBg,
    category: ShiftCategory.work,
    sortOrder: 0,
    startTime: '09:00',
    endTime: '18:00',
  ),
  const ShiftType(
    id: 'afternoon',
    name: '오후 근무',
    abbreviation: 'AF',
    color: AppColors.shiftAfternoon,
    bgColor: AppColors.shiftAfternoonBg,
    category: ShiftCategory.work,
    sortOrder: 1,
    startTime: '14:00',
    endTime: '22:00',
  ),
  const ShiftType(
    id: 'night',
    name: '야간 근무',
    abbreviation: 'NI',
    color: AppColors.shiftNight,
    bgColor: AppColors.shiftNightBg,
    category: ShiftCategory.work,
    sortOrder: 2,
    startTime: '22:00',
    endTime: '07:00',
  ),
  const ShiftType(
    id: 'off',
    name: '휴무',
    abbreviation: 'HD',
    color: AppColors.shiftOff,
    bgColor: AppColors.shiftOffBg,
    category: ShiftCategory.leave,
    sortOrder: 3,
  ),
];
