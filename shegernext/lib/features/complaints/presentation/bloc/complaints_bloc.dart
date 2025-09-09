import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shegernext/features/complaints/domain/entity/complaint.dart';
import 'package:shegernext/features/complaints/domain/usecases/submit_complaint.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'complaints_event.dart';
part 'complaints_state.dart';


// ...existing code...

class ComplaintsBloc extends Bloc<ComplaintsEvent, ComplaintsState> {
  ComplaintsBloc({
    required SubmitComplaint submitComplaint,
    required FlutterSecureStorage storage,
  })  : _submitComplaint = submitComplaint,
        _storage = storage,
        super(ComplaintsInitial()) {
    on<SubmitComplaintEvent>(_onSubmitComplaint);
  }

  final SubmitComplaint _submitComplaint;
  final FlutterSecureStorage _storage;

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

    final String? token = await _storage.read(key: 'access_token');
    if (token == null || token.isEmpty) {
      emit(ComplaintSubmitError('No access token found'));
      return;
    }

    final result = await _submitComplaint(complaint, token);
    result.fold(
      (l) => emit(ComplaintSubmitError(l.message)),
      (r) => emit(ComplaintSubmitted()),
    );
  }
}
