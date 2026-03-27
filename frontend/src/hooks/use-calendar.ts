"use client";

import { useState, useCallback, useMemo } from "react";
import {
  getDaysInMonth,
  getFirstDayOfWeek,
  getWeekRows,
} from "@/lib/utils/calendar";

export function useCalendar(initialYear?: number, initialMonth?: number) {
  const now = new Date();
  const [year, setYear] = useState(initialYear ?? now.getFullYear());
  const [month, setMonth] = useState(initialMonth ?? now.getMonth() + 1);

  const goToPrevMonth = useCallback(() => {
    setMonth((m) => {
      if (m === 1) {
        setYear((y) => y - 1);
        return 12;
      }
      return m - 1;
    });
  }, []);

  const goToNextMonth = useCallback(() => {
    setMonth((m) => {
      if (m === 12) {
        setYear((y) => y + 1);
        return 1;
      }
      return m + 1;
    });
  }, []);

  const goToToday = useCallback(() => {
    const today = new Date();
    setYear(today.getFullYear());
    setMonth(today.getMonth() + 1);
  }, []);

  const daysInMonth = useMemo(() => getDaysInMonth(year, month), [year, month]);
  const firstDayOfWeek = useMemo(
    () => getFirstDayOfWeek(year, month),
    [year, month]
  );
  const weekRows = useMemo(
    () => getWeekRows(year, month),
    [year, month]
  );

  return {
    year,
    month,
    daysInMonth,
    firstDayOfWeek,
    weekRows,
    goToPrevMonth,
    goToNextMonth,
    goToToday,
    setYear,
    setMonth,
  };
}
