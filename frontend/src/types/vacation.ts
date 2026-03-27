export interface VacationOverride {
  id: string;
  targetDate: string;
  maxCount: number;
}

export interface VacationLimit {
  id: string;
  defaultMax: number;
  overrides: VacationOverride[];
}

export interface VacationOverrideRequest {
  date: string;
  maxCount: number;
}
