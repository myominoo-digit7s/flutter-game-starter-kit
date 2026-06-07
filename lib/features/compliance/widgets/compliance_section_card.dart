import 'package:flutter/material.dart';

class ComplianceSectionCard extends StatelessWidget {
  final String title;
  final String description;
  final int totalItems;
  final int completedItems;
  final VoidCallback onTap;

  const ComplianceSectionCard({
    super.key,
    required this.title,
    required this.description,
    required this.totalItems,
    required this.completedItems,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isComplete = totalItems > 0 && completedItems == totalItems;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  _buildStatusBadge(context, isComplete),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    isComplete ? Icons.check_circle : Icons.pending_actions,
                    size: 16,
                    color: isComplete ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$completedItems / $totalItems items reviewed',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, bool isComplete) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isComplete ? Colors.green.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isComplete ? 'Ready' : 'Needs Review',
        style: TextStyle(
          color: isComplete ? Colors.green : Colors.orange,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
