# 🔐 Fix Firestore Permission Denied Error

## The Problem
```
W/Firestore(31201): Listen for QueryWrapper... failed: Status{code=PERMISSION_DENIED}
I/flutter: Notification polling failed: The caller does not have permission...
```

**Root Cause:** Firestore security rules don't allow the Flutter app to read notifications.

## The Solution (2 Options)

---

## Option 1: Manual Fix (Fastest)

### Step 1: Go to Firebase Console
1. Open https://console.firebase.google.com
2. Select your AgriSense project
3. Click **Firestore Database** on the left
4. Click the **Rules** tab

### Step 2: Replace the Rules
Copy this and paste into the Rules editor:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow users to read/write their own data
    match /users/{uid}/{document=**} {
      allow read, write: if request.auth.uid == uid;
    }

    // Public collections
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

### Step 3: Click **Publish**

### Step 4: Test in Flutter App
- Hot reload the app
- Go to Notifications tab
- ✅ Notifications should now load!

---

## Option 2: Deploy via CLI

### Step 1: Terminal
```bash
cd agrisense
firebase deploy --only firestore:rules
```

### Step 2: Wait for Success
```
✔ firestore:rules have been successfully deployed to your Firestore project
```

### Step 3: Reload Flutter App
- Hot reload or restart
- ✅ Notifications should now load!

---

## Verify It Works

### In Flutter App
1. Go to Notifications tab
2. Should see test notifications (if you ran the test script)
3. Spinner loading should stop
4. Notification list should appear

### In Firebase Console
1. Go to Firestore > Data
2. Navigate to: `users` > your user ID > `notifications`
3. You should see notification documents

### If Still Not Working

**Check 1: Are you logged in?**
```dart
final user = FirebaseAuth.instance.currentUser;
debugPrint('User: ${user?.uid}');
```
Should print a user ID, not null.

**Check 2: Does the user document exist?**
- Go to Firebase Console > Firestore > Data
- Click `users`
- Click your user ID
- If document doesn't exist, create it (can be empty)

**Check 3: Verify the exact error**
- In Flutter console, look for the full error message
- Should show permission denied at path `users/{uid}/notifications`

**Check 4: Test the rules**
1. Firebase Console > Firestore > Rules > **Test** button
2. Test path: `users/YOUR_UID/notifications`
3. Select "Test read access"
4. Should show ✅ Allows access

---

## What the Rules Mean

```firestore
match /users/{uid}/{document=**} {
  allow read, write: if request.auth.uid == uid;
}
```

This means:
- ✅ Users can read their own data
- ✅ Users can write to their own data  
- ✅ This includes `notifications` subcollection
- ❌ Users CANNOT read other users' data
- ❌ Unauthenticated users cannot access

---

## Files Updated

- ✅ `firestore.rules` - Created with proper rules
- ✅ `firebase.json` - Created with Firebase configuration
- 📖 `FIRESTORE_RULES_FIX.md` - Detailed troubleshooting guide

---

## Still Having Issues?

### Check the Firestore Logs
1. Firebase Console > Firestore > Logs
2. Look for "PERMISSION_DENIED" entries
3. Check the exact path that failed
4. Verify rules allow that path

### Common Issues

| Error | Fix |
|-------|-----|
| Users can't read notifications | Add `allow read` rule for user's own data |
| Cloud Functions can't write | Add admin check or service account rules |
| Unauthenticated access denied | That's correct - require auth |
| Collection doesn't exist | Collections auto-create on first write |

---

## Quick Checklist

- [ ] Copied the rules above
- [ ] Pasted in Firebase Console Rules tab  
- [ ] Clicked Publish
- [ ] Hot reloaded Flutter app
- [ ] Notifications now load ✅

---

## Need More Details?

See `FIRESTORE_RULES_FIX.md` for comprehensive troubleshooting.

**Deploy command reference:**
```bash
firebase deploy --only firestore:rules              # Just rules
firebase deploy --only functions                    # Just functions
firebase deploy --only firestore:rules,functions    # Both
firebase deploy                                     # Everything
```
