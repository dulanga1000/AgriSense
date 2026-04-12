import SibApiV3Sdk from "sib-api-v3-sdk";

const client = SibApiV3Sdk.ApiClient.instance;

const apiKey = client.authentications["api-key"];
apiKey.apiKey = process.env.BREVO_API_KEY!;

const emailApi = new SibApiV3Sdk.TransactionalEmailsApi();

export const sendEmail = async (to: string, otp: string) => {
  await emailApi.sendTransacEmail({
    sender: {
      email: process.env.EMAIL_USER!,
      name: "AgriSense",
    },
    to: [{ email: to }],
    subject: "AgriSense OTP Code",
    textContent: `Your OTP is: ${otp}`,
  });

  console.log("✅ Email sent via Brevo");
};