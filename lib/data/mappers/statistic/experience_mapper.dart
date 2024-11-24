import 'package:neuro_pairs/domain/entities/statistic/experience.dart';

final class ExperienceMapper {
  Map<String, dynamic> toJson(Experience data) {
    return {
      _Fields.currentLevel: data.currentLevel,
      _Fields.currentExperience: data.currentExperience,
      _Fields.nextLevelExperience: data.nextLevelExperience,
      _Fields.startCurrentLevelExperience: data.startCurrentLevelExperience,
    };
  }

  Experience fromJson(Map<String, dynamic> json) {
    return Experience(
      currentLevel: json[_Fields.currentLevel],
      currentExperience: json[_Fields.currentExperience],
      nextLevelExperience: json[_Fields.nextLevelExperience],
      startCurrentLevelExperience: json[_Fields.startCurrentLevelExperience],
    );
  }
}

abstract final class _Fields {
  static const currentLevel = 'currentLevel';
  static const currentExperience = 'currentExperience';
  static const nextLevelExperience = 'nextLevelExperience';
  static const startCurrentLevelExperience = 'startCurrentLevelExperience';
}
