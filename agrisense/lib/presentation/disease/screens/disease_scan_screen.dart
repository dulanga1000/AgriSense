import 'package:flutter/material.dart';
import 'dart:io';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';
import 'package:agrisense/presentation/disease/widgets/upload_plant_image_card.dart';
import 'package:agrisense/presentation/disease/widgets/photography_tips_card.dart';
import 'package:agrisense/presentation/disease/widgets/image_preview_card.dart';
import 'package:agrisense/presentation/disease/widgets/analyzing_card.dart';
import 'package:agrisense/presentation/disease/widgets/detection_result_card.dart';
import 'package:agrisense/data/models/disease_result_model.dart';
import 'package:agrisense/presentation/disease/widgets/symptoms_card.dart';
import 'package:agrisense/presentation/disease/widgets/treatment_card.dart';
import 'package:agrisense/presentation/disease/widgets/prevention_card.dart';
import 'package:agrisense/presentation/disease/widgets/scan_another_button.dart';

class DiseaseScanScreen extends StatefulWidget {
  const DiseaseScanScreen({super.key});

  @override
  State<DiseaseScanScreen> createState() => _DiseaseScanScreenState();
}

class _DiseaseScanScreenState extends State<DiseaseScanScreen> {
  File? _selectedImage;
  bool _isAnalyzing = false;
  DiseaseResultModel? _result;

  void _onImageSelected(File image) {
    setState(() {
      _selectedImage = image;
      _result = null;
    });
  }

  void _onChangeImage() {
    setState(() {
      _selectedImage = null;
      _result = null;
    });
  }

  Future<void> _onDetectDisease() async {
    if (_selectedImage == null || _isAnalyzing) {
      return;
    }

    setState(() {
      _isAnalyzing = true;
      _result = null;
    });

    await Future<void>.delayed(const Duration(seconds: 2));

    if (!mounted) {
      return;
    }

    setState(() {
      _isAnalyzing = false;
      _result = const DiseaseResultModel(
        diseaseName: 'Leaf Spot',
        scientificName: 'Cercospora spp.',
        confidence: 0.92,
        symptoms: [
          'Small brown or dark spots on leaves',
          'Yellow halo around lesions',
          'Premature leaf drop in severe cases',
        ],
        treatments: [
          'Remove and destroy infected leaves',
          'Apply a suitable fungicide as directed',
          'Avoid overhead irrigation late in the day',
        ],
        preventions: [
          'Ensure good airflow between plants',
          'Water at soil level to keep leaves dry',
          'Use disease-free seeds and tools',
        ],
      );
    });
  }

  void _onScanAnother() {
    setState(() {
      _selectedImage = null;
      _result = null;
      _isAnalyzing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 60,
        leading: const AppBackButton(fallbackIndex: 0),
        title: const Column(
          children: [
            Text(
              "Disease Detection",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "AI-Powered Plant Analysis",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFB2C36), Color(0xFFFF6900)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_selectedImage == null) ...[
              UploadPlantImageCard(onImageSelected: _onImageSelected),
              const SizedBox(height: 16),
              const PhotographyTipsCard(),
            ],

            if (_selectedImage != null) ...[
              ImagePreviewCard(
                image: _selectedImage!,
                isAnalyzing: _isAnalyzing,
                onChangeImage: _onChangeImage,
                onDetectDisease: _onDetectDisease,
              ),
              const SizedBox(height: 16),
            ],

            if (_isAnalyzing) const AnalyzingCard(),

            if (_result != null) ...[
              DetectionResultCard(result: _result!),
              const SizedBox(height: 16),
              SymptomsCard(symptoms: _result!.symptoms),
              const SizedBox(height: 16),
              TreatmentCard(treatments: _result!.treatments),
              const SizedBox(height: 16),
              PreventionCard(preventions: _result!.preventions),
              const SizedBox(height: 30),
              ScanAnotherButton(onTap: _onScanAnother),
            ],
          ],
        ),
      ),
    );
  }
}
