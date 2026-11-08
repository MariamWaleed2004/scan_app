import 'package:flutter_test/flutter_test.dart';
import 'package:fekra_house/features/documents/data/models/document_model.dart';
import 'package:fekra_house/features/documents/domain/entities/document_file.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';

void main() {
  test('fromJson + toEntity maps API fields to the domain entity', () {
    final model = DocumentModel.fromJson(const {
      'id': '1',
      'name': 'Contract.pdf',
      'category': 'legal',
      'size_mb': 2,
      'created_at': '2026-11-05T11:20:00.000',
      'file_path': '/docs/scans/Contract.pdf',
    });

    expect(
      model.toEntity(),
      DocumentFile(
        id: '1',
        name: 'Contract.pdf',
        category: FolderCategory.legal,
        sizeMb: 2.0,
        createdAt: DateTime(2026, 11, 5, 11, 20),
        filePath: '/docs/scans/Contract.pdf',
      ),
    );
  });

  test('fromEntity → toJson → fromJson round-trips', () {
    final entity = DocumentFile(
      id: 'Scan.pdf',
      name: 'Scan.pdf',
      category: FolderCategory.inspections,
      sizeMb: 1.25,
      createdAt: DateTime(2026, 1, 2, 3, 4),
      filePath: '/docs/scans/Scan.pdf',
    );

    expect(DocumentModel.fromJson(DocumentModel.fromEntity(entity).toJson()).toEntity(), entity);
  });
}
