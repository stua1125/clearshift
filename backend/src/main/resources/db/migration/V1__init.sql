CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Branch (지점)
CREATE TABLE branch (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    code VARCHAR(50) NOT NULL UNIQUE,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP NOT NULL DEFAULT now()
);

-- User
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    google_id VARCHAR(255) NOT NULL UNIQUE,
    profile_image_url VARCHAR(500),
    role VARCHAR(20) NOT NULL DEFAULT 'WORKER',
    branch_id UUID REFERENCES branch(id),
    created_at TIMESTAMP NOT NULL DEFAULT now()
);

-- Shift Type (근무타입)
CREATE TABLE shift_type (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    branch_id UUID NOT NULL REFERENCES branch(id),
    name VARCHAR(50) NOT NULL,
    abbreviation VARCHAR(5) NOT NULL,
    color VARCHAR(10) NOT NULL,
    bg_color VARCHAR(10) NOT NULL,
    category VARCHAR(20) NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP NOT NULL DEFAULT now()
);

-- Monthly Schedule
CREATE TABLE monthly_schedule (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id),
    year INT NOT NULL,
    month INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'DRAFT',
    submitted_at TIMESTAMP,
    reviewed_at TIMESTAMP,
    reviewed_by UUID REFERENCES users(id),
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE(user_id, year, month)
);

-- Daily Assignment
CREATE TABLE daily_assignment (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    schedule_id UUID NOT NULL REFERENCES monthly_schedule(id) ON DELETE CASCADE,
    day INT NOT NULL,
    shift_type_id UUID NOT NULL REFERENCES shift_type(id),
    UNIQUE(schedule_id, day)
);

-- Vacation Limit
CREATE TABLE vacation_limit (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    branch_id UUID NOT NULL REFERENCES branch(id) UNIQUE,
    default_max INT NOT NULL DEFAULT 3
);

-- Vacation Limit Override
CREATE TABLE vacation_limit_override (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    vacation_limit_id UUID NOT NULL REFERENCES vacation_limit(id) ON DELETE CASCADE,
    target_date DATE NOT NULL,
    max_count INT NOT NULL,
    UNIQUE(vacation_limit_id, target_date)
);

-- Calendar Event
CREATE TABLE calendar_event (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    branch_id UUID NOT NULL REFERENCES branch(id),
    title VARCHAR(200) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    color VARCHAR(10) NOT NULL,
    memo TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT now()
);

-- Indexes
CREATE INDEX idx_users_branch ON users(branch_id);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_shift_type_branch ON shift_type(branch_id);
CREATE INDEX idx_monthly_schedule_user_year_month ON monthly_schedule(user_id, year, month);
CREATE INDEX idx_daily_assignment_schedule ON daily_assignment(schedule_id);
CREATE INDEX idx_calendar_event_branch ON calendar_event(branch_id);
CREATE INDEX idx_calendar_event_dates ON calendar_event(start_date, end_date);

-- Initial data: 삼성 강북점
INSERT INTO branch (id, name, code, is_active)
VALUES ('00000000-0000-0000-0000-000000000001', '삼성 강북점', 'samsung-gangbuk', true);

-- Default shift types for 삼성 강북점
INSERT INTO shift_type (branch_id, name, abbreviation, color, bg_color, category, sort_order) VALUES
('00000000-0000-0000-0000-000000000001', '주간', 'D', '#3B82F6', '#DBEAFE', 'WORK', 0),
('00000000-0000-0000-0000-000000000001', '야간', 'N', '#7C3AED', '#EDE9FE', 'WORK', 1),
('00000000-0000-0000-0000-000000000001', '휴무', 'OFF', '#10B981', '#D1FAE5', 'OFF', 2),
('00000000-0000-0000-0000-000000000001', '휴가', 'V', '#F59E0B', '#FEF3C7', 'VACATION', 3),
('00000000-0000-0000-0000-000000000001', '교육', 'T', '#EC4899', '#FCE7F3', 'TRAINING', 4);

-- Default vacation limit for 삼성 강북점
INSERT INTO vacation_limit (branch_id, default_max)
VALUES ('00000000-0000-0000-0000-000000000001', 3);
