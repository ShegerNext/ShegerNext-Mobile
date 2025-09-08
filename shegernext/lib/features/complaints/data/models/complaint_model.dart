import 'package:shegernext/features/complaints/domain/entity/complaint.dart';

class ComplaintModel extends Complaint {
  const ComplaintModel({
    super.id,
    required super.text,
    super.clerkUserId,
    super.category,
    super.latitude,
    super.longitude,
    super.imageUrl,
    super.priority,
    super.status,
    super.createdAt,
  });

  Map<String, dynamic> toRequestJson() {
    return <String, dynamic>{
      'clerk_user_id': clerkUserId,
      'text': text,
      'category': category,
      if (latitude != null && longitude != null)
        'location': <String, dynamic>{
          'latitude': latitude,
          'longitude': longitude,
        },
      'image_url': imageUrl,
      if (status != null) 'status': status,
    };
  }

  factory ComplaintModel.fromResponseJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? location =
        json['location'] as Map<String, dynamic>?;
    return ComplaintModel(
      id: json['id'] as String?,
      clerkUserId: json['clerk_user_id'] as String?,
      text: json['text'] as String? ?? '',
      category: json['category'] as String?,
      latitude: (location?['latitude'] as num?)?.toDouble(),
      longitude: (location?['longitude'] as num?)?.toDouble(),
      imageUrl: json['image_url'] as String?,
      priority: json['priority'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
    );
  }
}
