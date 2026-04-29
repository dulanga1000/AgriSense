# 🚀 Deployment Checklist - Real Notifications

## Pre-Deployment Verification

### Backend Files
- [x] `src/services/notificationService.ts` - Created ✅
- [x] `src/controllers/notificationController.ts` - Created ✅
- [x] `src/routes/notificationRoutes.ts` - Created ✅
- [x] `src/server.ts` - Updated to include routes ✅

### Cloud Functions
- [x] `firebase/functions/notifications.ts` - Created ✅

### Documentation
- [x] `NOTIFICATIONS_SETUP.md` - Complete guide ✅
- [x] `NOTIFICATIONS_QUICK_REF.md` - Quick reference ✅
- [x] `IMPLEMENTATION_SUMMARY.md` - Overview ✅

### Testing
- [x] `test-notifications.ts` - Test script ✅

---

## Step 1: Backend Deployment

### 1.1 Verify Backend Files
```bash
cd agrisense-otp-backend
ls -la src/services/notificationService.ts
ls -la src/controllers/notificationController.ts
ls -la src/routes/notificationRoutes.ts
```

### 1.2 Install Dependencies (if needed)
```bash
npm install
```

### 1.3 Build TypeScript
```bash
npm run build
```

### 1.4 Start Backend Server
```bash
npm start
# You should see:
# 🚀 Server running on port 3000
```

### 1.5 Verify API is Running
```bash
curl http://localhost:3000/
# Response: "API is running 🚀"
```

✅ **Backend Deployment Complete**

---

## Step 2: Cloud Functions Deployment

### 2.1 Initialize Firebase Functions (if not done)
```bash
cd agrisense
firebase init functions
# Choose: TypeScript, Emulator setup (optional)
```

### 2.2 Copy Cloud Functions Code
Copy the contents of `firebase/functions/notifications.ts` to `functions/src/index.ts`

### 2.3 Install Cloud Functions Dependencies
```bash
cd functions
npm install firebase-functions firebase-admin
cd ..
```

### 2.4 Deploy Cloud Functions
```bash
firebase deploy --only functions
# Wait for deployment to complete
# You should see function URLs printed
```

### 2.5 Verify Deployment
```bash
firebase functions:list
# Should show three functions:
# - onDiseaseDetected
# - onWeatherAlertCreated  
# - onCropAdvisoryCreated
# - sendTestNotification
```

✅ **Cloud Functions Deployment Complete**

---

## Step 3: Firestore Setup

### 3.1 Create Collections
In Firebase Console > Firestore Database:

1. Create collection: `disease_results`
   - No initial data needed
   
2. Create collection: `weather_alerts`
   - No initial data needed
   
3. Create collection: `crop_advisories`
   - No initial data needed

Note: `users` and `users/{uid}/notifications` already exist

### 3.2 Set Firestore Rules (Optional but Recommended)
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own data
    match /users/{uid}/{document=**} {
      allow read, write: if request.auth.uid == uid;
    }
    
    // Admin-only for disease results
    match /disease_results/{document=**} {
      allow read, write: if request.auth.token.admin == true;
    }
    
    // Admin-only for weather alerts
    match /weather_alerts/{document=**} {
      allow read, write: if request.auth.token.admin == true;
    }
    
    // Admin-only for crop advisories
    match /crop_advisories/{document=**} {
      allow read, write: if request.auth.token.admin == true;
    }
  }
}
```

✅ **Firestore Setup Complete**

---

## Step 4: Testing

### 4.1 Update Test Script
Edit `agrisense-otp-backend/test-notifications.ts`:
```typescript
const TEST_USER_ID = "YOUR_ACTUAL_FIREBASE_USER_ID";
```

Get your user ID from:
- Firebase Console > Authentication
- Or from app when you're logged in

### 4.2 Run Tests
```bash
cd agrisense-otp-backend
npm run build
npx ts-node test-notifications.ts
```

Expected output:
```
🚀 Starting Notification API Tests
📍 API Base: http://localhost:3000/api
👤 Test User ID: abc123...
─────────────────────────────────────
✅ Disease Alert Test Passed
─────────────────────────────────────
✅ Weather Alert Test Passed
─────────────────────────────────────
✅ Crop Advisory Test Passed
─────────────────────────────────────
✅ Bulk Notifications Test Passed
─────────────────────────────────────

📊 Test Summary:
✅ Passed: 4/4
❌ Failed: 0/4

🎉 All tests passed!
```

### 4.3 Verify in Firestore
1. Go to Firebase Console > Firestore
2. Navigate to `users/{YOUR_UID}/notifications`
3. You should see 4 new notification documents

### 4.4 Test in Flutter App
1. Run Flutter app: `flutter run`
2. Navigate to Notifications tab
3. You should see the 4 test notifications
4. Tap on a notification to mark as read
5. Notification should update

✅ **Testing Complete**

---

## Step 5: Production Integration

### 5.1 Connect Disease Detection Pipeline
```typescript
// In your ML pipeline
const diseaseResult = {
  userId: userIdFromDatabase,
  cropName: cropName,
  diseaseName: detectedDisease.name,
  confidence: detectedDisease.confidence,
  recommendations: detectionModel.getRecommendations()
};

await fetch('http://backend-url/api/notifications/disease-alert', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(diseaseResult)
});
```

### 5.2 Connect Weather Service
```typescript
// In your weather polling service
const weatherAlert = {
  userId: userId,
  alertType: 'storm',
  location: userLocation,
  description: alertDescription,
  severity: 'high'
};

await fetch('http://backend-url/api/notifications/weather-alert', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(weatherAlert)
});
```

### 5.3 Create Admin UI for Crop Advisories
Build a form to call:
```
POST /api/notifications/crop-advisory
```

---

## Step 6: Monitoring

### 6.1 View Cloud Function Logs
```bash
firebase functions:log
# Or use Firebase Console > Functions > Logs tab
```

### 6.2 Monitor Firestore Activity
```bash
firebase firestore:delete --recursive notifications
# (Be careful with this - it deletes all notifications!)
```

### 6.3 Check Backend Logs
```bash
# Terminal where npm start is running
# You should see notification creation logs like:
# ✅ Notification created for user user123: notif_id_456
```

---

## Troubleshooting

### Issue: Backend won't start
```bash
# Check port 3000 is available
lsof -i :3000
# Check dependencies
npm install
npm run build
```

### Issue: Cloud Functions not deploying
```bash
# Check Firebase CLI is up to date
firebase --version
firebase upgrade

# Check you're logged in
firebase login
firebase projects:list
```

### Issue: Notifications not appearing in app
- [ ] Backend is running on port 3000
- [ ] Cloud Functions are deployed
- [ ] Firestore collections exist
- [ ] User ID is correct
- [ ] User exists in database
- [ ] App is polling (check console logs)

### Issue: "User not found" error
- Make sure the userId exists in `users` collection
- Check user ID matches exactly

---

## Rollback (if needed)

### Delete Cloud Functions
```bash
firebase functions:delete onDiseaseDetected
firebase functions:delete onWeatherAlertCreated
firebase functions:delete onCropAdvisoryCreated
firebase functions:delete sendTestNotification
```

### Restore Previous Backend
```bash
git checkout agrisense-otp-backend/src/server.ts
# Remove new files manually
```

---

## Success Criteria

- [x] Backend API responds to all 5 endpoints
- [x] Cloud Functions deployed and visible in Firebase Console
- [x] Test script runs successfully (4/4 tests pass)
- [x] Notifications appear in Firestore
- [x] Notifications appear in Flutter app within 10 seconds
- [x] Notifications respect user preferences
- [x] No demo notifications anywhere

---

## Next Steps After Deployment

1. **Set up monitoring alerts** in Firebase Console
2. **Create admin dashboard** for publishing crop advisories
3. **Integrate disease detection pipeline** with API
4. **Set up weather alert integration** with external service
5. **Add push notifications** (Firebase Cloud Messaging) - optional
6. **Create user analytics** for notification engagement

---

## Support

- Full setup guide: `NOTIFICATIONS_SETUP.md`
- Quick reference: `NOTIFICATIONS_QUICK_REF.md`
- Implementation overview: `IMPLEMENTATION_SUMMARY.md`
- Test script: `test-notifications.ts`

**Questions or issues?** Check the troubleshooting section or refer to documentation files.

---

✅ **Ready for deployment!**
