import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shegernext/features/complaints/domain/entity/complaint.dart';
import 'package:shegernext/features/complaints/domain/usecases/submit_complaint.dart';

part 'complaints_event.dart';
part 'complaints_state.dart';

class ComplaintsBloc extends Bloc<ComplaintsEvent, ComplaintsState> {
  ComplaintsBloc({required SubmitComplaint submitComplaint})
    : _submitComplaint = submitComplaint,
      super(ComplaintsInitial()) {
    on<SubmitComplaintEvent>(_onSubmitComplaint);
  }

  final SubmitComplaint _submitComplaint;

  Future<void> _onSubmitComplaint(
    SubmitComplaintEvent event,
    Emitter<ComplaintsState> emit,
  ) async {
    emit(ComplaintSubmitting());

    final Complaint complaint = Complaint(
      text: event.text,
      category: event.category,
      latitude: event.latitude,
      longitude: event.longitude,
      imageUrl: event.imageUrl,
      status: 'submitted',
    );

    final result = await _submitComplaint(complaint);
    result.fold(
      (l) => emit(ComplaintSubmitError(l.message)),
      (r) => emit(ComplaintSubmitted()),
    );
  }
}
