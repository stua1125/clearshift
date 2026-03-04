import '../../shared/models/shift_type.dart';
import '../theme/app_colors.dart';

final List<ShiftType> defaultShiftTypes = [
  const ShiftType(
    id: 'day',
    name: '주간',
    abbreviation: 'D',
    color: AppColors.shiftDay,
    bgColor: AppColors.shiftDayBg,
    category: ShiftCategory.work,
    sortOrder: 0,
  ),
  const ShiftType(
    id: 'night',
    name: '야간',
    abbreviation: 'N',
    color: AppColors.shiftNight,
    bgColor: AppColors.shiftNightBg,
    category: ShiftCategory.work,
    sortOrder: 1,
  ),
  const ShiftType(
    id: 'off',
    name: '휴무',
    abbreviation: 'OFF',
    color: AppColors.shiftOff,
    bgColor: AppColors.shiftOffBg,
    category: ShiftCategory.leave,
    sortOrder: 2,
  ),
  const ShiftType(
    id: 'vacation',
    name: '휴가',
    abbreviation: 'V',
    color: AppColors.shiftVacation,
    bgColor: AppColors.shiftVacationBg,
    category: ShiftCategory.leave,
    sortOrder: 3,
  ),
  const ShiftType(
    id: 'training',
    name: '교육',
    abbreviation: 'T',
    color: AppColors.shiftTraining,
    bgColor: AppColors.shiftTrainingBg,
    category: ShiftCategory.other,
    sortOrder: 4,
  ),
];
