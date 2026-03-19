import 'package:get_it/get_it.dart';

import 'package:agrisense/data/repositories/disease_repository.dart';
import 'package:agrisense/data/repositories/fertilizer_repository.dart';
import 'package:agrisense/data/repositories/notification_repository.dart';
import 'package:agrisense/data/repositories/profile_repository.dart';
import 'package:agrisense/data/repositories/weather_repository.dart';
import 'package:agrisense/presentation/notification/state/notification_state.dart';
import 'package:agrisense/presentation/fertilizer/state/fertilizer_state.dart';
import 'package:agrisense/presentation/profile/state/profile_state.dart';
import 'package:agrisense/presentation/settings/state/setting_state.dart';
import 'package:agrisense/presentation/weather/state/weather_state.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // ─────────────────────────────────
  // Repositories
  // ─────────────────────────────────
  if (!sl.isRegistered<DiseaseRepository>()) {
    sl.registerLazySingleton<DiseaseRepository>(() => DiseaseRepository());
  }
  if (!sl.isRegistered<FertilizerRepository>()) {
    sl.registerLazySingleton<FertilizerRepository>(
      () => FertilizerRepository(),
    );
  }
  if (!sl.isRegistered<NotificationRepository>()) {
    sl.registerLazySingleton<NotificationRepository>(
      () => NotificationRepository(),
    );
  }
  if (!sl.isRegistered<ProfileRepository>()) {
    sl.registerLazySingleton<ProfileRepository>(() => ProfileRepository());
  }
  if (!sl.isRegistered<WeatherRepository>()) {
    sl.registerLazySingleton<WeatherRepository>(() => WeatherRepository());
  }

  // ─────────────────────────────────
  // States
  // ─────────────────────────────────
  if (!sl.isRegistered<ProfileState>()) {
    sl.registerFactory<ProfileState>(
      () => ProfileState(sl<ProfileRepository>()),
    );
  }
  if (!sl.isRegistered<FertilizerState>()) {
    sl.registerFactory<FertilizerState>(
      () => FertilizerState(sl<FertilizerRepository>()),
    );
  }
  if (!sl.isRegistered<NotificationState>()) {
    sl.registerFactory<NotificationState>(
      () => NotificationState(sl<NotificationRepository>()),
    );
  }
  if (!sl.isRegistered<SettingState>()) {
    sl.registerFactory<SettingState>(() => SettingState());
  }
  if (!sl.isRegistered<WeatherState>()) {
    sl.registerFactory<WeatherState>(
      () => WeatherState(sl<WeatherRepository>()),
    );
  }
}
