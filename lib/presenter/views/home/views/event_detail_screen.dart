import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_stack/image_stack.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:square_tickets/data/remote/events/models/tickets_model.dart';
import 'package:square_tickets/data/remote/square_checkout/model/checkout_payload.dart';
import 'package:square_tickets/di/injector.dart';
import 'package:square_tickets/helpers/app_utils.dart';
import 'package:square_tickets/helpers/constants.dart';
import 'package:square_tickets/presenter/bloc/square_check_out_bloc/square_bloc.dart';
import 'package:square_tickets/presenter/views/home/views/checkout_screen.dart';
import 'package:square_tickets/presenter/views/home/widgets/checkout_webview.dart';
import 'package:square_tickets/presenter/widgets/custom_button.dart';
import 'package:square_tickets/presenter/widgets/outlined_form_field.dart';

import '../../../../data/remote/events/models/event_model.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_bar_button.dart';
import '../widgets/payments_option_card.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({Key? key, required this.eventModel})
      : super(key: key);
  final EventModel eventModel;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final SquareBloc _squareBloc = SquareBloc(injector.get());

  final TextEditingController ticketSizeController = TextEditingController();

  // bool payNow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              // padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              height: 250,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  image: DecorationImage(
                      image: NetworkImage(
                        widget.eventModel.posterUrl.isEmpty
                            ? 'https://storage.googleapis.com/io-19-assets/images/recap/carousels/extended/carousel-4_1x.jpg'
                            : widget.eventModel.posterUrl[0],
                      ),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 40),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Colors.black54,
                          Colors.black54,
                          Colors.black38,
                          Colors.transparent
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Row(
                      children:  [
                        AppBarButton(icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 18,),onTap:(){
                          Navigator.pop(context);
                        } ),
                        const Expanded(
                            child: Center(
                                child: Text(
                          'Event Details',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ))),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.eventModel.eventTheme,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          width: 80,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              '\$${widget.eventModel.ticketPrice}',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //INVITE FEATURE COMING SOON
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       ImageStack(
                  //         imageList: const [
                  //           'https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg',
                  //           'https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg',
                  //           'https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg'
                  //         ],
                  //         totalCount: 3,
                  //         // If larger than images.length, will show extra empty circle
                  //         imageRadius: 27,
                  //
                  //         // Radius of each images
                  //         imageCount: 3,
                  //         // Maximum number of images to be shown in stack
                  //         imageBorderWidth:
                  //             0.5, // Border width around the images
                  //       ),
                  //       const SizedBox(
                  //         width: 5,
                  //       ),
                  //       Text(
                  //         ' +55 Attending',
                  //         style: TextStyle(
                  //             fontSize: 13,
                  //             color: Theme.of(context).colorScheme.primary,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //       const Spacer(),
                  //       SizedBox(
                  //         height: 30,
                  //         child: TextButton(
                  //           onPressed: () {},
                  //           child: const Text(
                  //             'Invite',
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //           style: TextButton.styleFrom(
                  //               padding:
                  //                   const EdgeInsets.symmetric(horizontal: 16),
                  //               backgroundColor:
                  //                   Theme.of(context).colorScheme.primary),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                  child: Icon(
                                    LineIcons.calendarAlt,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                AppUtils.formatDateTime(
                                    widget.eventModel.eventDate),
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                DateFormat(DateFormat.HOUR24_MINUTE_SECOND)
                                    .format(widget.eventModel.eventDate),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 1,
                          color: Colors.grey.shade400,
                          height: 80,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                  child: Icon(
                                    LineIcons.alternateMapMarker,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Location ',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                widget.eventModel.location,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://www.worldatlas.com/r/w960-q80/upload/d7/af/9b/european-countries-map.png'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'About Event',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.eventModel.aboutEvent,
                    style: const TextStyle(
                        color: AppColors.textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  Text(
                    'Number of tickets',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                   OutlinedFormField(hint: '1',inputType: TextInputType.number,controller: ticketSizeController,),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      child:   const Text(
                    'Book ticket',
                    style: TextStyle(color: Colors.white),
                  ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (ctx) => PaymentOptionModal(
                                  eventModel: widget.eventModel, 
                              ticketSize: ticketSizeController.text,

                                ));

                        // _squareBloc.add(CreatePaymentLinkEvent(CheckoutPayload(
                        //     idempotencyKey: DateTime.now().toString(),
                        //     merchantSupportEmail: '',
                        //     askForShippingAddress: false,
                        //     order: CheckoutPayloadOrder(
                        //         idempotencyKey: DateTime.now().toString(),
                        //         order: OrderOrder(
                        //             locationId: Constants.locationId,
                        //             ticketName: '',
                        //             lineItems: [
                        //               LineItem(
                        //                   basePriceMoney: BasePriceMoney(
                        //                       amount: 55, currency: 'USD'),
                        //                   name: 'Ticket',
                        //                   quantity: '2')
                        //             ])),
                        //     redirectUrl: 'https://facebook.com')));
                      }),

                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PaymentOptionModal extends StatefulWidget {
  const PaymentOptionModal(
      {Key? key, required this.eventModel, required this.ticketSize,})
      : super(key: key);
  final EventModel eventModel;
  final String ticketSize;


  @override
  State<PaymentOptionModal> createState() => _PaymentOptionModalState();
}

class _PaymentOptionModalState extends State<PaymentOptionModal> {
  bool payNow = true;
  final SquareBloc squareBloc = SquareBloc(injector.get());


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  payNow = true;
                });
              },
              child: PaymentOptionCard(
                title: 'Pay Now',
                description:
                    'Complete payment process by providing your card details to checkout',
                selected: payNow,
              )),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  payNow = false;
                });
              },
              child: PaymentOptionCard(
                title: 'Pay Later',
                description:
                    'Generate payment link you can share to people to help you pay or pay later',
                selected: payNow == false,
              )),
          const SizedBox(
            height: 16,
          ),
          CustomButton(
              child: BlocConsumer<SquareBloc, SquareState>(

                bloc: squareBloc,
                listener: (context, state) {
                  if (state is CheckoutSuccessState) {
                    if (!payNow) {
                      // Navigator.pop(context);
                      AppUtils.showContentDialog(context,
                          paymentLink: state
                              .response['checkoutResponse']
                              .checkout
                              .checkoutPageUrl, onclose: () {
                        Navigator.pop(context);
                        // Navigator.pop(context);
                      });
                    } else {
                      // AppUtils.showSuccessSuccessDialog(context,
                      //     title: 'Ticket Booked',
                      //     message:'Congratulations!!! you have succesfully purchased this ticket');
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebViewExample(
                            url: state.response['checkoutResponse']
                                .checkout.checkoutPageUrl,
                            onSuccess: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              AppUtils.showSuccessSuccessDialog(context,message: 'Congrats you successfully purchased a ticket for this event');
                            },
                            ticket: state.response['ticketResponse']),
                      ));
                    }
                  }
                },

                builder: (context, state) {
                  if (state is CheckoutLoadingStae) {
                    return const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                 else if (state is CheckoutFailureState) { return const Text(
                    'CONTINUE',
                    style: TextStyle(color: Colors.white),
                  );}
                else  if (state is CheckoutSuccessState) { return const Text(
                    'CONTINUE',
                    style: TextStyle(color: Colors.white),
                  );}
                  return const Text(
                    'CONTINUE',
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
              onPressed: () {
                squareBloc.add(CreatePaymentLinkEvent(
                    CheckoutPayload(
                        idempotencyKey: DateTime.now().toString(),
                        merchantSupportEmail:
                            injector.get<AuthBloc>().userModel!.email,
                        askForShippingAddress: false,
                        order: CheckoutPayloadOrder(
                            idempotencyKey: DateTime.now().toString(),
                            order: OrderOrder(
                                locationId: Constants.locationId,
                                ticketName: 'Event Ticket ',
                                lineItems: [
                                  LineItem(
                                      basePriceMoney: BasePriceMoney(
                                          amount: 55, currency: 'USD'),
                                      name: widget.eventModel.eventTheme,
                                      quantity: '2')
                                ])),
                        redirectUrl: 'https://facebook.com'),
                    TicketModel(
                        id: '',
                        userId: injector.get<AuthBloc>().uid,
                        size: widget.ticketSize.isEmpty ?1:int.parse(widget.ticketSize),
                        event: widget.eventModel,
                        created: DateTime.now(),
                        paymentLink: '',
                        status: 'not paid',
                        totalPrice: 2 * widget.eventModel.ticketPrice)));
              }),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
