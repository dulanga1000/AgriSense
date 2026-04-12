import admin from "firebase-admin";

const serviceAccount = process.env.FIREBASE_SERVICE_ACCOUNT;

if (!serviceAccount) {
  throw new Error("FIREBASE_SERVICE_ACCOUNT is missing");
}

admin.initializeApp({
  credential: admin.credential.cert(JSON.parse(serviceAccount)),
});

export default admin;