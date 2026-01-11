class Mission {
  final int id;
  final String title;
  final String description;
  final int rewardPoints;
  final List<String> validTags;
  bool isCompleted;

  Mission({
    required this.id,
    required this.title,
    required this.description,
    required this.rewardPoints,
    required this.validTags,
    this.isCompleted = false,
  });

  Object? get requiredTag => null;
}
