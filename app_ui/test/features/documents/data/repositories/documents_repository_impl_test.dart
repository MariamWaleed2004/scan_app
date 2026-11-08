import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fekra_house/core/errors/exceptions.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/features/documents/data/data_sources/documents_local_data_source.dart';
import 'package:fekra_house/features/documents/data/data_sources/documents_mock_data_source.dart';
import 'package:fekra_house/features/documents/data/models/document_model.dart';
import 'package:fekra_house/features/documents/data/repositories/documents_repository_impl.dart';
import 'package:fekra_house/features/documents/domain/entities/document_file.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';

class MockDocumentsMockDataSource extends Mock implements DocumentsMockDataSource {}

class MockDocumentsLocalDataSource extends Mock implements DocumentsLocalDataSource {}

void main() {
  late MockDocumentsMockDataSource mock;
  late MockDocumentsLocalDataSource local;
  late DocumentsRepositoryImpl repository;

  const model = DocumentModel(
    id: 'Scan.pdf',
    name: 'Scan.pdf',
    category: 'legal',
    sizeMb: 1.5,
    createdAt: '2026-11-05T10:00:00.000',
    filePath: '/docs/scans/Scan.pdf',
  );
  final entity = DocumentFile(
    id: 'Scan.pdf',
    name: 'Scan.pdf',
    category: FolderCategory.legal,
    sizeMb: 1.5,
    createdAt: DateTime(2026, 11, 5, 10),
    filePath: '/docs/scans/Scan.pdf',
  );

  setUpAll(() => registerFallbackValue(model));

  setUp(() {
    mock = MockDocumentsMockDataSource();
    local = MockDocumentsLocalDataSource();
    repository = DocumentsRepositoryImpl(mock: mock, local: local);
  });

  test('getSavedDocuments maps local models to entities', () async {
    when(() => local.getSavedDocuments()).thenAnswer((_) async => const [model]);

    final result = await repository.getSavedDocuments();

    expect(result.getOrElse(() => const []), [entity]);
  });

  test('getSavedDocuments converts CacheException into CacheFailure', () async {
    when(() => local.getSavedDocuments()).thenThrow(const CacheException('Disk error'));

    expect(await repository.getSavedDocuments(), const Left<Failure, List<DocumentFile>>(CacheFailure('Disk error')));
  });

  test('addDocument stores the entity as a model', () async {
    when(() => local.addDocument(any())).thenAnswer((_) async {});

    expect(await repository.addDocument(entity), const Right<Failure, Unit>(unit));
    final stored = verify(() => local.addDocument(captureAny())).captured.single as DocumentModel;
    expect(stored.toEntity(), entity);
  });

  test('getRecentFiles converts ServerException into ServerFailure', () async {
    when(() => mock.getRecentFiles()).thenThrow(const ServerException());

    expect(await repository.getRecentFiles(), const Left<Failure, List<DocumentFile>>(ServerFailure()));
  });
}
