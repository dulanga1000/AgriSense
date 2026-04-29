import admin from "firebase-admin";

export interface NotificationPayload {
  title: string;
  description: string;
  type: "disease" | "weather" | "advisory" | "tip" | "market";
  userId: string;
  metadata?: Record<string, any>;
}

export interface NotificationModel {
  id: string;
  title: string;
  description: string;
  type: string;
  time: admin.firestore.Timestamp;
  isUnread: boolean;
  metadata?: Record<string, any>;
}

class NotificationService {
  private db = admin.firestore();

  /**
   * Create a notification for a specific user
   */
  async createNotification(
    payload: NotificationPayload
  ): Promise<{ success: boolean; notificationId?: string; error?: string }> {
    try {
      const { userId, title, description, type, metadata } = payload;

      if (!userId || !title || !description || !type) {
        return {
          success: false,
          error: "Missing required fields: userId, title, description, type",
        };
      }

      // Verify user exists
      const userDoc = await this.db.collection("users").doc(userId).get();
      if (!userDoc.exists) {
        return {
          success: false,
          error: `User ${userId} not found`,
        };
      }

      // Create notification in user's notifications subcollection
      const notificationRef = await this.db
        .collection("users")
        .doc(userId)
        .collection("notifications")
        .add({
          title,
          description,
          type,
          time: admin.firestore.Timestamp.now(),
          isUnread: true,
          metadata: metadata || {},
        });

      // Update notification with its own ID
      await notificationRef.update({
        id: notificationRef.id,
      });

      console.log(
        `✅ Notification created for user ${userId}: ${notificationRef.id}`
      );

      return {
        success: true,
        notificationId: notificationRef.id,
      };
    } catch (error) {
      const errorMessage =
        error instanceof Error ? error.message : "Unknown error";
      console.error("❌ Error creating notification:", errorMessage);
      return {
        success: false,
        error: errorMessage,
      };
    }
  }

  /**
   * Create disease alert notification
   */
  async createDiseaseAlert(
    userId: string,
    cropName: string,
    diseaseName: string,
    confidence: number,
    recommendations?: string
  ): Promise<{ success: boolean; notificationId?: string; error?: string }> {
    const title = `🌾 ${diseaseName} Detected`;
    const description = `${diseaseName} detected on your ${cropName} crop (${(confidence * 100).toFixed(0)}% confidence). Check crop advisory for treatment options.`;

    return this.createNotification({
      userId,
      title,
      description,
      type: "disease",
      metadata: {
        cropName,
        diseaseName,
        confidence,
        recommendations,
      },
    });
  }

  /**
   * Create weather alert notification
   */
  async createWeatherAlert(
    userId: string,
    alertType: string,
    location: string,
    description: string,
    severity: "low" | "medium" | "high" | "critical"
  ): Promise<{ success: boolean; notificationId?: string; error?: string }> {
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
    const severityText =
      severity === "critical"
        ? "Critical"
        : severity === "high"
          ? "High"
          : severity === "medium"
            ? "Moderate"
            : "Low";

    return this.createNotification({
      userId,
      title,
      description: `${severityText} ${alertType.replace(/_/g, " ")} alert for ${location}: ${description}`,
      type: "weather",
      metadata: {
        alertType,
        location,
        severity,
      },
    });
  }

  /**
   * Create crop advisory notification
   */
  async createCropAdvisory(
    userId: string,
    cropName: string,
    season: string,
    advisory: string,
    actionItems?: string[]
  ): Promise<{ success: boolean; notificationId?: string; error?: string }> {
    const title = `💡 Crop Advisory for ${cropName}`;
    const description = `New advisory for ${cropName} in ${season} season: ${advisory.substring(0, 120)}...`;

    return this.createNotification({
      userId,
      title,
      description,
      type: "advisory",
      metadata: {
        cropName,
        season,
        advisory,
        actionItems: actionItems || [],
      },
    });
  }

  /**
   * Create bulk notifications for multiple users
   */
  async createBulkNotifications(
    userIds: string[],
    title: string,
    description: string,
    type: "disease" | "weather" | "advisory" | "tip" | "market",
    metadata?: Record<string, any>
  ): Promise<{
    success: number;
    failed: number;
    results: Array<{ userId: string; success: boolean; error?: string }>;
  }> {
    const results = [];
    let successCount = 0;
    let failedCount = 0;

    for (const userId of userIds) {
      const result = await this.createNotification({
        userId,
        title,
        description,
        type,
        metadata,
      });

      results.push({
        userId,
        success: result.success,
        error: result.error,
      });

      if (result.success) {
        successCount++;
      } else {
        failedCount++;
      }
    }

    console.log(
      `📊 Bulk notifications sent: ${successCount} success, ${failedCount} failed`
    );

    return {
      success: successCount,
      failed: failedCount,
      results,
    };
  }

  /**
   * Validate notification before sending (optional check)
   */
  validateNotificationPayload(payload: any): {
    valid: boolean;
    errors: string[];
  } {
    const errors: string[] = [];

    if (!payload.userId) errors.push("userId is required");
    if (!payload.title) errors.push("title is required");
    if (!payload.description) errors.push("description is required");
    if (!payload.type) errors.push("type is required");

    const validTypes = ["disease", "weather", "advisory", "tip", "market"];
    if (payload.type && !validTypes.includes(payload.type)) {
      errors.push(
        `type must be one of: ${validTypes.join(", ")}, got: ${payload.type}`
      );
    }

    return {
      valid: errors.length === 0,
      errors,
    };
  }
}

export default new NotificationService();
