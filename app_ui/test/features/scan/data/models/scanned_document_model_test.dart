import 'package:flutter_test/flutter_test.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';
import 'package:fekra_house/features/scan/data/models/scanned_document_model.dart';

void main() {
  test('toEntity converts bytes to MB, parses the date and the folder', () {
    const model = ScannedDocumentModel(
      name: 'Scan.pdf',
      filePath: '/docs/scans/Scan.pdf',
      pageCount: 3,
      sizeBytes: 2 * 1024 * 1024,
      createdAt: '2026-11-03T10:30:00.000',
      category: 'inspections',
    );

    final entity = model.toEntity();

    expect(entity.sizeMb, 2.0);
    expect(entity.sizeLabel, '2.0 MB');
    expect(entity.pagesLabel, '3 pages');
    expect(entity.createdAt, DateTime(2026, 11, 3, 10, 30));
    expect(entity.category, FolderCategory.inspections);
  });
}
