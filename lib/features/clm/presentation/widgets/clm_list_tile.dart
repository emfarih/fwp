import 'package:flutter/material.dart';

class CLMListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap; // Callback for handling button press
  final IconData? leadingIcon; // Optional leading icon

  const CLMListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.leadingIcon = Icons.settings, // Default icon if not provided
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        splashColor: Colors.red.withOpacity(0.3), // Ripple effect with red
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1), // Light red background
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.red, width: 2), // Red border
          ),
          child: Row(
            children: [
              // Leading icon or circle avatar
              CircleAvatar(
                backgroundColor: Colors.red,
                child:
                    Icon(leadingIcon, color: Colors.white), // Configurable icon
              ),
              const SizedBox(width: 16.0),
              // Column for title and subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red, // Red text for title
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[700], // Subtle text for subtitle
                      ),
                    ),
                  ],
                ),
              ),
              // Trailing icon
              const Icon(Icons.arrow_forward_ios, color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }
}
