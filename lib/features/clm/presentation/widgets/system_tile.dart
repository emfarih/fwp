import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/system.dart';

class SystemTile extends StatelessWidget {
  final System system;
  final VoidCallback onTap; // Callback for handling button press

  const SystemTile({super.key, required this.system, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        splashColor: Theme.of(context)
            .primaryColor
            .withOpacity(0.3), // Ripple effect color
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .primaryColor
                .withOpacity(0.1), // Button-like background
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Theme.of(context).primaryColor, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                system.fullName,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                system.shortName,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
