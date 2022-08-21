import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:square_tickets/data/remote/square_checkout/model/checkout_payload.dart';
import 'package:square_tickets/helpers/http_helper.dart';
import '../../../../helpers/api_helper.dart';
import '../../../../helpers/endpoints.dart';
import '../../events/models/tickets_model.dart';
import '../../models/api_response.dart';
import '../../models/server_error_model.dart';
import '../../models/state.dart';
import '../model/checkout_response.dart';

class SquareCheckoutRepository {
  HttpHelper httpHelper;
  FirebaseFirestore db = FirebaseFirestore.instance;

  SquareCheckoutRepository(this.httpHelper);

  Future<State>? checkout(
      CheckoutPayload payload, TicketModel ticketModel) async {
    try {

      State squareChechoutState = await SimplifyApiConsuming.makeRequest(
        () => httpHelper.post(Endpoints.createPaymentLinkEndpoint,
            body: payload.toJson()),
        successResponse: (data) {
          return State<CheckoutResponse?>.success(
              data != null ? CheckoutResponse.fromJson(data) : null);
        },
        statusCodeSuccess: 200,
        errorResponse: (response) {
          debugPrint('ERROR SERVER');
          return State<ServerErrorModel>.error(
            ServerErrorModel(
                statusCode: response.statusCode!,
                errorMessage: response.data.toString(),
                data: null),
          );
        },
        dioErrorResponse: (response) {
          debugPrint('DIO SERVER');
          return State<ServerErrorModel>.error(
            ServerErrorModel(
                statusCode: response.statusCode!,
                errorMessage: response.data['message'],
                data: null),
          );
        },
      );

      if (squareChechoutState is SuccessState) {
        ApiResponse response = await bookTicket(
            ticket: ticketModel.copyWith(
                paymentLink:
                    squareChechoutState.value
                        .checkout
                        .checkoutPageUrl));
        if (response.error == null) {

          return State.success({
                'checkoutResponse':squareChechoutState.value,
                'ticketResponse': response.data

              });


        } else {
          return State.error('Sorry An error occurred retry');
        }

      } else if (squareChechoutState is ErrorState) {
        return State.error(squareChechoutState.value);
      } else {
        return State.error('Sorry An error occurred retry');
      }
    } on Exception catch (e) {
      return State.error(e);

    }
  }

  Future<ApiResponse> bookTicket({required TicketModel ticket}) async {
    try {
      DocumentReference eventRef = db.collection('tickets').doc();

      eventRef.set(ticket
          .copyWith(
            id: eventRef.id,
          )
          .toJson());
      return ApiResponse(data: ticket.copyWith(
        id: eventRef.id,
      ), error: null);
    } on Exception catch (e) {
      return ApiResponse(data: e, error: e.toString());
    }
  }
}
