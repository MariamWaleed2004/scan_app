/// Technical errors thrown by data sources (network, storage, ...).
/// They never leave the data layer: repositories convert them to [Failure]s.
class ServerException implements Exception {
  final String? message;
  const ServerException([this.message]);
}

class CacheException implements Exception {
  final String? message;
  const CacheException([this.message]);
}
