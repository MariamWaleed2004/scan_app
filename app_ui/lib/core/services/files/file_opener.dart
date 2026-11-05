import 'package:open_filex/open_filex.dart';

/// Opens a local file in the device's default app (e.g. a PDF viewer).
abstract class FileOpener {
  /// Returns false when no app could open the file.
  Future<bool> open(String path);
}

class OpenFilexFileOpener implements FileOpener {
  @override
  Future<bool> open(String path) async {
    final result = await OpenFilex.open(path);
    return result.type == ResultType.done;
  }
}
