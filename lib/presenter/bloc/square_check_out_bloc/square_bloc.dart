import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:square_tickets/data/remote/events/models/tickets_model.dart';
import 'package:square_tickets/data/remote/square_checkout/model/checkout_payload.dart';
import 'package:square_tickets/data/remote/square_checkout/model/checkout_response.dart';
import 'package:square_tickets/data/remote/square_checkout/repository/square_checkout_rpository.dart';
import 'package:square_tickets/helpers/http_helper.dart';

import '../../../data/remote/models/state.dart';

part 'square_event.dart';

part 'square_state.dart';

class SquareBloc extends Bloc<SquareEvent, SquareState> {
  final SquareCheckoutRepository squareCheckoutRepository ;

  SquareBloc(this.squareCheckoutRepository) : super(SquareInitial()) {
    on<SquareEvent>((event, emit) {});
    on<CreatePaymentLinkEvent>(_mapCreatePaymentLinkToState);
  }

 FutureOr<void> _mapCreatePaymentLinkToState(
      CreatePaymentLinkEvent event, Emitter<SquareState> emit) async {
    emit(CheckoutLoadingStae());
    try {

      State? state = await squareCheckoutRepository.checkout(event.checkoutPayload,event.ticketModel);
      // log(event.checkoutPayload.toJson().toString());
      if (state is SuccessState) {
        emit(CheckoutSuccessState(state.value));
      } else if (state is ErrorState) {
        log(state.value.toString());
        emit(CheckoutFailureState(state.value));
      }
    } on Exception catch (e) {
      emit(CheckoutFailureState(e.toString()));
    }
  }
}
