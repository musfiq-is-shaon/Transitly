# TODO - Date Inconsistency Bug Fixes

## Summary of Fixes Applied

### 1. Fixed Server-Side Timezone Handling
**Problem:** The server was using timezone-dependent calculations that didn't work correctly in all environments.

**Fix:** Changed all server-side date comparisons to use UTC consistently:
- `canBookSchedule()` now uses `new Date()` (UTC) instead of `getNowInBangladeshTime()`
- `getMinutesUntilDeparture()` now uses `new Date()` (UTC) instead of `getNowInBangladeshTime()`
- `searchSchedules()` now uses `getNowUTC()` instead of `getNowInBangladeshTime()`

### 2. Fixed getDayBoundsLocal() in search/page.tsx
**Problem:** Search for Feb 5 was showing Feb 6 midnight tickets.

**Fix:** Changed UTC bounds to properly convert Bangladesh local time:
```typescript
const startOfDayUTC = new Date(Date.UTC(year, month, day - 1, 18, 0, 0));
const endOfDayUTC = new Date(Date.UTC(year, month, day, 18, 0, 0));
```

### 3. Fixed Timezone Calculation in utils.ts
**Problem:** `getNowInBangladeshTime()` was adding 12 hours instead of 6 for UTC+6 timezones.

**Fix:** Corrected the calculation:
```typescript
const utcTime = now.getTime() + (now.getTimezoneOffset() * 60 * 1000);
return new Date(utcTime + (6 * 60 * 60 * 1000));
```

### 4. Increased Refresh Interval
Changed auto-refresh from 10 seconds to 60 seconds to reduce API calls.

## Files Modified
- `src/lib/utils.ts` - Fixed timezone calculations
- `src/actions/bookings.ts` - Fixed server-side search to use UTC
- `src/app/search/page.tsx` - Fixed date bounds calculation

