import 'package:equatable/equatable.dart';
import 'compliance_status.dart';

class ComplianceCheckItem extends Equatable {
  final String id;
  final String title;
  final String description;
  final ComplianceStatus status;
  final bool isRequired;
  final String? actionLabel;
  final String? documentationPath;

  const ComplianceCheckItem({
    required this.id,
    required this.title,
    required this.description,
    this.status = ComplianceStatus.notStarted,
    this.isRequired = true,
    this.actionLabel,
    this.documentationPath,
  });

  ComplianceCheckItem copyWith({
    String? id,
    String? title,
    String? description,
    ComplianceStatus? status,
    bool? isRequired,
    String? actionLabel,
    String? documentationPath,
  }) {
    return ComplianceCheckItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      isRequired: isRequired ?? this.isRequired,
      actionLabel: actionLabel ?? this.actionLabel,
      documentationPath: documentationPath ?? this.documentationPath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        isRequired,
        actionLabel,
        documentationPath,
      ];
}
