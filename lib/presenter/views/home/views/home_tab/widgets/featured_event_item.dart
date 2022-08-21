import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:square_tickets/presenter/views/home/views/event_detail_screen.dart';

import '../../../../../../data/remote/events/models/event_model.dart';

class FeaturedEventItem extends StatelessWidget {
  const FeaturedEventItem({Key? key, required this.eventModel})
      : super(key: key);
  final EventModel eventModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          image:  DecorationImage(
              image: NetworkImage(
                  eventModel.posterUrl.isEmpty
                      ? 'https://storage.googleapis.com/io-19-assets/images/recap/carousels/extended/carousel-4_1x.jpg'
                      : eventModel.posterUrl[0]),
              fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
                // begin: ,
                colors: [Colors.black54, Colors.black12, Colors.transparent])),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  height: 30,
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          '4.5',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          LineIcons.starAlt,
                          size: 18,
                          color: Colors.amber,
                        )
                      ],
                    ),
                    style: TextButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.black38,
                        padding: EdgeInsets.zero),
                  ),
                ),
              ),
               Spacer(),
               Text(
                eventModel.eventTheme,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  EventDetailScreen(eventModel: eventModel,),
                  ));
                },
                child: Text(
                  'Book now',
                  style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
