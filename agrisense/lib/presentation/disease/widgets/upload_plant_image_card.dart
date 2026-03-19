import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/gradient_icon_button.dart';

class UploadPlantImageCard extends StatefulWidget {
  const UploadPlantImageCard({super.key, required this.onImageSelected});

  final ValueChanged<File> onImageSelected;

  @override
  State<UploadPlantImageCard> createState() => _UploadPlantImageCardState();
}

class _UploadPlantImageCardState extends State<UploadPlantImageCard> {
  final ImagePicker _picker = ImagePicker();

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (image != null) {
        widget.onImageSelected(File(image.path));
      }
    } on PlatformException catch (e) {
      _showError(
        'Unable to open ${source == ImageSource.camera ? 'camera' : 'gallery'}: ${e.message ?? 'permission denied or unavailable.'}',
      );
    } catch (_) {
      _showError(
        'Something went wrong while selecting image. Please try again.',
      );
    }
  }

  Future<void> takePhoto() async {
    await _pickImage(ImageSource.camera);
  }

  Future<void> uploadFromGallery() async {
    await _pickImage(ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFFFFE5E5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.eco_outlined,
                size: 48,
                color: Color(0xFFFB2C36),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Upload Plant Image",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Tap to upload an image of your plant for disease diagnosis.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 8),

            GradientIconButton(
              icon: Icons.camera_alt_outlined,
              text: "Take Photo",
              isPrimary: true,
              onPressed: () => takePhoto(),
            ),

            const SizedBox(height: 16),

            GradientIconButton(
              icon: Icons.upload_outlined,
              text: "Upload from Gallery",
              isPrimary: false,
              onPressed: () => uploadFromGallery(),
            ),
          ],
        ),
      ),
    );
  }
}
