# Firestore Rules - Fix Permission Denied Error

## Problem

You're getting this error:
```
W/Firestore: Listen for QueryWrapper... failed: Status{code=PERMISSION_DENIED, description=Missing or insufficient permissions.
```

**Cause:** Your Firestore security rules don't allow the Flutter app to read the notifications subcollection.

## Solution

### Step 1: Update Firestore Rules

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your AgriSense project
3. Go to **Firestore Database** > **Rules** tab
4. Replace the entire content with:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow users to read and write their own data
    match /users/{uid}/{document=**} {
      allow read, write: if request.auth.uid == uid;
    }

    // Specifically allow notifications
    match /users/{uid}/notifications/{notificationId} {
      allow read: if request.auth.uid == uid;
      allow write: if request.auth.uid == uid;
    }

    // Collections for Cloud Functions (admin/service account writes)
    match /disease_results/{document=**} {
      allow read: if request.auth != null;
      allow write: if request.auth.token.admin == true;
    }

    match /weather_alerts/{document=**} {
      allow read: if request.auth != null;
      allow write: if request.auth.token.admin == true;
    }

    match /crop_advisories/{document=**} {
      allow read: if request.auth != null;
      allow write: if request.auth.token.admin == true;
    }

    // Public reference collections
    match /crops/{document=**} {
      allow read: if request.auth != null;
      allow write: if request.auth.token.admin == true;
    }

    match /diseases/{document=**} {
      allow read: if request.auth != null;
      allow write: if request.auth.token.admin == true;
    }

    match /seasons/{document=**} {
      allow read: if request.auth != null;
      allow write: if request.auth.token.admin == true;
    }

    // Deny everything else
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

5. Click **Publish**

### Step 2: Alternative - Deploy via Firebase CLI

If you have Firebase CLI installed:

```bash
cd agrisense
firebase deploy --only firestore:rules
```

### Step 3: Verify Rules

Test the rules in Firebase Console:
1. Go to **Rules** > **Test** tab
2. Click "Run" to validate the rules
3. Rules should compile without errors

### Step 4: Test in Flutter App

1. Hot reload or restart the Flutter app
2. Navigate to Notifications tab
3. You should now see notifications loading
4. Error should be gone

## What These Rules Do

✅ **Users can:**
- Read their own notifications
- Read/write their own profile data

✅ **Cloud Functions can:**
- Write to disease_results, weather_alerts, crop_advisories
- Cloud Functions use service account (elevated permissions)

✅ **Everyone can:**
- Read reference data (crops, diseases, seasons)

✅ **Denied:**
- Unauthenticated access
- Cross-user data access
- Unauthorized collection modifications

## If Still Getting Permission Denied

### Debug Steps

1. **Check User Authentication**
   ```dart
   final user = FirebaseAuth.instance.currentUser;
   print('Current user: ${user?.uid}');
   ```

2. **Check Firestore Path**
   - Should be: `users/{uid}/notifications/{notificationId}`
   - Make sure `uid` is not null

3. **Check Collection Names**
   - Verify exact spelling (case-sensitive):
     - `users` ✅
     - `notifications` ✅
     - NOT `Notifications` or `user` or `notification`

4. **View Firestore Rules Evaluation**
   - Go to Firebase Console > Firestore > Rules > Test
   - Test path: `/users/RD2avO6n3EaZmpgvvmkL1YgM70Y2/notifications`
   - Resource type: `Document` (or `Collection` for list queries)
   - Request context: Set `auth.uid` to your actual user ID

5. **Check User Document Exists**
   - Go to Firestore > Data
   - Navigate to `users/{uid}`
   - Verify user document exists (doesn't need data, just the doc)

## File Location

The rules file is also available at:
```
agrisense/firestore.rules
```

Deploy with:
```bash
firebase deploy --only firestore:rules
```

## Common Mistakes

❌ **Wrong Path Format**
```
users/notifications (wrong - missing {uid})
users/{uid}/notifications (correct)
```

❌ **Typo in Collection Name**
```
users/{uid}/Notifications (wrong - capital N)
users/{uid}/notifications (correct)
```

❌ **User Document Doesn't Exist**
- Notifications collection needs parent user document
- Create user doc if it doesn't exist

❌ **Not Published**
- Always click "Publish" after editing rules
- Changes don't apply until published

## Quick Fix Summary

1. Copy the rules above
2. Paste in Firebase Console > Firestore > Rules
3. Click Publish
4. Reload Flutter app
5. Notifications should now load ✅

---

**Need Help?**
- Check Firestore rules evaluation tool (Firebase Console > Rules > Test)
- View real-time logs (Firebase Console > Firestore > Logs)
- Run Flutter with verbose logging: `flutter run -v`
