import nodemailer from "nodemailer";

export const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL_USER || "",
    pass: process.env.EMAIL_PASS || "",
  },
});

// 🔍 DEBUG (very important)
transporter.verify((error, success) => {
  if (error) {
    console.error("❌ Mail error:", error);
  } else {
    console.log("✅ Mail server ready");
  }
});