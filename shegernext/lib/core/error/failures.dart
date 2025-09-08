import 'package:equatable/equatable.dart';

// super class of all the failures
class Failures extends Equatable {
  final String message;

  const Failures({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failures {
  const ServerFailure({required super.message});
}

class CacheFailure extends Failures {
  const CacheFailure({required super.message});
}