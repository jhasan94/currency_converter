import 'package:flutter/material.dart';

class CustomOptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const CustomOptionCard({
    super.key,
    required this.title,
    required this.icon,
    this.iconColor = const Color(0xFF43A047), // Default green color
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.green[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 36,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
