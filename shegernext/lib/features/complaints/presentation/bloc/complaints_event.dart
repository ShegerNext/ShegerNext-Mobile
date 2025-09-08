part of 'complaints_bloc.dart';

sealed class ComplaintsEvent extends Equatable {
  const ComplaintsEvent();

  @override
  List<Object> get props => [];
}

class SubmitComplaintEvent extends ComplaintsEvent {
  const SubmitComplaintEvent({
    required this.text,
    this.category,
    this.latitude,
    this.longitude,
    this.imageUrl,
  });

  final String text;
  final String? category;
  final double? latitude;
  final double? longitude;
  final String? imageUrl;
}
