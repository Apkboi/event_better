import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:square_tickets/data/remote/events/models/event_model.dart';
import 'package:square_tickets/presenter/views/home/views/my_events_tab/views/my_event_details_page.dart';
class MyEventsItem extends StatefulWidget {
  const MyEventsItem({Key? key, required this.eventModel}) : super(key: key);
  final EventModel eventModel;

  @override
  State<MyEventsItem> createState() => _MyEventsItemState();
}

class _MyEventsItemState extends State<MyEventsItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  MyEventDetailsPage(eventModel: widget.eventModel,),));
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration:  BoxDecoration(color: Theme
            .of(context)
            .cardColor,),

        child: Row(children:  [
        SizedBox(
          width: 100,
          height: 80,
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            // height: ,
            decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(
                   5),
                image:  DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        widget.eventModel.posterUrl.isEmpty
                            ? 'https://storage.googleapis.com/io-19-assets/images/recap/carousels/extended/carousel-4_1x.jpg'
                            : widget.eventModel.posterUrl[0]))),
          ),
        ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,

              children: [
                Text(
                  widget.eventModel.eventTheme,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16, color: Theme
                      .of(context)
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
                      totalCount: 3,
                      // If larger than images.length, will show extra empty circle
                      imageRadius: 22,

                      // Radius of each images
                      imageCount: 3,
                      // Maximum number of images to be shown in stack
                      imageBorderWidth: 0.5, // Border width around the images
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Attending',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.indigo,
                          fontWeight: FontWeight.w500),
                    )
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
                    const SizedBox(width: 5,),
                    Expanded
                      (
                      child: Text(
                       widget.eventModel.location,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(color: Colors.grey.shade400,
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
            child:  Text(
              DateFormat(DateFormat.MONTH_DAY).format(widget.eventModel.eventDate),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          )
      ],),),
    );
  }
}
