export type SubmissionStatus = "DRAFT" | "SUBMITTED";

export interface AssignmentInfo {
  shiftTypeId: string;
  shiftTypeName: string;
  abbreviation: string;
  color: string;
  bgColor: string;
}

export interface ScheduleResponse {
  id: string;
  year: number;
  month: number;
  status: SubmissionStatus;
  submittedAt?: string;
  assignments: Record<number, AssignmentInfo>;
}

export interface AssignmentRequest {
  assignments: Record<number, string>; // day → shiftTypeId
}

export interface TeamScheduleResponse {
  scheduleId: string;
  userId: string;
  userName: string;
  profileImageUrl?: string;
  status: SubmissionStatus;
  assignments: Record<number, AssignmentInfo>;
}
