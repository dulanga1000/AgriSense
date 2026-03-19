import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/notification/state/notification_state.dart';
import 'package:agrisense/presentation/notification/widgets/notification_card.dart';
import 'package:agrisense/presentation/common/widgets/notification_setting.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<NotificationState>().loadNotifications(forceRefresh: true);
    });
  }

  int _unreadCount(NotificationState state) =>
      state.notifications.where((n) => n.isUnread).length;

  void _showReadAlert(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: const Color(0xFF1E1E2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF9810FA).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mark_email_read_outlined,
                color: Color(0xFF9810FA),
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Notification marked as read',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NotificationState>();
    final unreadCount = _unreadCount(state);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: _NotificationAppBar(
        unreadCount: unreadCount,
        onSettingsTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: const Text('Notification Settings'),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                body: SingleChildScrollView(child: NotificationSetting()),
              ),
            ),
          );
        },
        onMarkAllRead: unreadCount > 0
            ? () async {
                await context.read<NotificationState>().markAllAsRead();
                if (!context.mounted) return;
                _showReadAlert(context);
              }
            : null,
      ),
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, NotificationState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF9810FA)),
      );
    }

    if (state.hasError) {
      return _ErrorView(
        message: state.errorMessage ?? 'Something went wrong',
        onRetry: () => context.read<NotificationState>().loadNotifications(
          forceRefresh: true,
        ),
      );
    }

    if (state.notifications.isEmpty) {
      return const _EmptyView();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: state.notifications.length,
      itemBuilder: (context, index) {
        final notification = state.notifications[index];
        return NotificationCard(
          notification: notification,
          onTap: () async {
            await context.read<NotificationState>().markAsRead(notification.id);
            if (!context.mounted) return;

            _showReadAlert(context);
          },
        );
      },
    );
  }
}

class _NotificationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final int unreadCount;
  final VoidCallback onSettingsTap;
  final VoidCallback? onMarkAllRead;

  const _NotificationAppBar({
    required this.unreadCount,
    required this.onSettingsTap,
    this.onMarkAllRead,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF9810FA), Color(0xFF6A00C8)],
          ),
        ),
      ),
      leading: const AppBackButton(fallbackIndex: 0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Notifications',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          if (unreadCount > 0)
            Text(
              '$unreadCount unread message${unreadCount > 1 ? 's' : ''}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
      actions: [
        if (onMarkAllRead != null)
          TextButton(
            onPressed: onMarkAllRead,
            child: const Text(
              'Mark all',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            if (unreadCount > 0)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF3B30),
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    unreadCount > 9 ? '9+' : '$unreadCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),

        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
          onPressed: onSettingsTap,
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 52, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9810FA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, color: Colors.white, size: 18),
              label: const Text('Retry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 56, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            'No notifications yet',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
