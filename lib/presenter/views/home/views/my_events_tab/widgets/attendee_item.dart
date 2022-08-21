import 'package:flutter/material.dart';
import 'package:square_tickets/data/remote/models/user_model.dart';
import 'package:square_tickets/presenter/theme/app_colors.dart';

class AttendeeItem extends StatefulWidget {
  const AttendeeItem({Key? key, required this.attendee}) : super(key: key);
  final UserModel attendee;

  @override
  State<AttendeeItem> createState() => _AttendeeItemState();
}

class _AttendeeItemState extends State<AttendeeItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.lightBlue,
            child: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                widget.attendee.profilePath == null
                    ? 'https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/avat-01-512.png'
                    : widget.attendee.profilePath.toString(),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.attendee.name,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      widget.attendee.email,
                      style:
                          const TextStyle(fontSize: 13, color: AppColors.textColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.copy,
                      size: 15,
                      color: AppColors.textColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '1 tickets',
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
    );
  }
}
