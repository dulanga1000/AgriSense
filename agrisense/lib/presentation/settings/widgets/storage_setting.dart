import 'package:flutter/material.dart';
import 'package:agrisense/presentation/settings/state/setting_state.dart';

class StorageSetting extends StatefulWidget {
  final SettingState settingState;

  const StorageSetting({super.key, required this.settingState});

  @override
  State<StorageSetting> createState() => _StorageSettingState();
}

class _StorageSettingState extends State<StorageSetting> {
  String _cacheSize = "45 MB";
  bool _isClearing = false;

  Future<void> _clearCache() async {
    if (_cacheSize == "0 MB") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cache is already empty!'),
          backgroundColor: Colors.grey,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() => _isClearing = true);

    // Simulate the time taken to clear files/database cache
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _cacheSize = "0 MB";
      _isClearing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cache cleared successfully!'),
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
            "Data & Storage",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          _buildSwitchTile(
            icon: Icons.dns_outlined,
            title: "Auto Update",
            subtitle: "Update data automatically",
            value: widget.settingState.autoUpdate,
            onChanged: widget.settingState.toggleAutoUpdate,
          ),
          const SizedBox(height: 16),
          _buildActionTile(
            icon: Icons.delete_outline, // Updated icon to better match action
            title: "Clear Cache",
            trailingWidget: _isClearing
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF00AA4F),
                    ),
                  )
                : Text(
                    _cacheSize,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
            onTap: _isClearing ? () {} : _clearCache,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Icon(icon, size: 22, color: Colors.black),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: const Color(0xFF00AA4F),
          activeThumbColor: Colors.white,
          inactiveTrackColor: const Color(0xFFE4E6EB),
          inactiveThumbColor: Colors.white,
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required Widget trailingWidget,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Icon(icon, size: 22, color: Colors.black),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            trailingWidget,
          ],
        ),
      ),
    );
  }
}