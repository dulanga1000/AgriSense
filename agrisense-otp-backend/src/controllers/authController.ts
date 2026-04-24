import { Request, Response } from "express";
import admin from "../config/firebase";
import { sendEmail } from "../config/mail";
import {
  generateOtp,
  saveOtp,
  verifyOtp,
  deleteOtp,
} from "../services/otpService";

// SEND OTP
export const sendOtp = async (req: Request, res: Response) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).json({ error: "Email required" });
  }

  try {
    await admin.auth().getUserByEmail(email);

    const otp = generateOtp();
    saveOtp(email, otp);

    await sendEmail(email, otp);

    res.json({ message: "OTP sent" });

  } catch (error: any) {
    if (error.code === "auth/user-not-found") {
      return res.status(400).json({ error: "Email not registered" });
    }

    res.status(500).json({ error: error.message });
  }
};

// VERIFY OTP
export const verifyOtpController = (req: Request, res: Response) => {
  const { email, otp } = req.body;

  if (!verifyOtp(email, otp)) {
    return res.status(400).json({ error: "Invalid OTP" });
  }

  res.json({ message: "OTP verified" });
};

// RESET PASSWORD
export const resetPassword = async (req: Request, res: Response) => {
  const { email, newPassword } = req.body;

  try {
    const user = await admin.auth().getUserByEmail(email);

    await admin.auth().updateUser(user.uid, {
      password: newPassword,
    });

    deleteOtp(email);

    res.json({ message: "Password updated" });

  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
};