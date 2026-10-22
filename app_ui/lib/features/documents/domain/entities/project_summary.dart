class ProjectSummary {
  final String name;
  final int blueprintCount;
  final String syncedLabel;
  final List<String> memberInitials;
  const ProjectSummary({
    required this.name,
    required this.blueprintCount,
    required this.syncedLabel,
    required this.memberInitials,
  });
}
