import { Request, Response } from "express";
import admin from "../config/firebase";
import { transporter } from "../config/mail";
import {
  generateOtp,
  saveOtp,
  verifyOtp,
  deleteOtp,
} from "../services/otpService";

// ==========================
// 📩 SEND OTP
// ==========================
export const sendOtp = async (req: Request, res: Response) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).json({ error: "Email is required" });
  }

  try {
    console.log("📩 Sending OTP to:", email);

    console.log("ENV CHECK:", {
      SMTP_USER: process.env.SMTP_USER,
      SMTP_PASS: process.env.SMTP_PASS ? "SET" : "NOT SET",
    });

    // ✅ Check Firebase user
    await admin.auth().getUserByEmail(email);

    // ✅ Generate OTP
    const otp = generateOtp();
    saveOtp(email, otp);

    console.log("🔢 OTP:", otp);

    // ✅ Send Email (FIXED)
    const info = await transporter.sendMail({
      from: `"AgriSense" <${process.env.SMTP_USER}>`, // ✅ FIXED
      to: email,
      subject: "AgriSense OTP Code",
      text: `Your OTP is: ${otp}`,
    });

    console.log("✅ Email sent:", info.messageId);

    return res.json({
      success: true,
      message: "OTP sent successfully",
    });

  } catch (error: any) {
    console.error("❌ SEND OTP ERROR:", error);

    if (error.code === "auth/user-not-found") {
      return res.status(400).json({
        error: "Email is not registered",
      });
    }

    return res.status(500).json({
      error: error.message || "Something went wrong",
    });
  }
};

// ==========================
// 🔐 VERIFY OTP
// ==========================
export const verifyOtpController = (req: Request, res: Response) => {
  const { email, otp } = req.body;

  if (!email || !otp) {
    return res.status(400).json({
      error: "Email and OTP are required",
    });
  }

  const valid = verifyOtp(email, otp);

  if (!valid) {
    return res.status(400).json({
      error: "Invalid or expired OTP",
    });
  }

  return res.json({
    success: true,
    message: "OTP verified successfully",
  });
};

// ==========================
// 🔄 RESET PASSWORD
// ==========================
export const resetPassword = async (req: Request, res: Response) => {
  const { email, newPassword } = req.body;

  if (!email || !newPassword) {
    return res.status(400).json({
      error: "Email and new password are required",
    });
  }

  try {
    console.log("🔄 Resetting password for:", email);

    const user = await admin.auth().getUserByEmail(email);

    await admin.auth().updateUser(user.uid, {
      password: newPassword,
    });

    deleteOtp(email);

    console.log("✅ Password updated");

    return res.json({
      success: true,
      message: "Password updated successfully",
    });

  } catch (error: any) {
    console.error("❌ RESET ERROR:", error);

    return res.status(500).json({
      error: error.message || "Password reset failed",
    });
  }
};