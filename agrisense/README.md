# AgriSense - Smart Agriculture System

AgriSense is a comprehensive smart agriculture solution designed to assist farmers in making informed agricultural decisions. The system integrates a **Flutter-based mobile application** for the user interface and AI processing, supported by a **Node.js/Express backend** handling secure OTP-based authentication. 

By leveraging AI-based disease detection, real-time weather updates, and smart recommendations, AgriSense aims to significantly improve crop productivity and yield.

## ✨ Features

### Mobile Application (Frontend)
*   **AI-Based Crop Disease Detection:** Capture or upload plant images for offline, on-device disease detection using TensorFlow Lite.
*   **Real-Time Weather Information:** Location-based weather updates to help plan farming activities.
*   **Crop Advisory System:** Intelligent recommendations based on current environmental data.
*   **Fertilizer Guidance:** Crop-specific fertilizer suggestions and usage instructions.
*   **Multi-language Support:** Accessible in English, Sinhala, and Tamil.
*   **Notifications & Alerts:** Farming tips and timely alerts.
*   **User Profile Management:** Manage personal data and app preferences.

### Authentication Backend (OTP Service)
*   **Secure OTP Generation & Verification:** Email-based OTP delivery using Brevo (Sendinblue) / Nodemailer.
*   **Firebase Integration:** Seamlessly verifies users and updates credentials via the Firebase Admin SDK.
*   **Password Reset Management:** Secure endpoints to handle user password recoveries.

---

## 🛠 Technologies Used

**Frontend (Mobile App)**
*   **Framework:** Flutter (Dart)
*   **State Management:** Provider
*   **Database & Auth:** Firebase Firestore, Firebase Authentication
*   **APIs:** OpenWeatherMap, Gemini API
*   **Location:** Geolocator, Geocoding

**Backend (OTP Service)**
*   **Environment:** Node.js with Express
*   **Language:** TypeScript
*   **Authentication:** Firebase Admin SDK
*   **Email Service:** Brevo API (`sib-api-v3-sdk`) / Nodemailer

---

## 📂 Project Structure

The repository is divided into two main components:

```text
AgriSense/
│
├── agrisense/                    # Flutter Mobile Application
│   ├── android/                  # Android-specific build files
│   ├── ios/                      # iOS-specific build files
│   ├── lib/                      # Main Dart source code
│   │   ├── core/                 # Constants, themes, and configs
│   │   ├── data/                 # Repositories and API calls
│   │   ├── presentation/         # UI Screens and Widgets
│   │   └── routes/               # App navigation
│   └── assets/                   # Images, icons, TFLite models, translations
│
└── agrisense-otp-backend/        # Node.js Express OTP Backend
    ├── src/
    │   ├── config/               # Firebase Admin and Mail configurations
    │   ├── controllers/          # Route handlers (sendOtp, verifyOtp, resetPassword)
    │   ├── routes/               # Express routing definitions
    │   ├── services/             # Core business logic (OTP generation/storage)
    │   └── server.ts             # Backend entry point
    ├── package.json              # Backend dependencies
    └── tsconfig.json             # TypeScript configuration
```

---

## 🚀 Getting Started

Follow these instructions to set up both the backend and frontend environments on your local machine.

### Prerequisites
*   [Flutter SDK](https://docs.flutter.dev/get-started/install) (Version 3.11.0 or higher)
*   [Node.js](https://nodejs.org/) (Version 18 or higher)
*   Firebase Project with Authentication and Firestore enabled.

### 1. Backend Setup (`agrisense-otp-backend`)

1. Navigate to the backend directory:
   ```bash
   cd agrisense-otp-backend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Create a `.env` file in the root of the backend folder and add your credentials:
   ```env
   PORT=3000
   FIREBASE_SERVICE_ACCOUNT={"type": "service_account", "project_id": "...", "private_key": "...", "client_email": "..."}
   BREVO_API_KEY=your_brevo_api_key_here
   EMAIL_USER=your_sender_email@example.com
   ```
4. Start the development server:
   ```bash
   npm run dev
   ```
   *The server will run on `http://localhost:3000`.*

### 2. Frontend Setup (`agrisense`)

1. Navigate to the Flutter app directory:
   ```bash
   cd agrisense
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   
```
3. Configure Firebase:
   * Download `google-services.json` from your Firebase console and place it in `agrisense/android/app/`.
   * Download `GoogleService-Info.plist` and place it in `agrisense/ios/Runner/`.
4. Set up Environment Variables:
   Create a `.env` file in the root of the `agrisense` folder:
   ```env
   GEMINI_API_KEY=your_gemini_api_key_here
   OPENWEATHER_API_KEY=your_openweather_api_key_here
   OWM_API_KEY=your_openweather_api_key_here
   ```
5. Run the application:
   ```bash
   flutter run
   ```

---

## 📱 App Screens

*   Splash Screen
*   Login / Register (OTP Integrated)
*   Home Dashboard
*   Disease Detection (Camera/Gallery)
*   Crop Advisory
*   Fertilizer Guide
*   Weather Screen
*   Notifications
*   Profile & Settings

---

## 🔮 Future Improvements

*   **Offline Support:** Full local caching for areas with poor connectivity.
*   **Improved AI Model Accuracy:** Train the TFLite model on a broader dataset of regional crops.
*   **Voice Assistant Integration:** Allow farmers to navigate the app hands-free.
*   **IoT Smart Farming Integration:** Sync with soil moisture and temperature sensors.
*   **Advanced Analytics Dashboard:** Visual insights into weather patterns and crop health over time.

---

## 👥 Team Members

*   MMDN Bandara
*   KTN Katugampala
*   MM Wanigarathna
*   EIN Ekanayake
*   UAD Barnad

---

## 📄 License

This project is developed for academic purposes only. 

*Developed for SE303.3 - Mobile Application Development*

---

## 🙏 Acknowledgements

*   [Flutter Documentation](https://docs.flutter.dev/)
*   [Firebase Documentation](https://firebase.google.com/docs)
*   [OpenWeather API](https://openweathermap.org/api)
```
