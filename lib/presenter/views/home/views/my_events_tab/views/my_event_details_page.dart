import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_stack/image_stack.dart';
import 'package:intl/intl.dart';
import 'package:square_tickets/di/injector.dart';
import 'package:square_tickets/presenter/bloc/events_bloc/events_bloc.dart';
import 'package:square_tickets/presenter/bloc/events_bloc/events_bloc.dart';
import 'package:square_tickets/presenter/views/home/views/my_events_tab/views/about_event_tab.dart';
import 'package:square_tickets/presenter/views/home/views/my_events_tab/views/attendee_tab.dart';
import 'package:square_tickets/presenter/views/home/views/my_events_tab/widgets/attendee_item.dart';

import '../../../../../../data/remote/events/models/event_model.dart';
import '../../../../../../helpers/app_utils.dart';

class MyEventDetailsPage extends StatefulWidget {
  const MyEventDetailsPage({Key? key, required this.eventModel})
      : super(key: key);
  final EventModel eventModel;

  @override
  State<MyEventDetailsPage> createState() => _MyEventDetailsPageState();
}

class _MyEventDetailsPageState extends State<MyEventDetailsPage> {
  final EventsBloc _eventsBloc = EventsBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventsBloc, EventsState>(
      bloc: _eventsBloc,
      listener: (context, state) {
        if(state is ScanTicketSuccesState){
          AppUtils.showSuccessSuccessDialog(context,title: 'Ticket is Valid');
        }
        if(state is ScanTicketLoadingState){
          // Navigator.pop(context);
          AppUtils.showAnimatedProgressDialog(context,title: 'Please wait');
        }
        if(state is ScanTicketFailureState){
          // Navigator.pop(context);
          CustomSnackBar.show(context, message: state.error);
          // AppUtils.showAnimatedProgressDialog(context,title: state.error);
        }
      },
      child: Scaffold(
        floatingActionButton: Card(
          shadowColor: Colors.blueGrey.shade200,
          color: Theme.of(context).colorScheme.primary,
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: const BorderSide(width: 2, color: Colors.white)),
          child: InkWell(
            onTap: () {
              FlutterBarcodeScanner.scanBarcode(
                      "#ff6666", "Cancel", false, ScanMode.BARCODE).then((value) {
                        log(value.toString());
                _eventsBloc.add(ScanTicketsEvent(ticket_id:value , eventModel: widget.eventModel));

              } );
              
              
              //     ?.listen((barcode) {
              //   CustomSnackBar.show(context, message: barcode);
              //   log(barcode.toString());
              //
              //   /// barcode to be used
              // });
            },
            borderRadius: BorderRadius.circular(10.0),
            child: const SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget
                                  .eventModel.posterUrl.isEmpty
                              ? 'https://storage.googleapis.com/io-19-assets/images/recap/carousels/extended/carousel-4_1x.jpg'
                              : widget.eventModel.posterUrl[0]))),
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                          Colors.black,
                          Colors.black45,
                          Colors.black12,
                          Colors.transparent
                        ])),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.eventModel.eventTheme,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    ImageStack(
                                      imageList: const [
                                        'https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/avat-01-512.png',
                                        'https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg',
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOApFCSVByzhZorHUAP-J851JAYyOPtI1jdg&usqp=CAU'
                                      ],
                                      totalCount: 6,
                                      // If larger than images.length, will show extra empty circle
                                      imageRadius: 22,

                                      // Radius of each images
                                      imageCount: 3,
                                      // Maximum number of images to be shown in stack
                                      imageBorderWidth:
                                          0.5, // Border width around the images
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_searching,
                                      color: Colors.grey.shade400,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.eventModel.location,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.grey.shade400,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.pinkAccent,
                                    Colors.purpleAccent,
                                    Colors.purple,
                                  ],
                                )),
                            child: Text(
                              DateFormat(DateFormat.MONTH_DAY)
                                  .format(widget.eventModel.eventDate),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  child: TabBar(
                    // indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.zero,
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    // indicator: BoxDecoration(color: Theme.of(context).colorScheme.primary) ,

                    tabs: const [
                      Tab(
                        text: 'About Event',
                      ),
                      Tab(
                        text: 'Attending',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        AboutEventTab(
                          eventModel: widget.eventModel,
                        ),
                        AttendeeTab(
                          eventModel: widget.eventModel,
                        )
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
