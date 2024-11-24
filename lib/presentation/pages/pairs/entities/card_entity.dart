final class CardEntity {
  final String uid;
  final String imagePath;
  final bool wasFlipped;
  final bool canFlip;

  const CardEntity({
    required this.uid,
    required this.imagePath,
    required this.wasFlipped,
    required this.canFlip,
  });

  CardEntity copyWith({
    bool? wasFlipped,
    bool? canFlip,
  }) {
    return CardEntity(
      uid: uid,
      imagePath: imagePath,
      wasFlipped: wasFlipped ?? this.wasFlipped,
      canFlip: canFlip ?? this.canFlip,
    );
  }
}
