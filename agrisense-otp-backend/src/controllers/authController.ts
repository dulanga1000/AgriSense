import admin from "../config/firebase";
import { transporter } from "../config/mail";
import { generateOtp, saveOtp } from "../services/otpService";
import { Request, Response } from "express";

export const sendOtp = async (req: Request, res: Response) => {
  const { email } = req.body;

  console.log("📩 Incoming OTP request:", email);

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
      new Promise((_, reject) =>
        setTimeout(() => reject(new Error("Email timeout")), 8000)
      ),
    ]);

    console.log("✅ Email sent");

    return res.json({ message: "OTP sent successfully" });

  } catch (error: any) {
    console.error("❌ ERROR:", error);

    if (error.code === "auth/user-not-found") {
      return res.status(400).json({
        error: "Email is not registered",
      });
    }

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