import 'package:flutter/material.dart';
import '../../../core/compliance/compliance_check_item.dart';
import '../../../core/compliance/compliance_status.dart';

class ComplianceChecklistTile extends StatelessWidget {
  final ComplianceCheckItem item;
  final ValueChanged<bool?>? onChanged;

  const ComplianceChecklistTile({
    super.key,
    required this.item,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDone = item.status == ComplianceStatus.ready;

    return CheckboxListTile(
      value: isDone,
      onChanged: onChanged,
      title: Text(
        item.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          decoration: isDone ? TextDecoration.lineThrough : null,
          color: isDone ? Colors.grey : null,
        ),
      ),
      subtitle: Text(
        item.description,
        style: TextStyle(
          decoration: isDone ? TextDecoration.lineThrough : null,
          color: isDone ? Colors.grey : null,
        ),
      ),
      secondary: Icon(
        item.isRequired ? Icons.error_outline : Icons.info_outline,
        color: item.isRequired && !isDone ? Colors.red : Colors.grey,
      ),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
