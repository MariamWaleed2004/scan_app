import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/features/documents/domain/entities/document_file.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';
import 'package:fekra_house/features/documents/domain/use_cases/add_document.dart';
import 'package:fekra_house/features/scan/domain/entities/scanned_document.dart';
import 'package:fekra_house/features/scan/domain/repositories/scan_repository.dart';
import 'package:fekra_house/features/scan/domain/use_cases/save_scan_as_pdf.dart';

class MockScanRepository extends Mock implements ScanRepository {}

class MockAddDocument extends Mock implements AddDocument {}

void main() {
  late MockScanRepository repository;
  late MockAddDocument addDocument;
  late SaveScanAsPdf saveScanAsPdf;

  final scan = ScannedDocument(
    name: 'Scan.pdf',
    filePath: '/docs/scans/Scan.pdf',
    pageCount: 2,
    sizeMb: 1.2,
    createdAt: DateTime(2026, 1, 1),
    category: FolderCategory.legal,
  );

  setUpAll(() {
    registerFallbackValue(FolderCategory.architecture);
    registerFallbackValue(<String>[]);
    registerFallbackValue(DocumentFile(
        id: '', name: '', category: FolderCategory.legal, sizeMb: 0, createdAt: DateTime(2026)));
  });

  setUp(() {
    repository = MockScanRepository();
    addDocument = MockAddDocument();
    saveScanAsPdf = SaveScanAsPdf(repository, addDocument);
  });

  test('refuses to save when no pages were captured', () async {
    final result = await saveScanAsPdf(const SaveScanParams(imagePaths: [], category: FolderCategory.legal));

    expect(result, const Left<Failure, ScannedDocument>(ValidationFailure('Capture at least one page before saving.')));
    verifyNever(() => repository.savePdf(imagePaths: any(named: 'imagePaths'), category: any(named: 'category')));
  });

  test('saves the PDF and adds it to the documents history', () async {
    when(() => repository.savePdf(imagePaths: ['a.jpg', 'b.jpg'], category: FolderCategory.legal))
        .thenAnswer((_) async => Right(scan));
    when(() => addDocument(any())).thenAnswer((_) async => const Right(unit));

    final result =
        await saveScanAsPdf(const SaveScanParams(imagePaths: ['a.jpg', 'b.jpg'], category: FolderCategory.legal));

    expect(result, Right<Failure, ScannedDocument>(scan));
    final added = verify(() => addDocument(captureAny())).captured.single as DocumentFile;
    expect(added.filePath, '/docs/scans/Scan.pdf');
    expect(added.category, FolderCategory.legal);
    expect(added.createdAt, DateTime(2026, 1, 1));
  });

  test('does not add to history when the PDF could not be saved', () async {
    when(() => repository.savePdf(imagePaths: ['a.jpg'], category: FolderCategory.legal))
        .thenAnswer((_) async => const Left(CacheFailure('Disk full')));

    final result = await saveScanAsPdf(const SaveScanParams(imagePaths: ['a.jpg'], category: FolderCategory.legal));

    expect(result, const Left<Failure, ScannedDocument>(CacheFailure('Disk full')));
    verifyNever(() => addDocument(any()));
  });
}
