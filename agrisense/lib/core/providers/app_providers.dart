import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:agrisense/core/di/service_locator.dart';
import 'package:agrisense/presentation/notification/state/notification_state.dart';
import 'package:agrisense/presentation/profile/state/profile_state.dart';
import 'package:agrisense/presentation/settings/state/setting_state.dart';
import 'package:agrisense/presentation/weather/state/weather_state.dart';

class AppProviders {
  AppProviders._();

  static List<SingleChildWidget> get providers => [
    ChangeNotifierProvider(create: (_) => sl<ProfileState>()..loadUser()),
    ChangeNotifierProvider(create: (_) => sl<NotificationState>()),
    ChangeNotifierProvider(create: (_) => sl<SettingState>()),
    ChangeNotifierProvider(
      create: (_) => sl<WeatherState>()..loadWeatherData(),
    ),
  ];
}
