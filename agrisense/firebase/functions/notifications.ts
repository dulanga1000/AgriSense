/**
 * Firebase Cloud Functions for AgriSense Notifications
 * 
 * Deploy these functions to Firebase Console:
 * 1. Go to Firebase Console > Functions
 * 2. Create a new Node.js function
 * 3. Copy the relevant function below
 * 4. Deploy with `firebase deploy --only functions`
 * 
 * OR use Google Cloud Functions console:
 * 1. Go to cloud.google.com > Cloud Functions
 * 2. Create new function
 * 3. Set trigger and environment as specified
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Initialize Firebase Admin if not already initialized
if (!admin.apps.length) {
  admin.initializeApp();
}

const db = admin.firestore();

// ============================================================================
// DISEASE ALERT FUNCTION
// Trigger: Firestore Document Write on diseases/{diseaseId}
// ============================================================================
export const onDiseaseDetected = functions.firestore
  .document("disease_results/{resultId}")
  .onCreate(async (snapshot, context) => {
    try {
      const diseaseData = snapshot.data();
      const { userId, cropName, diseaseName, confidence, recommendations } =
        diseaseData;

      if (!userId) {
        console.log("❌ No userId in disease document");
        return;
      }

      // Check if user has disease alerts enabled
      const userSettings = await db.collection("users").doc(userId).get();
      const userSettingsData = userSettings.data() || {};

      if (
        userSettingsData.notificationSettings?.diseaseAlertsEnabled === false
      ) {
        console.log(`⏭️  Disease alerts disabled for user ${userId}`);
        return;
      }

      // Create notification
      const notification = {
        id: "", // Will be set to doc ID
        title: `🌾 ${diseaseName} Detected`,
        description: `${diseaseName} detected on your ${cropName} crop (${(confidence * 100).toFixed(0)}% confidence). Check crop advisory for treatment options.`,
        type: "disease",
        time: admin.firestore.Timestamp.now(),
        isUnread: true,
        metadata: {
          diseaseResultId: context.params.resultId,
          cropName,
          diseaseName,
          confidence,
          recommendations,
        },
      };

      const notifRef = await db
        .collection("users")
        .doc(userId)
        .collection("notifications")
        .add(notification);

      // Update with own ID
      await notifRef.update({ id: notifRef.id });

      console.log(`✅ Disease alert sent to user ${userId}: ${notifRef.id}`);
    } catch (error) {
      console.error("❌ Error in onDiseaseDetected:", error);
    }
  });

// ============================================================================
// WEATHER ALERT FUNCTION
// Trigger: Firestore Document Write on weather_alerts/{alertId}
// ============================================================================
export const onWeatherAlertCreated = functions.firestore
  .document("weather_alerts/{alertId}")
  .onCreate(async (snapshot, context) => {
    try {
      const alertData = snapshot.data();
      const { affectedUserIds, alertType, location, message, severity } =
        alertData;

      if (!affectedUserIds || !Array.isArray(affectedUserIds)) {
        console.log("❌ No affectedUserIds in weather alert document");
        return;
      }

      const icons: Record<string, string> = {
        rain: "🌧️",
        storm: "⛈️",
        hail: "🧊",
        frost: "❄️",
        drought: "🏜️",
        high_temp: "🌡️",
        low_temp: "🥶",
        wind: "💨",
      };

      const icon = icons[alertType] || "⚠️";
      const title = `${icon} ${alertType.replace(/_/g, " ")} Alert`;

      const batch = db.batch();
      let successCount = 0;

      for (const userId of affectedUserIds) {
        // Check if user has weather alerts enabled
        const userSettings = await db.collection("users").doc(userId).get();
        const userSettingsData = userSettings.data() || {};

        if (
          userSettingsData.notificationSettings?.weatherUpdatesEnabled ===
          false
        ) {
          console.log(`⏭️  Weather alerts disabled for user ${userId}`);
          continue;
        }

        const notificationRef = db
          .collection("users")
          .doc(userId)
          .collection("notifications")
          .doc();

        const notification = {
          id: notificationRef.id,
          title,
          description: `${alertType.replace(/_/g, " ")} alert for ${location}: ${message}`,
          type: "weather",
          time: admin.firestore.Timestamp.now(),
          isUnread: true,
          metadata: {
            alertId: context.params.alertId,
            alertType,
            location,
            severity,
          },
        };

        batch.set(notificationRef, notification);
        successCount++;
      }

      await batch.commit();
      console.log(
        `✅ Weather alert sent to ${successCount} users: ${context.params.alertId}`
      );
    } catch (error) {
      console.error("❌ Error in onWeatherAlertCreated:", error);
    }
  });

// ============================================================================
// CROP ADVISORY FUNCTION
// Trigger: Firestore Document Write on crop_advisories/{advisoryId}
// ============================================================================
export const onCropAdvisoryCreated = functions.firestore
  .document("crop_advisories/{advisoryId}")
  .onCreate(async (snapshot, context) => {
    try {
      const advisoryData = snapshot.data();
      const { affectedUserIds, cropName, season, advisory, actionItems } =
        advisoryData;

      if (!affectedUserIds || !Array.isArray(affectedUserIds)) {
        console.log("❌ No affectedUserIds in crop advisory document");
        return;
      }

      const title = `💡 Crop Advisory for ${cropName}`;
      const description = `New advisory for ${cropName} in ${season} season: ${advisory.substring(0, 120)}...`;

      const batch = db.batch();
      let successCount = 0;

      for (const userId of affectedUserIds) {
        // Check if user has farming tips enabled
        const userSettings = await db.collection("users").doc(userId).get();
        const userSettingsData = userSettings.data() || {};

        if (
          userSettingsData.notificationSettings?.farmingTipsEnabled === false
        ) {
          console.log(`⏭️  Farming tips disabled for user ${userId}`);
          continue;
        }

        const notificationRef = db
          .collection("users")
          .doc(userId)
          .collection("notifications")
          .doc();

        const notification = {
          id: notificationRef.id,
          title,
          description,
          type: "advisory",
          time: admin.firestore.Timestamp.now(),
          isUnread: true,
          metadata: {
            advisoryId: context.params.advisoryId,
            cropName,
            season,
            advisory,
            actionItems: actionItems || [],
          },
        };

        batch.set(notificationRef, notification);
        successCount++;
      }

      await batch.commit();
      console.log(
        `✅ Crop advisory sent to ${successCount} users: ${context.params.advisoryId}`
      );
    } catch (error) {
      console.error("❌ Error in onCropAdvisoryCreated:", error);
    }
  });

// ============================================================================
// CALLABLE FUNCTION FOR MANUAL TESTING
// Call from client or backend
// ============================================================================
export const sendTestNotification = functions.https.onCall(
  async (data, context) => {
    try {
      // Verify authentication
      if (!context.auth) {
        throw new functions.https.HttpsError(
          "unauthenticated",
          "User must be authenticated"
        );
      }

      const { notificationType } = data;
      const userId = context.auth.uid;

      if (notificationType === "disease") {
        // Create test disease alert
        const notifRef = await db
          .collection("users")
          .doc(userId)
          .collection("notifications")
          .add({
            id: "",
            title: "🌾 Leaf Spot Detected (TEST)",
            description:
              "Test disease alert for Tomato crop (85% confidence). Check crop advisory for treatment options.",
            type: "disease",
            time: admin.firestore.Timestamp.now(),
            isUnread: true,
            metadata: {
              cropName: "Tomato",
              diseaseName: "Leaf Spot",
              confidence: 0.85,
            },
          });

        await notifRef.update({ id: notifRef.id });
        return { success: true, notificationId: notifRef.id };
      } else if (notificationType === "weather") {
        // Create test weather alert
        const notifRef = await db
          .collection("users")
          .doc(userId)
          .collection("notifications")
          .add({
            id: "",
            title: "⛈️ Storm Alert (TEST)",
            description:
              "High storm alert for Colombo: Heavy rain and strong winds expected. Secure your crops.",
            type: "weather",
            time: admin.firestore.Timestamp.now(),
            isUnread: true,
            metadata: {
              alertType: "storm",
              location: "Colombo",
              severity: "high",
            },
          });

        await notifRef.update({ id: notifRef.id });
        return { success: true, notificationId: notifRef.id };
      } else if (notificationType === "advisory") {
        // Create test crop advisory
        const notifRef = await db
          .collection("users")
          .doc(userId)
          .collection("notifications")
          .add({
            id: "",
            title: "💡 Crop Advisory for Rice (TEST)",
            description:
              "New advisory for Rice in Yala season: Water management and fertilizer application guidelines updated...",
            type: "advisory",
            time: admin.firestore.Timestamp.now(),
            isUnread: true,
            metadata: {
              cropName: "Rice",
              season: "Yala",
            },
          });

        await notifRef.update({ id: notifRef.id });
        return { success: true, notificationId: notifRef.id };
      }

      throw new functions.https.HttpsError(
        "invalid-argument",
        `Unknown notificationType: ${notificationType}`
      );
    } catch (error) {
      console.error("❌ Error in sendTestNotification:", error);
      throw error;
    }
  }
);
