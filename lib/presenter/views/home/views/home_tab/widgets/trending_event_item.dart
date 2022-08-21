import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:square_tickets/data/remote/events/models/event_model.dart';

import '../../event_detail_screen.dart';

class TrendingEventItem extends StatelessWidget {
  const TrendingEventItem({Key? key, required this.eventModel})
      : super(key: key);
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
        width: 195,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 180,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ],
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(eventModel.posterUrl.isEmpty
                          ? 'https://storage.googleapis.com/io-19-assets/images/recap/carousels/extended/carousel-4_1x.jpg'
                          : eventModel.posterUrl[0]),
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
                          children: [
                            Text(
                              eventModel.eventDate.day.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo),
                            ),
                            Text(
                              DateFormat(DateFormat.ABBR_MONTH)
                                  .format(eventModel.eventDate)
                                  .toUpperCase(),
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
            const SizedBox(
              height: 10,
            ),
            Text(
              eventModel.eventTheme,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimary),
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
                      color: Colors.indigo,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  LineIcons.mapMarker,
                  color: Colors.grey.shade400,
                ),
                Expanded(
                    child: Text(
                  eventModel.location,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
