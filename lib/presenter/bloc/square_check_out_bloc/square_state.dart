part of 'square_bloc.dart';

abstract class SquareState extends Equatable {
  const SquareState();
}

class SquareInitial extends SquareState {
  @override
  List<Object> get props => [];
}
class CheckoutLoadingStae extends SquareState {
  @override
  List<Object?> get props => [];
}

class CheckoutSuccessState extends SquareState {

  final Map<String, dynamic> response;
  // final CheckoutResponse checkoutResponse;

  CheckoutSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}
class CheckoutFailureState extends SquareState{
  String error;

  CheckoutFailureState(this.error);

  @override
  List<Object?> get props => [];
}
