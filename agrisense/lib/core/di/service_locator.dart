import 'package:get_it/get_it.dart';

import 'package:agrisense/data/repositories/disease_repository.dart';
import 'package:agrisense/data/repositories/fertilizer_repository.dart';
import 'package:agrisense/data/repositories/notification_repository.dart';
import 'package:agrisense/data/repositories/profile_repository.dart';
import 'package:agrisense/data/repositories/weather_repository.dart';
import 'package:agrisense/presentation/disease/state/disease_state.dart';
import 'package:agrisense/presentation/fertilizer/state/fertilizer_state.dart';
import 'package:agrisense/presentation/notification/state/notification_state.dart';
import 'package:agrisense/presentation/profile/state/profile_state.dart';
import 'package:agrisense/presentation/settings/state/setting_state.dart';
import 'package:agrisense/presentation/weather/state/weather_state.dart';
import 'package:agrisense/presentation/settings/state/location_state.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerLazySingleton<DiseaseRepository>(() => DiseaseRepository());
  sl.registerLazySingleton<FertilizerRepository>(() => FertilizerRepository());
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepository(),
  );
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepository());
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepository());

  sl.registerFactory<DiseaseState>(() => DiseaseState(sl<DiseaseRepository>()));
  sl.registerFactory<FertilizerState>(
    () => FertilizerState(sl<FertilizerRepository>()),
  );
  sl.registerFactory<NotificationState>(
    () => NotificationState(sl<NotificationRepository>()),
  );
  sl.registerFactory<ProfileState>(() => ProfileState(sl<ProfileRepository>()));
  sl.registerFactory<SettingState>(() => SettingState());
  sl.registerFactory<WeatherState>(() => WeatherState(sl<WeatherRepository>()));
  sl.registerFactory<LocationState>(() => LocationState());
}
