import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'compliance_check_item.dart';
import 'compliance_config.dart';
import 'compliance_repository.dart';

class ComplianceState extends Equatable {
  final ComplianceConfig config;
  final List<ComplianceCheckItem> privacyItems;
  final List<ComplianceCheckItem> termsItems;
  final List<ComplianceCheckItem> dataSafetyItems;
  final List<ComplianceCheckItem> contentRatingItems;
  final List<ComplianceCheckItem> adsDisclosureItems;
  final List<ComplianceCheckItem> childrenFamilyItems;
  final List<ComplianceCheckItem> storeReadinessItems;

  const ComplianceState({
    required this.config,
    this.privacyItems = const [],
    this.termsItems = const [],
    this.dataSafetyItems = const [],
    this.contentRatingItems = const [],
    this.adsDisclosureItems = const [],
    this.childrenFamilyItems = const [],
    this.storeReadinessItems = const [],
  });

  ComplianceState copyWith({
    ComplianceConfig? config,
    List<ComplianceCheckItem>? privacyItems,
    List<ComplianceCheckItem>? termsItems,
    List<ComplianceCheckItem>? dataSafetyItems,
    List<ComplianceCheckItem>? contentRatingItems,
    List<ComplianceCheckItem>? adsDisclosureItems,
    List<ComplianceCheckItem>? childrenFamilyItems,
    List<ComplianceCheckItem>? storeReadinessItems,
  }) {
    return ComplianceState(
      config: config ?? this.config,
      privacyItems: privacyItems ?? this.privacyItems,
      termsItems: termsItems ?? this.termsItems,
      dataSafetyItems: dataSafetyItems ?? this.dataSafetyItems,
      contentRatingItems: contentRatingItems ?? this.contentRatingItems,
      adsDisclosureItems: adsDisclosureItems ?? this.adsDisclosureItems,
      childrenFamilyItems: childrenFamilyItems ?? this.childrenFamilyItems,
      storeReadinessItems: storeReadinessItems ?? this.storeReadinessItems,
    );
  }

  @override
  List<Object?> get props => [
        config,
        privacyItems,
        termsItems,
        dataSafetyItems,
        contentRatingItems,
        adsDisclosureItems,
        childrenFamilyItems,
        storeReadinessItems,
      ];
}

class ComplianceCubit extends Cubit<ComplianceState> {
  final ComplianceRepository _repository;

  ComplianceCubit({
    required ComplianceRepository repository,
    ComplianceConfig? initialConfig,
  })  : _repository = repository,
        super(ComplianceState(
          config: initialConfig ?? defaultComplianceConfig,
        ));

  void load() {
    refreshChecklists();
  }

  void updateConfig(ComplianceConfig config) {
    emit(state.copyWith(config: config));
    refreshChecklists();
  }

  void refreshChecklists() {
    final config = state.config;
    emit(state.copyWith(
      privacyItems: _repository.getPrivacyPolicyChecklist(config),
      termsItems: _repository.getTermsChecklist(config),
      dataSafetyItems: _repository.getDataSafetyChecklist(config),
      contentRatingItems: _repository.getContentRatingChecklist(config),
      adsDisclosureItems: _repository.getAdsDisclosureChecklist(config),
      childrenFamilyItems: _repository.getChildrenFamilyChecklist(config),
      storeReadinessItems: _repository.getStoreReadinessChecklist(config),
    ));
  }
}
