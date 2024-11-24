extension ListExtension<T> on List<T> {
  List<T> insertBetween(T separator) {
    if (length <= 1) return List.of(this);

    return <T>[
      ...map((item) => [item, separator]).expand((pair) => pair).toList()
        ..removeLast(),
    ];
  }
}
