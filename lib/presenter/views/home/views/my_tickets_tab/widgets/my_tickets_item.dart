import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:square_tickets/data/remote/events/models/tickets_model.dart';
import 'package:square_tickets/presenter/theme/app_colors.dart';
import 'package:square_tickets/presenter/views/home/views/my_tickets_tab/views/ticket_details_page.dart';

class MyTicketsItem extends StatefulWidget {
  final int index;
  final TicketModel ticketModel;

  const MyTicketsItem(
      {Key? key, required this.index, required this.ticketModel})
      : super(key: key);

  @override
  State<MyTicketsItem> createState() => _MyTicketsItemState();
}

class _MyTicketsItemState extends State<MyTicketsItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'eventImage${widget.index}',
              transitionOnUserGestures: true,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    maintainState: true,
                    builder: (context) => TicketDetailsPage(
                      pageIndex: widget.index, ticketModel: widget.ticketModel,
                    ),
                  ));
                },
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 6,
                            offset: Offset(0, 2))
                      ],
                      borderRadius: BorderRadius.circular(16),
                      image:  DecorationImage(
                          image: NetworkImage(
                            widget.ticketModel.event.posterUrl.isEmpty?
                              'https://storage.googleapis.com/io-19-assets/images/recap/carousels/extended/carousel-4_1x.jpg'
                          : widget.ticketModel.event.posterUrl[0]
                          ),
                          fit: BoxFit.cover)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 45,
                        child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                )),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children:  [
                                Text(
                                  widget.ticketModel.event.eventDate.day.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                ),
                                Text(
                                 DateFormat(DateFormat.ABBR_MONTH.toUpperCase()).format(widget.ticketModel.event.eventDate),
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                )
                              ],
                            )),
                      ),
                      Spacer(),
                      // SizedBox(
                      //   width: 40,
                      //   child: TextButton(
                      //
                      //       onPressed: (){},
                      //       style: TextButton.styleFrom(
                      //
                      //       backgroundColor: Colors.white.withOpacity(0.8),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(8),)),
                      //       child: const Icon(Icons.bookmark,color: Colors.indigo,size: 16,)),
                      // )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                       widget.ticketModel.event.eventTheme,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: AppColors.amber,
                          ),
                          Icon(
                            Icons.star,
                            size: 14,
                            color: AppColors.amber,
                          ),
                          Icon(
                            Icons.star,
                            size: 14,
                            color: AppColors.amber,
                          ),
                          Icon(
                            Icons.star,
                            size: 14,
                            color: AppColors.amber,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                       Text(
                        widget.ticketModel.event.location,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TicketDetailsPage(
                          pageIndex: widget.index, ticketModel: widget.ticketModel,
                        ),
                      ));
                    },
                    child: Text(
                      'Ticket Details',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
