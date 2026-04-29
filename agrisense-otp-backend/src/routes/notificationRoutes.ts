import { Router } from "express";
import notificationController from "../controllers/notificationController";

const router = Router();

/**
 * POST /api/notifications/create
 * Create a single generic notification
 * Body: { userId, title, description, type, metadata? }
 */
router.post("/create", (req, res) => {
  notificationController.createNotification(req, res);
});

/**
 * POST /api/notifications/disease-alert
 * Create a disease alert notification
 * Body: { userId, cropName, diseaseName, confidence, recommendations? }
 */
router.post("/disease-alert", (req, res) => {
  notificationController.createDiseaseAlert(req, res);
});

/**
 * POST /api/notifications/weather-alert
 * Create a weather alert notification
 * Body: { userId, alertType, location, description, severity }
 */
router.post("/weather-alert", (req, res) => {
  notificationController.createWeatherAlert(req, res);
});

/**
 * POST /api/notifications/crop-advisory
 * Create a crop advisory notification
 * Body: { userId, cropName, season, advisory, actionItems? }
 */
router.post("/crop-advisory", (req, res) => {
  notificationController.createCropAdvisory(req, res);
});

/**
 * POST /api/notifications/bulk
 * Create notifications for multiple users
 * Body: { userIds, title, description, type, metadata? }
 */
router.post("/bulk", (req, res) => {
  notificationController.createBulkNotifications(req, res);
});

export default router;
