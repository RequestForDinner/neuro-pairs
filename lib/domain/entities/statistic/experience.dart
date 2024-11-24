import 'package:neuro_pairs/domain/utils/experience_levels.dart';

final class Experience {
  final int currentLevel;
  final int currentExperience;
  final int nextLevelExperience;
  final int startCurrentLevelExperience;

  const Experience({
    required this.currentLevel,
    required this.currentExperience,
    required this.nextLevelExperience,
    required this.startCurrentLevelExperience,
  });

  factory Experience.begin() => Experience(
        currentLevel: 0,
        currentExperience: 0,
        nextLevelExperience: ExperienceLevels.availableLevels[1]!,
        startCurrentLevelExperience: 0,
      );

  Experience copyWith({
    int? currentLevel,
    int? currentExperience,
    int? nextLevelExperience,
    int? startCurrentLevelExperience,
  }) {
    return Experience(
      currentLevel: currentLevel ?? this.currentLevel,
      currentExperience: currentExperience ?? this.currentExperience,
      nextLevelExperience: nextLevelExperience ?? this.nextLevelExperience,
      startCurrentLevelExperience:
          startCurrentLevelExperience ?? this.startCurrentLevelExperience,
    );
  }
}
