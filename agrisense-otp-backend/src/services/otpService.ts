type OtpRecord = {
  otp: string;
  expires: number;
};

const otpStore: Map<string, OtpRecord> = new Map();

export const generateOtp = (): string => {
  return Math.floor(100000 + Math.random() * 900000).toString();
};

export const saveOtp = (email: string, otp: string) => {
  otpStore.set(email, {
    otp,
    expires: Date.now() + 5 * 60 * 1000,
  });
};

export const verifyOtp = (email: string, otp: string): boolean => {
  const record = otpStore.get(email);

  if (!record) return false;

  if (Date.now() > record.expires) {
    otpStore.delete(email);
    return false;
  }

  return record.otp === otp;
};

export const deleteOtp = (email: string) => {
  otpStore.delete(email);
};