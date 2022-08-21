import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../data/remote/events/models/event_model.dart';
import '../../../theme/app_colors.dart';
import '../views/event_detail_screen.dart';

class EventItem extends StatelessWidget {
  const EventItem({Key? key, required this.eventModel}) : super(key: key);
  final EventModel eventModel;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>  EventDetailScreen(eventModel: eventModel,),
        ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 150,
              height: 150,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                // height: ,
                decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        topLeft: Radius.circular(16)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            eventModel.posterUrl.isEmpty
                                ? 'https://storage.googleapis.com/io-19-assets/images/recap/carousels/extended/carousel-4_1x.jpg'
                                : eventModel.posterUrl[0]))),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
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
                     DateFormat(DateFormat.MONTH_DAY).format(eventModel.eventDate),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(16),
                          topRight: Radius.circular(16)),
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        eventModel.eventTheme,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 30,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Music',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          style: TextButton.styleFrom(
                              shape: const StadiumBorder(),
                              side: const BorderSide(color: AppColors.smokeWhite)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          ImageStack(
                            imageList: const [
                              'https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg',
                              'https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg',
                              'https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg'
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
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children:  [
                          const Icon(
                            LineIcons.alternateMapMarker,
                            color: Colors.blue,
                          ),
                          Expanded(
                              child: Text(
                                eventModel.location,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ))
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
