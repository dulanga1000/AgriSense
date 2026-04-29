# Real Notifications - Quick Reference

## What Was Done

✅ **Backend Implementation**
- Created `notificationService.ts` - Service to create notifications in Firestore
- Created `notificationController.ts` - REST API endpoints for notifications
- Created `notificationRoutes.ts` - API routing for all notification endpoints
- Integrated notifications routes into server

✅ **API Endpoints Available**
1. `POST /api/notifications/create` - Generic notifications
2. `POST /api/notifications/disease-alert` - Disease detection alerts
3. `POST /api/notifications/weather-alert` - Weather warnings
4. `POST /api/notifications/crop-advisory` - Farming guidance
5. `POST /api/notifications/bulk` - Send to multiple users

✅ **Cloud Functions**
- `onDiseaseDetected` - Auto-trigger when disease detected
- `onWeatherAlertCreated` - Auto-trigger weather warnings
- `onCropAdvisoryCreated` - Auto-trigger crop advisories

✅ **Documentation**
- `NOTIFICATIONS_SETUP.md` - Complete setup and deployment guide
- `test-notifications.ts` - Test script for API endpoints

## What Still Needs to Be Done

1. **Deploy Backend**
   ```bash
   cd agrisense-otp-backend
   npm install
   npm run build
   npm start
   ```

2. **Deploy Cloud Functions**
   ```bash
   cd agrisense
   firebase init functions  # If not already initialized
   # Copy notifications.ts to functions/src/
   firebase deploy --only functions
   ```

3. **Test the System**
   - Update `TEST_USER_ID` in `test-notifications.ts`
   - Run: `npx ts-node test-notifications.ts`
   - Check Firestore for created notifications

## How Notifications Flow

```
┌─ Disease Detection (ML Model)
│  └─ Saved to: disease_results/{resultId}
│     └─ Cloud Function: onDiseaseDetected
│        └─ Creates: users/{userId}/notifications/{notifId}
│           └─ Displayed in Flutter App (auto-refreshes every 10s)

┌─ Weather Alert (External API / Admin)
│  └─ Saved to: weather_alerts/{alertId}
│     └─ Cloud Function: onWeatherAlertCreated
│        └─ Creates: users/{userId}/notifications/{notifId}

┌─ Crop Advisory (Admin / Expert)
│  └─ Saved to: crop_advisories/{advisoryId}
│     └─ Cloud Function: onCropAdvisoryCreated
│        └─ Creates: users/{userId}/notifications/{notifId}
```

## API Examples

### Send Disease Alert
```bash
curl -X POST http://localhost:3000/api/notifications/disease-alert \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "user123",
    "cropName": "Tomato",
    "diseaseName": "Early Blight",
    "confidence": 0.92,
    "recommendations": "Apply fungicide"
  }'
```

### Send Weather Alert
```bash
curl -X POST http://localhost:3000/api/notifications/weather-alert \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "user123",
    "alertType": "storm",
    "location": "Colombo",
    "description": "Heavy rain expected",
    "severity": "high"
  }'
```

### Send Crop Advisory
```bash
curl -X POST http://localhost:3000/api/notifications/crop-advisory \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "user123",
    "cropName": "Rice",
    "season": "Yala",
    "advisory": "Apply NPK fertilizer at 150kg/hectare"
  }'
```

## Notification Settings

Users can control notifications via Flutter app settings:
- Enable/disable all notifications
- Enable/disable disease alerts
- Enable/disable weather updates
- Enable/disable farming tips

Cloud Functions respect these settings before creating notifications.

## Firestore Structure

```
users/
  ├─ {userId}/
  │  ├─ notifications/
  │  │  ├─ {notifId}
  │  │  │  ├─ id: string
  │  │  │  ├─ title: string
  │  │  │  ├─ description: string
  │  │  │  ├─ type: "disease" | "weather" | "advisory"
  │  │  │  ├─ time: Timestamp
  │  │  │  ├─ isUnread: boolean
  │  │  │  └─ metadata: {object}
```

## Files Changed/Created

**Backend (Node.js/TypeScript):**
- ✅ `src/services/notificationService.ts` (created)
- ✅ `src/controllers/notificationController.ts` (created)
- ✅ `src/routes/notificationRoutes.ts` (created)
- ✅ `src/server.ts` (updated - added route)
- ✅ `test-notifications.ts` (created)

**Cloud Functions:**
- ✅ `firebase/functions/notifications.ts` (created)

**Documentation:**
- ✅ `NOTIFICATIONS_SETUP.md` (created)
- ✅ `NOTIFICATIONS_QUICK_REF.md` (this file)

**Flutter App:**
- ℹ️ No changes needed - already supports notifications!

## Troubleshooting

**Issue: "User not found"**
- Make sure the userId exists in Firestore users collection

**Issue: Notifications not appearing in app**
- Check Firestore for new notifications
- Verify user has notifications enabled in settings
- Check app is polling (every 10 seconds)

**Issue: Cloud Function not triggering**
- Verify collection name matches trigger (disease_results, weather_alerts, crop_advisories)
- Check Cloud Function logs: `firebase functions:log`

**Issue: 404 on endpoints**
- Verify backend is running on port 3000
- Check routes are imported in server.ts

## Next: Integration Points

1. **Disease Detection Pipeline**
   - After ML model detects disease → POST to `/api/notifications/disease-alert`

2. **Weather Service**
   - When severe weather → POST to `/api/notifications/weather-alert`
   - OR write to `weather_alerts` collection → Cloud Function triggers

3. **Admin Panel**
   - UI to publish crop advisories
   - POST to `/api/notifications/crop-advisory` or `/bulk`

4. **Push Notifications** (Optional Future)
   - Use Firebase Cloud Messaging (FCM)
   - Send device notifications in addition to in-app

## Support

See `NOTIFICATIONS_SETUP.md` for detailed documentation and troubleshooting.
