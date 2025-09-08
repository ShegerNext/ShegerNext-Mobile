part of 'complaints_bloc.dart';

sealed class ComplaintsState extends Equatable {
  const ComplaintsState();

  @override
  List<Object> get props => [];
}

final class ComplaintsInitial extends ComplaintsState {}

class ComplaintSubmitting extends ComplaintsState {}

class ComplaintSubmitted extends ComplaintsState {}

class ComplaintSubmitError extends ComplaintsState {
  ComplaintSubmitError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
