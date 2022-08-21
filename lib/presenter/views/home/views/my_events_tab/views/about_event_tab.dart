import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:square_tickets/data/remote/events/models/event_model.dart';
import 'package:square_tickets/helpers/app_utils.dart';

import '../../../../../bloc/square_check_out_bloc/square_bloc.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../widgets/custom_button.dart';
import '../../checkout_screen.dart';
class AboutEventTab extends StatefulWidget {
  const AboutEventTab({Key? key, required this.eventModel}) : super(key: key);
 final  EventModel eventModel ;

  @override
  State<AboutEventTab> createState() => _AboutEventTabState();
}

class _AboutEventTabState extends State<AboutEventTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,

        children: [
        Flexible(
          fit: FlexFit.loose,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            AppUtils.formatDateTime(widget.eventModel.eventDate),
                            style: TextStyle(
                                color:
                                Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                           Text(
                          DateFormat(DateFormat.HOUR_MINUTE_SECOND).format(widget.eventModel.eventDate),
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
                            'Location',
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
            ],),
          ),
        ),

        const SizedBox(height: 20,),
        // CustomButton(child: const Text('Edit Event Details'), onPressed: (){}),
          const SizedBox(height: 20,),

        ],
    ),);
  }
}
