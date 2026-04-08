import nodemailer from "nodemailer";
import dns from "dns";

export const transporter = nodemailer.createTransport({
  host: "smtp.gmail.com",
  port: 587,
  secure: false,
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
  tls: {
    rejectUnauthorized: false,
  },
  lookup: (hostname: string, options: any, callback: any) => {
    dns.lookup(hostname, { family: 4 }, callback);
  },
} as any); // ✅ THIS FIXES RED ERROR