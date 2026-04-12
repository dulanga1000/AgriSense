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

  console.log("📩 Incoming OTP request:", email);

  // ✅ Validate email
  if (!email) {
    return res.status(400).json({ error: "Email is required" });
  }

  try {
    // 🔍 Step 1: Check Firebase user
    console.log("🔍 Checking Firebase user...");
    const user = await admin.auth().getUserByEmail(email);
    console.log("✅ User exists:", user.uid);

    // 🔢 Step 2: Generate OTP
    const otp = generateOtp();
    saveOtp(email, otp);
    console.log("🔢 OTP generated:", otp);

    // 📤 Step 3: Send email (with timeout protection)
    console.log("📤 Sending email...");

    await Promise.race([
      transporter.sendMail({
        from: process.env.EMAIL_USER,
        to: email,
        subject: "AgriSense OTP Code",
        text: `Your OTP is: ${otp}`,
      }),
      new Promise<void>((_, reject) =>
        setTimeout(() => reject(new Error("Email timeout")), 8000)
      ),
    ]);

    console.log("✅ Email sent");

    return res.json({ message: "OTP sent successfully" });

  } catch (error: any) {
    console.error("❌ ERROR:", error);

    // ❌ User not found
    if (error.code === "auth/user-not-found") {
      return res.status(400).json({
        error: "Email is not registered",
      });
    }

    // ❌ Email timeout
    if (error.message === "Email timeout") {
      return res.status(500).json({
        error: "Email service timeout",
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

  console.log("🔐 Verifying OTP for:", email);

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

  console.log("✅ OTP verified");

  return res.json({ message: "OTP verified" });
};

// ==========================
// 🔑 RESET PASSWORD
// ==========================
export const resetPassword = async (req: Request, res: Response) => {
  const { email, newPassword } = req.body;

  console.log("🔑 Reset password request for:", email);

  if (!email || !newPassword) {
    return res.status(400).json({
      error: "Email and new password are required",
    });
  }

  try {
    const user = await admin.auth().getUserByEmail(email);

    await admin.auth().updateUser(user.uid, {
      password: newPassword,
    });

    deleteOtp(email);

    console.log("✅ Password updated");

    return res.json({
      message: "Password updated successfully",
    });

  } catch (error: any) {
    console.error("❌ ERROR:", error);

    return res.status(500).json({
      error: error.message || "Failed to reset password",
    });
  }
};