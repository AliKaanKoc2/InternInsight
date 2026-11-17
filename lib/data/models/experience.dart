class Experience {
  final String id;
  final String authorId;
  final String company;
  final String position;
  final String department;
  final String location;
  final String workType;
  final String duration;

  final double rating;
  final bool isVerified;
  final bool recommends;
  final DateTime createdAt;

  final String review;
  final List<String> pros;
  final List<String> cons;

  final String applicationChannel;
  final int interviewRounds;
  final String interviewDifficulty;
  final String interviewDescription;

  final List<String> technologies;

  const Experience({
    required this.id,
    required this.authorId,
    required this.company,
    required this.position,
    required this.department,
    required this.location,
    required this.workType,
    required this.duration,
    required this.rating,
    required this.isVerified,
    required this.recommends,
    required this.createdAt,
    required this.review,
    required this.pros,
    required this.cons,
    required this.applicationChannel,
    required this.interviewRounds,
    required this.interviewDifficulty,
    required this.interviewDescription,
    required this.technologies,
  });
}