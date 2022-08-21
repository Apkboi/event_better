part of 'square_bloc.dart';

abstract class SquareEvent extends Equatable {
  const SquareEvent();
}
class CreatePaymentLinkEvent extends SquareEvent{
 final CheckoutPayload checkoutPayload ;
 final TicketModel ticketModel;

  CreatePaymentLinkEvent(this.checkoutPayload, this.ticketModel);

  @override
  List<Object?> get props => [checkoutPayload,ticketModel];

}
