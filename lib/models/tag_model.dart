class Tag {
  final String tag;
  final double confidence;

  Tag({required this.tag, required this.confidence});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      tag: json['tag']['en'],
      confidence: (json['confidence'] as num).toDouble(),
    );
  }
}
