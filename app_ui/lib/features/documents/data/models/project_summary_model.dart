import '../../domain/entities/project_summary.dart';

class ProjectSummaryModel {
  final String name;
  final int blueprintCount;
  final String synced;
  final List<String> memberInitials;

  const ProjectSummaryModel({
    required this.name,
    required this.blueprintCount,
    required this.synced,
    required this.memberInitials,
  });

  factory ProjectSummaryModel.fromJson(Map<String, dynamic> j) => ProjectSummaryModel(
        name: j['name'] as String,
        blueprintCount: j['blueprint_count'] as int,
        synced: j['synced'] as String,
        memberInitials: List<String>.from(j['member_initials'] as List),
      );

  ProjectSummary toEntity() => ProjectSummary(
        name: name,
        blueprintCount: blueprintCount,
        syncedLabel: synced,
        memberInitials: memberInitials,
      );
}
