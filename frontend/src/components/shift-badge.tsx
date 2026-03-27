import { cn } from "@/lib/utils";

interface ShiftBadgeProps {
  abbreviation: string;
  color: string;
  bgColor: string;
  size?: "sm" | "md";
  className?: string;
}

export function ShiftBadge({
  abbreviation,
  color,
  bgColor,
  size = "sm",
  className,
}: ShiftBadgeProps) {
  return (
    <span
      className={cn(
        "inline-flex items-center justify-center rounded-md font-bold leading-none",
        size === "sm" && "px-1 py-0.5 text-[9px]",
        size === "md" && "px-1.5 py-1 text-[11px]",
        className
      )}
      style={{ color, backgroundColor: bgColor }}
    >
      {abbreviation}
    </span>
  );
}
