import 'package:app_ui/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../domain/entities/folder_category.dart';

/// Maps domain categories to UI colors (keeps the domain free of Flutter).
extension CategoryStyle on FolderCategory {
  Color get tagColor => switch (this) {
        FolderCategory.architecture => AppColors.sand,
        FolderCategory.inspections => AppColors.pink,
        FolderCategory.legal => AppColors.blueTag,
        FolderCategory.financial => AppColors.pink,
      };

  Color get folderBg => switch (this) {
        FolderCategory.architecture => const Color(0xFFE3EAEE),
        FolderCategory.inspections => AppColors.sand,
        FolderCategory.legal => const Color(0xFFFFEFB8),
        FolderCategory.financial => AppColors.pink,
      };

  Color get folderFg => switch (this) {
        FolderCategory.architecture => AppColors.teal,
        FolderCategory.inspections => AppColors.olive,
        FolderCategory.legal => const Color(0xFF8A6A00),
        FolderCategory.financial => AppColors.brick,
      };
}
