import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import authRoutes from "./routes/authRoutes";

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

// 🔥 DEBUG ENV (VERY IMPORTANT)
console.log("ENV CHECK:", {
  email: process.env.EMAIL_USER || "MISSING",
  pass: process.env.EMAIL_PASS ? "EXISTS" : "MISSING",
  firebase: process.env.FIREBASE_SERVICE_ACCOUNT ? "EXISTS" : "MISSING",
});

// ✅ Health check route
app.get("/", (req, res) => {
  res.send("API is running 🚀");
});

// ✅ Routes
app.use("/api/auth", authRoutes);

// ✅ Dynamic port (Render)
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});