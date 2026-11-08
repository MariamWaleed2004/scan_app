import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:fekra_house/core/errors/exceptions.dart';
import '../models/scanned_document_model.dart';

/// Builds a PDF from captured page images and stores it in the app's
/// documents folder: `<app documents>/scans/Scan_<date>_<time>.pdf`.
class ScanPdfLocalDataSource {
  static const _timeout = Duration(seconds: 60);

  Future<ScannedDocumentModel> savePdf({required List<String> imagePaths, required String category}) async {
    try {
      final docsDir = await getApplicationDocumentsDirectory();
      final scansDir = Directory('${docsDir.path}${Platform.pathSeparator}scans');
      await scansDir.create(recursive: true);

      final now = DateTime.now();
      final name = 'Scan_${_stamp(now)}.pdf';
      final outPath = '${scansDir.path}${Platform.pathSeparator}$name';
      final pages = List<String>.of(imagePaths);

      // Camera photos are JPEG, so the PDF embeds them as-is (no re-encoding):
      // fast enough on the main isolate. The timeout guarantees the UI never
      // waits forever.
      final sizeBytes = await _buildPdf(pages, outPath).timeout(_timeout);

      // The captured photos were temporary; the PDF now holds them.
      for (final path in pages) {
        try {
          await File(path).delete();
        } catch (_) {}
      }

      return ScannedDocumentModel(
        name: name,
        filePath: outPath,
        pageCount: pages.length,
        sizeBytes: sizeBytes,
        createdAt: now.toIso8601String(),
        category: category,
      );
    } on FileSystemException catch (e) {
      throw CacheException('Could not save the PDF: ${e.message}');
    } on TimeoutException {
      throw const CacheException('Saving the PDF took too long. Please try again.');
    }
  }

  static Future<int> _buildPdf(List<String> imagePaths, String outPath) async {
    final doc = pw.Document();
    for (final path in imagePaths) {
      final image = pw.MemoryImage(await File(path).readAsBytes());
      doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(12),
        build: (_) => pw.Center(child: pw.Image(image, fit: pw.BoxFit.contain)),
      ));
    }
    final file = File(outPath);
    await file.writeAsBytes(await doc.save(), flush: true);
    return file.length();
  }

  static String _stamp(DateTime t) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${t.year}-${two(t.month)}-${two(t.day)}_${two(t.hour)}-${two(t.minute)}-${two(t.second)}';
  }
}
