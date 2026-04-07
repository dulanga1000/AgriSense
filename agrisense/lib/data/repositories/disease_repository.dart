import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:agrisense/data/models/disease_result_model.dart';

class DiseaseRepository {
  Interpreter? _interpreter;
  List<String>? _labels;

  Future<void> _loadModel() async {
    if (_interpreter != null && _labels != null) return;

    // Load the TFLite model you exported from Teachable Machine
    _interpreter = await Interpreter.fromAsset(
      'assets/models/plant_disease_model.tflite',
    );

    // Load the labels text file
    final labelData = await rootBundle.loadString('assets/models/labels.txt');
    _labels = labelData.split('\n').where((label) => label.isNotEmpty).toList();
  }

  Future<DiseaseResultModel> analyzeImage(File imageFile) async {
    await _loadModel();

    // 1. Read and decode the image
    final rawImage = await imageFile.readAsBytes();
    img.Image? image = img.decodeImage(rawImage);
    if (image == null) throw Exception("Failed to decode image");

    // 2. Resize image to match Teachable Machine's input size (224x224)
    img.Image resizedImage = img.copyResize(image, width: 224, height: 224);

    // 3. Convert image pixels to a 3D float array [1, 224, 224, 3] and normalize
    var input = List.generate(
      1,
      (i) => List.generate(
        224,
        (y) => List.generate(224, (x) {
          final pixel = resizedImage.getPixel(x, y);
          // Teachable machine normalizes between -1 and 1
          return [
            (pixel.r / 127.5) - 1.0,
            (pixel.g / 127.5) - 1.0,
            (pixel.b / 127.5) - 1.0,
          ];
        }),
      ),
    );

    // 4. Prepare output array [1, number_of_labels]
    var output = List.filled(1, List.filled(_labels!.length, 0.0));

    // 5. Run AI Inference!
    _interpreter!.run(input, output);

    // 6. Find the highest probability
    final results = output[0];
    double maxConfidence = 0;
    int maxIndex = 0;

    for (int i = 0; i < results.length; i++) {
      if (results[i] > maxConfidence) {
        maxConfidence = results[i];
        maxIndex = i;
      }
    }

    // Clean up the Teachable Machine label (removes the "0 ClassName" number prefix)
    String rawLabel = _labels![maxIndex];
    String detectedDisease = rawLabel.contains(' ')
        ? rawLabel.substring(rawLabel.indexOf(' ') + 1)
        : rawLabel;

    // 7. Get the details for the UI based on what the AI found
    return _getDetailsForDisease(detectedDisease, maxConfidence);
  }

  // Maps the AI prediction to your 10 specific dataset categories
  DiseaseResultModel _getDetailsForDisease(
    String diseaseName,
    double confidence,
  ) {
    String name = diseaseName.toLowerCase();

    if (name.contains('normal') || name.contains('healthy')) {
      return DiseaseResultModel(
        diseaseName: 'Healthy Paddy',
        scientificName: 'No disease detected',
        confidence: confidence,
        symptoms: [
          'Plant appears green and vibrant',
          'No visible spots, wilting, or pest damage',
        ],
        treatments: ['No treatment required'],
        preventions: [
          'Continue regular watering and fertilizer schedule',
          'Monitor field weekly',
        ],
      );
    }

    if (name.contains('bacterial_leaf_blight')) {
      return DiseaseResultModel(
        diseaseName: 'Bacterial Leaf Blight',
        scientificName: 'Xanthomonas oryzae pv. oryzae',
        confidence: confidence,
        symptoms: [
          'Water-soaked to yellowish stripes on leaf blades',
          'Leaves wilt and roll up',
          'Milky ooze drops on young lesions',
        ],
        treatments: [
          'Apply copper-based fungicides if severe',
          'Drain the field temporarily to reduce humidity',
        ],
        preventions: [
          'Plant resistant rice varieties',
          'Avoid excessive nitrogen fertilizer',
          'Ensure proper field drainage',
        ],
      );
    }

    if (name.contains('bacterial_leaf_streak')) {
      return DiseaseResultModel(
        diseaseName: 'Bacterial Leaf Streak',
        scientificName: 'Xanthomonas oryzae pv. oryzicola',
        confidence: confidence,
        symptoms: [
          'Narrow, dark-green, water-soaked streaks between veins',
          'Streaks turn yellowish-orange to brown',
          'Tiny amber droplets of bacterial ooze',
        ],
        treatments: ['Apply copper fungicides during early stages'],
        preventions: [
          'Use certified disease-free seeds',
          'Keep fields clean of weeds and volunteer rice',
          'Avoid planting during heavy rains if possible',
        ],
      );
    }

    if (name.contains('bacterial_panicle_blight')) {
      return DiseaseResultModel(
        diseaseName: 'Bacterial Panicle Blight',
        scientificName: 'Burkholderia glumae',
        confidence: confidence,
        symptoms: [
          'Discoloration of growing grains (florets)',
          'Panicles remain upright instead of bending down',
          'Grains appear empty or aborted',
        ],
        treatments: [
          'Chemical treatments are generally ineffective once grains are infected',
          'Apply protective copper sprays before heading stage',
        ],
        preventions: [
          'Use healthy, treated seeds',
          'Adjust planting dates to avoid extreme heat during the heading stage',
        ],
      );
    }

    if (name.contains('blast')) {
      return DiseaseResultModel(
        diseaseName: 'Rice Blast',
        scientificName: 'Magnaporthe oryzae',
        confidence: confidence,
        symptoms: [
          'Diamond-shaped or spindle-shaped lesions with gray centers',
          'Stunted plant growth',
          'Collar rot where the leaf attaches to the stem',
        ],
        treatments: [
          'Apply Tricyclazole or Isoprothiolane fungicides immediately',
          'Keep the field flooded if possible',
        ],
        preventions: [
          'Plant resistant varieties',
          'Avoid excessive nitrogen',
          'Destroy infected crop residue after harvest',
        ],
      );
    }

    if (name.contains('brown_spot')) {
      return DiseaseResultModel(
        diseaseName: 'Brown Spot',
        scientificName: 'Bipolaris oryzae',
        confidence: confidence,
        symptoms: [
          'Small circular to oval dark brown lesions',
          'Yellow halo around the spots',
          'Spots on grains causing "pecky rice"',
        ],
        treatments: [
          'Apply Mancozeb or Propiconazole fungicides',
          'Apply nitrogen and potassium fertilizers if soil is deficient',
        ],
        preventions: [
          'Treat seeds with hot water or fungicides before planting',
          'Maintain proper soil fertility and moisture',
        ],
      );
    }

    if (name.contains('dead_heart')) {
      return DiseaseResultModel(
        diseaseName: 'Dead Heart (Stem Borer)',
        scientificName: 'Scirpophaga spp. (Pest Damage)',
        confidence: confidence,
        symptoms: [
          'Central shoot turns yellow, dries up, and dies',
          'Dead shoots can be easily pulled out',
          'Holes visible on the plant stems',
        ],
        treatments: [
          'Apply systemic insecticides like Cartap hydrochloride or Chlorpyrifos',
          'Remove and destroy "dead hearts" manually',
        ],
        preventions: [
          'Use pheromone traps to monitor and catch moths',
          'Practice crop rotation',
          'Plough fields right after harvest to destroy larvae',
        ],
      );
    }

    if (name.contains('downy_mildew')) {
      return DiseaseResultModel(
        diseaseName: 'Downy Mildew',
        scientificName: 'Sclerophthora macrospora',
        confidence: confidence,
        symptoms: [
          'Yellowing and severe stunting of plants',
          'Leaves become twisted, distorted, and covered in white fuzz',
          'Panicles fail to emerge properly',
        ],
        treatments: ['Apply Metalaxyl-based fungicides as soon as spotted'],
        preventions: [
          'Improve field drainage (fungus thrives in standing water)',
          'Control grassy weeds that host the fungus',
        ],
      );
    }

    if (name.contains('hispa')) {
      return DiseaseResultModel(
        diseaseName: 'Rice Hispa (Pest)',
        scientificName: 'Dicladispa armigera',
        confidence: confidence,
        symptoms: [
          'Translucent white streaks on leaves parallel to veins',
          'Upper surface of leaves scraped off by adult beetles',
          'Fields appear burnt from a distance in severe cases',
        ],
        treatments: [
          'Apply insecticides like Chlorpyrifos or Quinalphos if pest population is high',
        ],
        preventions: [
          'Clip the top few inches of leaves before transplanting to remove eggs',
          'Keep field and surrounding bunds weed-free',
        ],
      );
    }

    if (name.contains('tungro')) {
      return DiseaseResultModel(
        diseaseName: 'Rice Tungro Disease',
        scientificName: 'RTBV & RTSV (Transmitted by Green Leafhopper)',
        confidence: confidence,
        symptoms: [
          'Severe stunting of plants',
          'Leaves turn yellow to bright orange starting from the tips',
          'Reduced tillering (fewer stems)',
        ],
        treatments: [
          'The virus cannot be cured; you must kill the Green Leafhoppers transmitting it',
          'Apply insecticides targeting leafhoppers immediately',
        ],
        preventions: [
          'Plant tungro-resistant rice varieties',
          'Destroy infected plants immediately to stop the spread',
          'Synchronize planting with neighboring farms',
        ],
      );
    }

    // Default fallback just in case
    return DiseaseResultModel(
      diseaseName: diseaseName.replaceAll('_', ' ').toUpperCase(),
      scientificName: 'Pathogen/Pest detected',
      confidence: confidence,
      symptoms: ['Visual anomalies detected on the plant'],
      treatments: ['Consult a local agricultural extension officer'],
      preventions: ['Ensure proper field hygiene and spacing'],
    );
  }
}
