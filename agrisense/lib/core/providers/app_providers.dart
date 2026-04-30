import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:agrisense/core/di/service_locator.dart';

import 'package:agrisense/presentation/auth/state/auth_provider.dart';
import 'package:agrisense/presentation/profile/state/profile_state.dart';
import 'package:agrisense/presentation/settings/state/setting_state.dart';
import 'package:agrisense/presentation/weather/state/weather_state.dart';
import 'package:agrisense/presentation/notification/state/notification_state.dart';
import 'package:agrisense/presentation/settings/state/location_state.dart';
import 'package:agrisense/presentation/home/state/farming_tip_state.dart';

// ADDED: The import for your ML scanner state
import 'package:agrisense/presentation/disease/state/disease_state.dart';

class AppProviders {
  AppProviders._();

  static List<SingleChildWidget> get providers => [
    ChangeNotifierProvider(create: (_) => AuthProvider()),

    ChangeNotifierProvider(create: (_) => sl<ProfileState>()..loadUser()),

    ChangeNotifierProvider(create: (_) => sl<SettingState>()..loadSettings()),

    ChangeNotifierProvider(
      create: (_) => sl<WeatherState>()..loadWeatherData(),
    ),

    ChangeNotifierProxyProvider<SettingState, NotificationState>(
      create: (_) => sl<NotificationState>(),
      update: (_, settingState, notificationState) {
        final state = notificationState ?? sl<NotificationState>();
        state.updateNotificationSettings(
          notificationsEnabled: settingState.notifications,
          diseaseAlertsEnabled: settingState.diseaseAlerts,
          weatherUpdatesEnabled: settingState.weatherUpdates,
          farmingTipsEnabled: settingState.farmingTips,
          authAlertsEnabled: settingState.authAlerts,
        );
        return state;
      },
    ),

    ChangeNotifierProxyProvider<WeatherState, LocationState>(
      create: (_) => sl<LocationState>(),
      update: (_, weatherState, locationState) {
        final state = locationState ?? sl<LocationState>();
        state.syncFromWeatherLocation(weatherState.selectedLocation);
        return state;
      },
    ),

    ChangeNotifierProxyProvider<WeatherState, FarmingTipState>(
      create: (_) => sl<FarmingTipState>(),
      update: (_, weatherState, farmingTipState) {
        final state = farmingTipState ?? sl<FarmingTipState>();
        state.loadTips(location: weatherState.selectedLocation);
        return state;
      },
    ),

    // ADDED: The provider for your Disease Scanner
    ChangeNotifierProvider(create: (_) => sl<DiseaseState>()),
  ];
}
