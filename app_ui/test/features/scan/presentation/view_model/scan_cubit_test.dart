import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/services/files/file_opener.dart';
import 'package:fekra_house/features/documents/domain/entities/folder_category.dart';
import 'package:fekra_house/features/scan/domain/entities/scanned_document.dart';
import 'package:fekra_house/features/scan/domain/use_cases/save_scan_as_pdf.dart';
import 'package:fekra_house/features/scan/presentation/view_model/scan_cubit.dart';
import 'package:fekra_house/features/scan/presentation/view_model/scan_state.dart';

class MockSaveScanAsPdf extends Mock implements SaveScanAsPdf {}

class MockFileOpener extends Mock implements FileOpener {}

void main() {
  late MockSaveScanAsPdf saveScanAsPdf;
  late MockFileOpener fileOpener;

  final document = ScannedDocument(
    name: 'Scan.pdf',
    filePath: '/docs/scans/Scan.pdf',
    pageCount: 2,
    sizeMb: 1.2,
    createdAt: DateTime(2026, 1, 1),
    category: FolderCategory.legal,
  );

  setUpAll(() => registerFallbackValue(const SaveScanParams(imagePaths: [], category: FolderCategory.legal)));

  setUp(() {
    saveScanAsPdf = MockSaveScanAsPdf();
    fileOpener = MockFileOpener();
  });

  ScanCubit build() => ScanCubit(saveScanAsPdf: saveScanAsPdf, fileOpener: fileOpener);

  blocTest<ScanCubit, ScanState>(
    'adds and removes pages in order',
    build: build,
    act: (cubit) => cubit
      ..addPage('a.jpg')
      ..addPage('b.jpg')
      ..removePage(0),
    expect: () => const [
      ScanState(pages: ['a.jpg']),
      ScanState(pages: ['a.jpg', 'b.jpg']),
      ScanState(pages: ['b.jpg']),
    ],
  );

  blocTest<ScanCubit, ScanState>(
    'save emits saving then saved, and clears the captured pages',
    setUp: () => when(() => saveScanAsPdf(any())).thenAnswer((_) async => Right(document)),
    build: build,
    seed: () => const ScanState(pages: ['a.jpg', 'b.jpg'], category: FolderCategory.legal),
    act: (cubit) => cubit.save(),
    expect: () => [
      const ScanState(pages: ['a.jpg', 'b.jpg'], category: FolderCategory.legal, saveStatus: ScanSaveStatus.saving),
      ScanState(category: FolderCategory.legal, saveStatus: ScanSaveStatus.saved, savedDocument: document),
    ],
    verify: (_) {
      final params = verify(() => saveScanAsPdf(captureAny())).captured.single as SaveScanParams;
      expect(params.imagePaths, ['a.jpg', 'b.jpg']);
      expect(params.category, FolderCategory.legal);
    },
  );

  blocTest<ScanCubit, ScanState>(
    'save keeps the pages and reports the failure',
    setUp: () => when(() => saveScanAsPdf(any())).thenAnswer((_) async => const Left(CacheFailure('Disk full'))),
    build: build,
    seed: () => const ScanState(pages: ['a.jpg']),
    act: (cubit) => cubit.save(),
    expect: () => const [
      ScanState(pages: ['a.jpg'], saveStatus: ScanSaveStatus.saving),
      ScanState(pages: ['a.jpg'], saveStatus: ScanSaveStatus.failure, errorMessage: 'Disk full'),
    ],
  );

  blocTest<ScanCubit, ScanState>(
    'save does nothing when there are no pages',
    build: build,
    act: (cubit) => cubit.save(),
    expect: () => const <ScanState>[],
  );

  blocTest<ScanCubit, ScanState>(
    'openSavedPdf reports when no app can open the file',
    setUp: () => when(() => fileOpener.open(any())).thenAnswer((_) async => false),
    build: build,
    seed: () => ScanState(saveStatus: ScanSaveStatus.saved, savedDocument: document),
    act: (cubit) => cubit.openSavedPdf(),
    expect: () => [
      ScanState(
        saveStatus: ScanSaveStatus.failure,
        savedDocument: document,
        errorMessage: 'No app found to open PDF files.',
      ),
    ],
  );
}
