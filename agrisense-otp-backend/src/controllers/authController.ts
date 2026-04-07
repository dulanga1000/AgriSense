import { Request, Response } from "express";
import admin from "../config/firebase";
import { transporter } from "../config/mail";
import {
  generateOtp,
  saveOtp,
  verifyOtp,
  deleteOtp,
} from "../services/otpService";

// Send OTP
export const sendOtp = async (req: Request, res: Response) => {
  const { email } = req.body;

  try {

    await admin.auth().getUserByEmail(email);

    // 👉 If no error → user exists

    const otp = generateOtp();
    saveOtp(email, otp);

    await transporter.sendMail({
      from: process.env.EMAIL_USER,
      to: email,
      subject: "AgriSense OTP Code",
      text: `Your OTP is: ${otp}`,
    });

    res.json({ message: "OTP sent successfully" });

  } catch (error: any) {

    if (error.code === "auth/user-not-found") {
      return res.status(400).json({
        error: "Email is not registered",
      });
    }

    res.status(500).json({ error: error.message });
  }
};

// Verify OTP
export const verifyOtpController = (req: Request, res: Response) => {
  const { email, otp } = req.body;

  const valid = verifyOtp(email, otp);

  if (!valid) {
    return res.status(400).json({ error: "Invalid or expired OTP" });
  }

  res.json({ message: "OTP verified" });
};

// Reset Password
export const resetPassword = async (req: Request, res: Response) => {
  const { email, newPassword } = req.body;

  try {
    const user = await admin.auth().getUserByEmail(email);

    await admin.auth().updateUser(user.uid, {
      password: newPassword,
    });

    deleteOtp(email);

    res.json({ message: "Password updated successfully" });
  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
};