import 'package:flutter/material.dart';

class PolicyMarkdownView extends StatelessWidget {
  final String text;

  const PolicyMarkdownView({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    // In a real app, use a package like flutter_markdown.
    // For simplicity without adding dependencies, we display as a formatted text block.
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SelectableText(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          height: 1.5,
        ),
      ),
    );
  }
}
