import { Request, Response } from "express";
import notificationService, {
  NotificationPayload,
} from "../services/notificationService";

class NotificationController {
  /**
   * POST /api/notifications/create
   * Create a single notification
   */
  async createNotification(req: Request, res: Response): Promise<void> {
    try {
      const payload: NotificationPayload = req.body;

      // Validate payload
      const validation = notificationService.validateNotificationPayload(
        payload
      );
      if (!validation.valid) {
        res.status(400).json({
          success: false,
          errors: validation.errors,
        });
        return;
      }

      const result = await notificationService.createNotification(payload);

      if (!result.success) {
        res.status(400).json({
          success: false,
          error: result.error,
        });
        return;
      }

      res.status(201).json({
        success: true,
        notificationId: result.notificationId,
        message: "Notification created successfully",
      });
    } catch (error) {
      const errorMessage =
        error instanceof Error ? error.message : "Unknown error";
      console.error("Error in createNotification:", errorMessage);
      res.status(500).json({
        success: false,
        error: errorMessage,
      });
    }
  }

  /**
   * POST /api/notifications/disease-alert
   * Create a disease alert notification
   */
  async createDiseaseAlert(req: Request, res: Response): Promise<void> {
    try {
      const { userId, cropName, diseaseName, confidence, recommendations } =
        req.body;

      if (!userId || !cropName || !diseaseName || confidence === undefined) {
        res.status(400).json({
          success: false,
          error:
            "Missing required fields: userId, cropName, diseaseName, confidence",
        });
        return;
      }

      if (typeof confidence !== "number" || confidence < 0 || confidence > 1) {
        res.status(400).json({
          success: false,
          error: "confidence must be a number between 0 and 1",
        });
        return;
      }

      const result = await notificationService.createDiseaseAlert(
        userId,
        cropName,
        diseaseName,
        confidence,
        recommendations
      );

      if (!result.success) {
        res.status(400).json({
          success: false,
          error: result.error,
        });
        return;
      }

      res.status(201).json({
        success: true,
        notificationId: result.notificationId,
        message: `Disease alert created for ${cropName}`,
      });
    } catch (error) {
      const errorMessage =
        error instanceof Error ? error.message : "Unknown error";
      console.error("Error in createDiseaseAlert:", errorMessage);
      res.status(500).json({
        success: false,
        error: errorMessage,
      });
    }
  }

  /**
   * POST /api/notifications/weather-alert
   * Create a weather alert notification
   */
  async createWeatherAlert(req: Request, res: Response): Promise<void> {
    try {
      const { userId, alertType, location, description, severity } = req.body;

      if (!userId || !alertType || !location || !description || !severity) {
        res.status(400).json({
          success: false,
          error:
            "Missing required fields: userId, alertType, location, description, severity",
        });
        return;
      }

      const validSeverities = ["low", "medium", "high", "critical"];
      if (!validSeverities.includes(severity)) {
        res.status(400).json({
          success: false,
          error: `severity must be one of: ${validSeverities.join(", ")}`,
        });
        return;
      }

      const result = await notificationService.createWeatherAlert(
        userId,
        alertType,
        location,
        description,
        severity
      );

      if (!result.success) {
        res.status(400).json({
          success: false,
          error: result.error,
        });
        return;
      }

      res.status(201).json({
        success: true,
        notificationId: result.notificationId,
        message: `Weather alert created for ${location}`,
      });
    } catch (error) {
      const errorMessage =
        error instanceof Error ? error.message : "Unknown error";
      console.error("Error in createWeatherAlert:", errorMessage);
      res.status(500).json({
        success: false,
        error: errorMessage,
      });
    }
  }

  /**
   * POST /api/notifications/crop-advisory
   * Create a crop advisory notification
   */
  async createCropAdvisory(req: Request, res: Response): Promise<void> {
    try {
      const { userId, cropName, season, advisory, actionItems } = req.body;

      if (!userId || !cropName || !season || !advisory) {
        res.status(400).json({
          success: false,
          error:
            "Missing required fields: userId, cropName, season, advisory",
        });
        return;
      }

      const result = await notificationService.createCropAdvisory(
        userId,
        cropName,
        season,
        advisory,
        actionItems
      );

      if (!result.success) {
        res.status(400).json({
          success: false,
          error: result.error,
        });
        return;
      }

      res.status(201).json({
        success: true,
        notificationId: result.notificationId,
        message: `Crop advisory notification created for ${cropName}`,
      });
    } catch (error) {
      const errorMessage =
        error instanceof Error ? error.message : "Unknown error";
      console.error("Error in createCropAdvisory:", errorMessage);
      res.status(500).json({
        success: false,
        error: errorMessage,
      });
    }
  }

  /**
   * POST /api/notifications/bulk
   * Create notifications for multiple users
   */
  async createBulkNotifications(req: Request, res: Response): Promise<void> {
    try {
      const { userIds, title, description, type, metadata } = req.body;

      if (!userIds || !Array.isArray(userIds) || userIds.length === 0) {
        res.status(400).json({
          success: false,
          error: "userIds must be a non-empty array",
        });
        return;
      }

      if (!title || !description || !type) {
        res.status(400).json({
          success: false,
          error: "Missing required fields: title, description, type",
        });
        return;
      }

      const result = await notificationService.createBulkNotifications(
        userIds,
        title,
        description,
        type,
        metadata
      );

      res.status(201).json({
        success: true,
        summary: {
          total: userIds.length,
          successful: result.success,
          failed: result.failed,
        },
        results: result.results,
      });
    } catch (error) {
      const errorMessage =
        error instanceof Error ? error.message : "Unknown error";
      console.error("Error in createBulkNotifications:", errorMessage);
      res.status(500).json({
        success: false,
        error: errorMessage,
      });
    }
  }
}

export default new NotificationController();
