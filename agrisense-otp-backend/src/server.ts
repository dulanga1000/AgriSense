import express from "express";
import cors from "cors";
import authRoutes from "./routes/authRoutes";

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// ✅ ENV DEBUG
console.log("🚀 ENV TEST:", {
  EMAIL_USER: process.env.EMAIL_USER,
  EMAIL_PASS: process.env.EMAIL_PASS ? "SET" : "NOT SET",
});

// ✅ ROOT ROUTE (VERY IMPORTANT FOR RAILWAY)
app.get("/", (req, res) => {
  res.send("API is running ✅");
});

// Routes
app.use("/api/auth", authRoutes);

// ✅ GLOBAL ERROR HANDLING (PREVENT CRASH)
process.on("uncaughtException", (err) => {
  console.error("❌ UNCAUGHT EXCEPTION:", err);
});

process.on("unhandledRejection", (err) => {
  console.error("❌ UNHANDLED REJECTION:", err);
});

// Start server
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});