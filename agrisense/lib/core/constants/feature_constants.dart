import 'package:agrisense/data/models/feature_model.dart';
import 'package:agrisense/core/routes/app_routes.dart';

class FeatureConstants {
  static const List<FeatureModel> features = [
    FeatureModel(
      name: 'Fertilizer',
      description: 'Get recommendations',
      routeName: AppRoutes.fertilizer,
    ),
    FeatureModel(
      name: 'Crop Advisory',
      description: 'Seasonal guidance',
      routeName: AppRoutes.cropAdvisory,
    ),
  ];
}
