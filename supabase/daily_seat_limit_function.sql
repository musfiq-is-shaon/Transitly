-- =====================================================
-- DAILY SEAT LIMIT FUNCTION
-- =====================================================
-- This file adds the check_daily_seat_limit() function
-- Run this separately if schema.sql causes type conflicts
-- =====================================================

-- =====================================================
-- FUNCTION: CHECK DAILY SEAT LIMIT
-- =====================================================
-- Ensures users can only book a maximum of 4 seats per day
-- Returns JSON with validation result
-- =====================================================
CREATE OR REPLACE FUNCTION check_daily_seat_limit(
  p_user_id UUID,
  p_new_seats INTEGER[],
  p_max_seats INTEGER DEFAULT 4
)
RETURNS JSON
LANGUAGE plpgsql
AS $$
DECLARE
  v_existing_seats INTEGER;
  v_total_seats INTEGER;
  v_message TEXT;
BEGIN
  -- Count existing confirmed seats for today
  SELECT COALESCE(SUM(array_length(seats_booked, 1)), 0)::INTEGER
  INTO v_existing_seats
  FROM bookings
  WHERE user_id = p_user_id
    AND status = 'confirmed'
    AND created_at::date = CURRENT_DATE;

  v_total_seats := v_existing_seats + COALESCE(array_length(p_new_seats, 1), 0);

  IF v_total_seats > p_max_seats THEN
    v_message := 'Daily seat limit exceeded. You can only book ' || p_max_seats ||
                 ' seats per day. You already have ' || v_existing_seats || ' seat(s) booked today.';
    RETURN json_build_object(
      'valid', false,
      'reason', 'DAILY_LIMIT_EXCEEDED',
      'message', v_message,
      'existing_seats', v_existing_seats,
      'requested_seats', COALESCE(array_length(p_new_seats, 1), 0),
      'total_seats', v_total_seats,
      'max_seats', p_max_seats
    );
  END IF;

  RETURN json_build_object(
    'valid', true,
    'reason', 'OK',
    'message', 'Daily seat limit check passed',
    'existing_seats', v_existing_seats,
    'requested_seats', COALESCE(array_length(p_new_seats, 1), 0),
    'total_seats', v_total_seats,
    'max_seats', p_max_seats
  );
END;
$$;

-- =====================================================
-- VERIFICATION
-- =====================================================
SELECT 'check_daily_seat_limit function created successfully!' AS status;

