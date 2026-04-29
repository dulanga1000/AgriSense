import axios from "axios";

/**
 * Quick Test Script for Real Notifications
 * Run this to test notification endpoints
 *
 * Usage:
 * npx ts-node test-notifications.ts
 */

const API_BASE = "http://localhost:3000/api";

// Use your actual Firebase user ID for testing
const TEST_USER_ID = "YOUR_FIREBASE_USER_ID";

interface TestResult {
  name: string;
  success: boolean;
  response: any;
  error?: string;
}

const results: TestResult[] = [];

async function testDiseaseAlert() {
  try {
    const response = await axios.post(`${API_BASE}/notifications/disease-alert`, {
      userId: TEST_USER_ID,
      cropName: "Tomato",
      diseaseName: "Early Blight",
      confidence: 0.92,
      recommendations: "Apply mancozeb fungicide weekly",
    });

    results.push({
      name: "Disease Alert",
      success: response.status === 201,
      response: response.data,
    });

    console.log("✅ Disease Alert Test Passed");
    console.log("Response:", response.data);
  } catch (error) {
    const errorMsg =
      error instanceof Error ? error.message : JSON.stringify(error);
    results.push({
      name: "Disease Alert",
      success: false,
      response: null,
      error: errorMsg,
    });

    console.log("❌ Disease Alert Test Failed");
    console.error("Error:", errorMsg);
  }
}

async function testWeatherAlert() {
  try {
    const response = await axios.post(`${API_BASE}/notifications/weather-alert`, {
      userId: TEST_USER_ID,
      alertType: "storm",
      location: "Colombo",
      description: "Heavy rainfall and strong winds expected for next 24 hours",
      severity: "high",
    });

    results.push({
      name: "Weather Alert",
      success: response.status === 201,
      response: response.data,
    });

    console.log("✅ Weather Alert Test Passed");
    console.log("Response:", response.data);
  } catch (error) {
    const errorMsg =
      error instanceof Error ? error.message : JSON.stringify(error);
    results.push({
      name: "Weather Alert",
      success: false,
      response: null,
      error: errorMsg,
    });

    console.log("❌ Weather Alert Test Failed");
    console.error("Error:", errorMsg);
  }
}

async function testCropAdvisory() {
  try {
    const response = await axios.post(`${API_BASE}/notifications/crop-advisory`, {
      userId: TEST_USER_ID,
      cropName: "Rice",
      season: "Yala",
      advisory:
        "Water management guidelines: Maintain water level at 5cm during growing phase. Apply NPK fertilizer at 150kg/hectare.",
      actionItems: [
        "Maintain water level at 5cm",
        "Apply NPK 150kg/hectare",
        "Monitor for pests weekly",
      ],
    });

    results.push({
      name: "Crop Advisory",
      success: response.status === 201,
      response: response.data,
    });

    console.log("✅ Crop Advisory Test Passed");
    console.log("Response:", response.data);
  } catch (error) {
    const errorMsg =
      error instanceof Error ? error.message : JSON.stringify(error);
    results.push({
      name: "Crop Advisory",
      success: false,
      response: null,
      error: errorMsg,
    });

    console.log("❌ Crop Advisory Test Failed");
    console.error("Error:", errorMsg);
  }
}

async function testBulkNotifications() {
  try {
    const response = await axios.post(
      `${API_BASE}/notifications/bulk`,
      {
        userIds: [TEST_USER_ID, "user2", "user3"],
        title: "Regional Weather Warning",
        description: "Heavy rainfall alert for Western Province",
        type: "weather",
        metadata: {
          region: "Western Province",
          affectedDistricts: ["Colombo", "Gampaha"],
        },
      }
    );

    results.push({
      name: "Bulk Notifications",
      success: response.status === 201,
      response: response.data,
    });

    console.log("✅ Bulk Notifications Test Passed");
    console.log("Response:", response.data);
  } catch (error) {
    const errorMsg =
      error instanceof Error ? error.message : JSON.stringify(error);
    results.push({
      name: "Bulk Notifications",
      success: false,
      response: null,
      error: errorMsg,
    });

    console.log("❌ Bulk Notifications Test Failed");
    console.error("Error:", errorMsg);
  }
}

async function runAllTests() {
  console.log("🚀 Starting Notification API Tests");
  console.log(`📍 API Base: ${API_BASE}`);
  console.log(`👤 Test User ID: ${TEST_USER_ID}`);
  console.log("─".repeat(50));

  if (!TEST_USER_ID || TEST_USER_ID.includes("YOUR_FIREBASE")) {
    console.error(
      "❌ Please set TEST_USER_ID to your actual Firebase user ID"
    );
    process.exit(1);
  }

  await testDiseaseAlert();
  console.log("─".repeat(50));

  await testWeatherAlert();
  console.log("─".repeat(50));

  await testCropAdvisory();
  console.log("─".repeat(50));

  await testBulkNotifications();
  console.log("─".repeat(50));

  // Summary
  const passed = results.filter((r) => r.success).length;
  const total = results.length;

  console.log("\n📊 Test Summary:");
  console.log(`✅ Passed: ${passed}/${total}`);
  console.log(`❌ Failed: ${total - passed}/${total}`);

  if (passed === total) {
    console.log("\n🎉 All tests passed!");
  } else {
    console.log("\n⚠️ Some tests failed. Check errors above.");
  }
}

// Run tests
runAllTests().catch((error) => {
  console.error("Fatal error:", error);
  process.exit(1);
});
