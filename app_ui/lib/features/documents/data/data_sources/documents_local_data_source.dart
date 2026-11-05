import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:fekra_house/core/errors/exceptions.dart';
import '../../domain/entities/folder_category.dart';
import '../models/document_model.dart';

/// Documents saved on this device. PDFs live in `<app documents>/scans/`, and
/// `scans/index.json` keeps their details (folder, date, size).
///
/// The PDF files are the source of truth: entries whose file was deleted are
/// dropped, and PDFs without an index entry (e.g. saved before the index
/// existed) are still listed.
class DocumentsLocalDataSource {
  static const _scansFolder = 'scans';
  static const _indexFile = 'index.json';
  static final _sep = Platform.pathSeparator;

  final _changes = StreamController<void>.broadcast();

  /// Emits after every successful [addDocument].
  Stream<void> get changes => _changes.stream;

  Future<List<DocumentModel>> getSavedDocuments() async {
    try {
      final dir = await _scansDir();
      final indexByName = {for (final m in await _readIndex(dir)) m.name: m};
      final result = <DocumentModel>[];

      await for (final entity in dir.list()) {
        if (entity is! File || !entity.path.toLowerCase().endsWith('.pdf')) continue;
        final name = entity.path.split(_sep).last;
        final known = indexByName[name];
        if (known != null) {
          // Rebuild the path: on iOS the app folder can move between installs.
          result.add(known.withFilePath(entity.path));
        } else {
          final stat = await entity.stat();
          result.add(DocumentModel(
            id: name,
            name: name,
            category: FolderCategory.architecture.name,
            sizeMb: stat.size / (1024 * 1024),
            createdAt: stat.modified.toIso8601String(),
            filePath: entity.path,
          ));
        }
      }

      result.sort((a, b) => DateTime.parse(b.createdAt).compareTo(DateTime.parse(a.createdAt)));
      return result;
    } on FileSystemException catch (e) {
      throw CacheException('Could not read saved documents: ${e.message}');
    }
  }

  Future<void> addDocument(DocumentModel document) async {
    try {
      final dir = await _scansDir();
      final entries = (await _readIndex(dir)).where((m) => m.name != document.name).toList()
        ..insert(0, document);
      await File('${dir.path}$_sep$_indexFile')
          .writeAsString(jsonEncode([for (final m in entries) m.toJson()]), flush: true);
      _changes.add(null);
    } on FileSystemException catch (e) {
      throw CacheException('Could not save the document to history: ${e.message}');
    }
  }

  Future<Directory> _scansDir() async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory('${docs.path}$_sep$_scansFolder');
    await dir.create(recursive: true);
    return dir;
  }

  Future<List<DocumentModel>> _readIndex(Directory dir) async {
    final file = File('${dir.path}$_sep$_indexFile');
    if (!await file.exists()) return [];
    try {
      final list = jsonDecode(await file.readAsString()) as List;
      return [for (final item in list) DocumentModel.fromJson(item as Map<String, dynamic>)];
    } on FormatException {
      return []; // corrupted index: fall back to listing the PDFs only
    } on TypeError {
      return [];
    }
  }
}
