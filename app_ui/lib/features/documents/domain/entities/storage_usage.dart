class StorageUsage {
  final double usedGb;
  final double totalGb;
  const StorageUsage(this.usedGb, this.totalGb);

  String get label => '$usedGb GB of ${totalGb.toStringAsFixed(0)} GB';
}
