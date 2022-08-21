import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:square_tickets/data/remote/events/models/event_model.dart';
import 'package:square_tickets/presenter/views/home/views/my_events_tab/widgets/attendee_item.dart';

import '../../../../../theme/app_colors.dart';
import '../../../../../widgets/filled_textfield.dart';
class AttendeeTab extends StatefulWidget {
  const AttendeeTab({Key? key,  required this.eventModel}) : super(key: key);
  final EventModel eventModel;

  @override
  State<AttendeeTab> createState() => _AttendeeTabState();
}

class _AttendeeTabState extends State<AttendeeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10,),
          FilledTextField(
            hint: 'Search for attendee',
            preffix: const Icon(
              LineIcons.searchengin,
              color: AppColors.textColor,
              size: 20,
            ),
            suffix: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.tune,
                  color: Theme.of(context).colorScheme.primary,
                )),

          ),
        widget.eventModel.attending.isNotEmpty?
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: widget.eventModel.attending.length,
            shrinkWrap: true,
            itemBuilder: (context, index) =>  AttendeeItem(attendee: widget.eventModel.attending[index],),),
        ):
          Expanded(child: Center(child: Text('Their are no attendees for this event ',style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),)),
      ],),
    );
  }
}
