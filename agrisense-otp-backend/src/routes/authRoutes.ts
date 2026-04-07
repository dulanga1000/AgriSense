import express from "express";
import {
  sendOtp,
  verifyOtpController,
  resetPassword,
} from "../controllers/authController";

const router = express.Router();

router.post("/send-otp", sendOtp);
router.post("/verify-otp", verifyOtpController);
router.post("/reset-password", resetPassword);

export default router;