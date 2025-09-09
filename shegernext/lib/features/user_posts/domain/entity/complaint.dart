class Complaint {
  final String? id;
  final String? clerkUserId;
  final String text;
  final String? category;
  final double? latitude;
  final double? longitude;
  final String? imageUrl;
  final String? priority;
  final String? status;
  final DateTime? createdAt;

  const Complaint({
    this.id,
    required this.text,
    this.clerkUserId,
    this.category,
    this.latitude,
    this.longitude,
    this.imageUrl,
    this.priority,
    this.status,
    this.createdAt,
  });
}