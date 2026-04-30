import 'package:flutter/material.dart';
import 'package:agrisense/data/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final config = _TypeConfig.fromType(notification.type);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: config.bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: config.borderColor, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: config.iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(config.icon, color: config.iconColor, size: 22),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: notification.isUnread
                          ? FontWeight.w700
                          : FontWeight.w600,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF555577),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatTime(notification.time),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9999AA),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            if (notification.isUnread)
              Container(
                margin: const EdgeInsets.only(left: 8, top: 4),
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: Color(0xFF9810FA),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    }
    return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
  }
}

class _TypeConfig {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final Color borderColor;

  const _TypeConfig({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.borderColor,
  });

  factory _TypeConfig.fromType(String type) {
    switch (type.toLowerCase()) {
      case 'alert':
      case 'disease':
        return const _TypeConfig(
          icon: Icons.warning_amber_rounded,
          iconColor: Color(0xFFE53935),
          bgColor: Color(0xFFFFF0F0),
          borderColor: Color(0xFFFFCDD2),
        );
      case 'weather':
        return const _TypeConfig(
          icon: Icons.water_drop_outlined,
          iconColor: Color(0xFF1565C0),
          bgColor: Color(0xFFEEF4FF),
          borderColor: Color(0xFFBBDEFB),
        );
      case 'recommendation':
      case 'farming tip':
        return const _TypeConfig(
          icon: Icons.lightbulb_outline,
          iconColor: Color(0xFFF9A825),
          bgColor: Color(0xFFFFFDE7),
          borderColor: Color(0xFFFFF9C4),
        );
      // Auth notification types
      case 'login':
        return const _TypeConfig(
          icon: Icons.login_rounded,
          iconColor: Color(0xFF2E7D32),
          bgColor: Color(0xFFE8F5E9),
          borderColor: Color(0xFFC8E6C9),
        );
      case 'logout':
        return const _TypeConfig(
          icon: Icons.logout_rounded,
          iconColor: Color(0xFFE65100),
          bgColor: Color(0xFFFFF3E0),
          borderColor: Color(0xFFFFE0B2),
        );
      case 'registration':
        return const _TypeConfig(
          icon: Icons.person_add_alt_1_rounded,
          iconColor: Color(0xFF00796B),
          bgColor: Color(0xFFE0F2F1),
          borderColor: Color(0xFFB2DFDB),
        );
      case 'password_reset':
        return const _TypeConfig(
          icon: Icons.lock_reset_rounded,
          iconColor: Color(0xFF1565C0),
          bgColor: Color(0xFFE3F2FD),
          borderColor: Color(0xFFBBDEFB),
        );
      case 'password_changed':
        return const _TypeConfig(
          icon: Icons.lock_outline_rounded,
          iconColor: Color(0xFF7B1FA2),
          bgColor: Color(0xFFF3E5F5),
          borderColor: Color(0xFFCE93D8),
        );
      default:
        return const _TypeConfig(
          icon: Icons.notifications_outlined,
          iconColor: Color(0xFF00897B),
          bgColor: Color(0xFFE8F5E9),
          borderColor: Color(0xFFC8E6C9),
        );
    }
  }
}
