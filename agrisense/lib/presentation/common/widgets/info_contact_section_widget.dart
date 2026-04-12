import 'package:flutter/material.dart';

class ContactItem {
  final IconData icon;
  final String text;

  const ContactItem({required this.icon, required this.text});
}

class InfoContactSectionWidget extends StatelessWidget {
  final IconData titleIcon;
  final String title;
  final String description;
  final List<ContactItem> items;

  final Color? backgroundColor;
  final Gradient? gradient;

  const InfoContactSectionWidget({
    super.key,
    required this.titleIcon,
    required this.title,
    required this.description,
    required this.items,
    this.backgroundColor,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: gradient == null ? backgroundColor : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 Title Row
          Row(
            children: [
              Icon(titleIcon, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 📄 Description
          Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 10),

          // 🔁 Contact Items
          ...items.map((e) => _buildItem(e)),
        ],
      ),
    );
  }

  Widget _buildItem(ContactItem item) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(item.icon, color: Colors.white, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              item.text,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
