class Organization {
  final String id;
  final String name;
  final String type;
  final String industry;
  final String location;
  final String logoUrl;
  final double rating;
  final int experienceCount;

  const Organization({
    required this.id,
    required this.name,
    required this.type,
    required this.industry,
    required this.location,
    required this.logoUrl,
    required this.rating,
    required this.experienceCount,
  });
}