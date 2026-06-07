import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_check_item.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_status.dart';

void main() {
  group('ComplianceCheckItem', () {
    test('creates required item with default status', () {
      const item = ComplianceCheckItem(
        id: 'test_1',
        title: 'Title',
        description: 'Desc',
      );
      
      expect(item.status, ComplianceStatus.notStarted);
      expect(item.isRequired, true);
    });

    test('copyWith changes status', () {
      const item = ComplianceCheckItem(
        id: 'test_1',
        title: 'Title',
        description: 'Desc',
      );
      
      final updated = item.copyWith(status: ComplianceStatus.ready);
      expect(updated.status, ComplianceStatus.ready);
      expect(updated.id, 'test_1');
    });

    test('equality works', () {
      const item1 = ComplianceCheckItem(id: '1', title: 'A', description: 'B');
      const item2 = ComplianceCheckItem(id: '1', title: 'A', description: 'B');
      
      expect(item1, equals(item2));
    });
  });
}
