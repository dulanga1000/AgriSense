import 'package:flutter/material.dart';
import 'package:agrisense/presentation/settings/state/setting_state.dart';

class AboutSetting extends StatefulWidget {
  final SettingState settingState; // Add the state parameter

  const AboutSetting({super.key, required this.settingState});

  @override
  State<AboutSetting> createState() => _AboutSettingState();
}

class _AboutSettingState extends State<AboutSetting> {
  bool _isCheckingForUpdates = false;

  Future<void> _checkForUpdates() async {
    setState(() => _isCheckingForUpdates = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isCheckingForUpdates = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your app is already up to date!'),
        backgroundColor: Color(0xFF00AA4F),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoRow(label: "Version", value: "1.0.0"),
          const SizedBox(height: 16),
          _buildInfoRow(label: "Build", value: "2024.02.07"),
          const SizedBox(height: 24),
          
          // Conditionally render the button based on the autoUpdate state
          if (widget.settingState.autoUpdate)
            Center(
              child: InkWell(
                onTap: _isCheckingForUpdates ? null : _checkForUpdates,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: _isCheckingForUpdates
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF00AA4F),
                          ),
                        )
                      : const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.file_download_outlined,
                              size: 20,
                              color: Color(0xFF00AA4F),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Check for Updates",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF00AA4F),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, color: Colors.black54),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}