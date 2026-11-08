import '../../domain/entities/storage_usage.dart';

class StorageUsageModel {
  final double usedGb;
  final double totalGb;
  const StorageUsageModel({required this.usedGb, required this.totalGb});

  factory StorageUsageModel.fromJson(Map<String, dynamic> j) => StorageUsageModel(
        usedGb: (j['used_gb'] as num).toDouble(),
        totalGb: (j['total_gb'] as num).toDouble(),
      );

  StorageUsage toEntity() => StorageUsage(usedGb, totalGb);
}
