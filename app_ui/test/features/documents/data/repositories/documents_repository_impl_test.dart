import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fekra_house/core/errors/exceptions.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/features/documents/data/data_sources/documents_mock_data_source.dart';
import 'package:fekra_house/features/documents/data/models/document_model.dart';
import 'package:fekra_house/features/documents/data/repositories/documents_repository_impl.dart';
import 'package:fekra_house/features/documents/domain/entities/document_file.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';

class MockDocumentsDataSource extends Mock implements DocumentsMockDataSource {}

void main() {
  late MockDocumentsDataSource source;
  late DocumentsRepositoryImpl repository;

  setUp(() {
    source = MockDocumentsDataSource();
    repository = DocumentsRepositoryImpl(source);
  });

  test('maps document models to entities', () async {
    when(() => source.getRecentFiles()).thenAnswer((_) async => const [
          DocumentModel(id: '1', name: 'a.pdf', category: 'legal', sizeMb: 1.5, modified: 'Today'),
        ]);

    final result = await repository.getRecentFiles();

    expect(result.getOrElse(() => const []), const [
      DocumentFile(id: '1', name: 'a.pdf', category: FolderCategory.legal, sizeMb: 1.5, modifiedLabel: 'Today'),
    ]);
  });

  test('converts ServerException into ServerFailure', () async {
    when(() => source.getRecentFiles()).thenThrow(const ServerException());

    expect(await repository.getRecentFiles(), const Left<Failure, List<DocumentFile>>(ServerFailure()));
  });
}
