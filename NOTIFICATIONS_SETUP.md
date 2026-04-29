# Real Notifications Implementation Guide

This document outlines how to deploy and integrate real notifications for the AgriSense app.

## Overview

Real notifications are triggered by:
1. **Disease Detection** - When a disease is detected on a crop
2. **Weather Alerts** - When severe weather is forecasted for user's location
3. **Crop Advisory** - When new farming guidance is published for user's crops

## Backend API Endpoints

The backend provides REST API endpoints to create notifications:

### 1. Generic Notification
**Endpoint:** `POST /api/notifications/create`

```json
{
  "userId": "user123",
  "title": "Your Notification Title",
  "description": "Detailed description of the notification",
  "type": "disease|weather|advisory|tip|market",
  "metadata": {
    "key": "value"
  }
}
```

**Response:**
```json
{
  "success": true,
  "notificationId": "notif_id_123",
  "message": "Notification created successfully"
}
```

### 2. Disease Alert
**Endpoint:** `POST /api/notifications/disease-alert`

```json
{
  "userId": "user123",
  "cropName": "Tomato",
  "diseaseName": "Leaf Spot",
  "confidence": 0.85,
  "recommendations": "Apply fungicide treatment..."
}
```

### 3. Weather Alert
**Endpoint:** `POST /api/notifications/weather-alert`

```json
{
  "userId": "user123",
  "alertType": "storm",
  "location": "Colombo",
  "description": "Heavy rain and strong winds expected",
  "severity": "high"
}
```

**Severity levels:** `low | medium | high | critical`

### 4. Crop Advisory
**Endpoint:** `POST /api/notifications/crop-advisory`

```json
{
  "userId": "user123",
  "cropName": "Rice",
  "season": "Yala",
  "advisory": "Water management and fertilizer application guidelines...",
  "actionItems": [
    "Apply NPK fertilizer at 150kg/hectare",
    "Maintain water level at 5cm"
  ]
}
```

### 5. Bulk Notifications
**Endpoint:** `POST /api/notifications/bulk`

Send the same notification to multiple users:

```json
{
  "userIds": ["user1", "user2", "user3"],
  "title": "Weather Alert",
  "description": "Heavy rainfall expected in your region",
  "type": "weather",
  "metadata": {
    "region": "Western Province"
  }
}
```

## Cloud Functions Setup

### Prerequisites
- Firebase project with Firestore enabled
- Cloud Functions enabled
- Node.js 18+ (for local development)

### Step 1: Initialize Functions Project

```bash
cd agrisense
firebase init functions
```

Choose **TypeScript** when prompted.

### Step 2: Copy Cloud Functions Code

Replace the contents of `functions/src/index.ts` with:

```typescript
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

if (!admin.apps.length) {
  admin.initializeApp();
}

const db = admin.firestore();

// Copy all exported functions from notifications.ts
// (See firebase/functions/notifications.ts)
```

### Step 3: Deploy Functions

```bash
firebase deploy --only functions
```

This will deploy three trigger functions:
- `onDiseaseDetected` - Listens to `disease_results` collection
- `onWeatherAlertCreated` - Listens to `weather_alerts` collection
- `onCropAdvisoryCreated` - Listens to `crop_advisories` collection

### Step 4: Grant Cloud Functions Permissions

Ensure your Firebase service account has these permissions:
- `firestore.documents.create`
- `firestore.documents.read`
- `firestore.documents.update`

These are enabled by default in Cloud Functions runtime.

## Firestore Collection Structure

Notifications are stored at: `users/{userId}/notifications/{notificationId}`

```
users/
  ├─ user123/
  │  ├─ notifications/
  │  │  ├─ notif_1 {id, title, description, type, time, isUnread, metadata}
  │  │  ├─ notif_2 {...}
  
  # Disease results (auto-triggers disease notifications)
disease_results/
  ├─ result_1 {userId, cropName, diseaseName, confidence, recommendations}

  # Weather alerts (auto-triggers weather notifications)
weather_alerts/
  ├─ alert_1 {affectedUserIds[], alertType, location, message, severity}

  # Crop advisories (auto-triggers advisory notifications)
crop_advisories/
  ├─ advisory_1 {affectedUserIds[], cropName, season, advisory, actionItems}
```

## Triggering Notifications

### Option 1: From Your ML/AI Pipeline

After disease detection:
```typescript
const diseaseResult = {
  userId: "user123",
  cropName: "Tomato",
  diseaseName: "Early Blight",
  confidence: 0.92,
  recommendations: "Apply mancozeb fungicide..."
};

await db.collection("disease_results").add(diseaseResult);
// Cloud Function automatically creates notification
```

### Option 2: From Backend API

```bash
curl -X POST http://localhost:3000/api/notifications/disease-alert \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "user123",
    "cropName": "Tomato",
    "diseaseName": "Early Blight",
    "confidence": 0.92,
    "recommendations": "Apply mancozeb fungicide..."
  }'
```

### Option 3: From Flutter App (Admin SDK)

```dart
// In your Dart code
final response = await http.post(
  Uri.parse('http://your-backend.com/api/notifications/disease-alert'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({
    'userId': firebaseUser.uid,
    'cropName': 'Tomato',
    'diseaseName': 'Early Blight',
    'confidence': 0.92,
  }),
);
```

## User Notification Settings

Notifications respect user preferences stored in:
`users/{userId}/settings` or `users/{userId}/notificationSettings`

```json
{
  "notificationsEnabled": true,
  "diseaseAlertsEnabled": true,
  "weatherUpdatesEnabled": true,
  "farmingTipsEnabled": true
}
```

Cloud Functions check these before creating notifications.

## Testing

### Test with Backend API

Use Postman or curl to test endpoints:

```bash
# Test disease alert
curl -X POST http://localhost:3000/api/notifications/disease-alert \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "test_user_id",
    "cropName": "Tomato",
    "diseaseName": "Leaf Spot",
    "confidence": 0.85
  }'

# Test weather alert
curl -X POST http://localhost:3000/api/notifications/weather-alert \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "test_user_id",
    "alertType": "storm",
    "location": "Colombo",
    "description": "Heavy rain expected",
    "severity": "high"
  }'

# Test crop advisory
curl -X POST http://localhost:3000/api/notifications/crop-advisory \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "test_user_id",
    "cropName": "Rice",
    "season": "Yala",
    "advisory": "Apply NPK fertilizer..."
  }'
```

### Test with Cloud Functions

Use Firebase Console to test callable functions:

1. Go to Firebase Console > Functions
2. Select `sendTestNotification`
3. Click "Test the function"
4. Set request data: `{"notificationType": "disease"}`
5. Check Firestore for new notification

## Flutter App Integration

The Flutter app already supports the notification system:

1. **NotificationRepository** fetches from `users/{userId}/notifications`
2. **NotificationState** polls every 10 seconds for new notifications
3. **NotificationScreen** displays all notifications with filtering
4. Notifications update in real-time when new ones are created

No additional changes needed in the app!

## Monitoring & Debugging

### View Cloud Function Logs

```bash
firebase functions:log
```

Or in Firebase Console:
1. Go to Cloud Functions
2. Click on function name
3. View logs in Logs tab

### Check Firestore Collections

```bash
# View all disease results
firestore_emulator --project=your-project

# Or use Firebase Console
```

### Common Issues

| Issue | Solution |
|-------|----------|
| Notifications not appearing | Check user notification settings, verify userId exists |
| Cloud Function not triggering | Ensure document structure matches trigger (disease_results, weather_alerts, etc.) |
| Permissions error | Grant Cloud Functions service account appropriate roles in IAM |
| Timeouts | Increase function timeout in firebase.json (default 60s) |

## Next Steps

1. ✅ Deploy backend API
2. ✅ Deploy Cloud Functions
3. ✅ Set up Firestore triggers
4. Test with sample data
5. Integrate with ML disease detection pipeline
6. Set up weather data integration
7. Create admin UI to publish crop advisories

## Support

For issues or questions:
- Check Firebase documentation: https://firebase.google.com/docs
- Review Cloud Functions logs for errors
- Verify Firestore collection permissions
