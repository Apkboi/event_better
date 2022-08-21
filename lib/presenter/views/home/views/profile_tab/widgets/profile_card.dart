import 'package:flutter/material.dart';
import 'package:square_tickets/data/remote/models/user_model.dart';
import 'package:square_tickets/presenter/theme/app_colors.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          // margin: const EdgeInsets.symmetric(horizontal: 25),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              // boxShadow:  const [
              //   BoxShadow(
              //       color: AppColors.lightGrey, offset: Offset(0, 2),blurRadius: 6 )
              // ],
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(18)),
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              Text(
                user.name,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
               Text(
                '@${user.name}',
                style: TextStyle(color: AppColors.textColor, fontSize: 15),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          '0',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          'Attended',
                          style: TextStyle(
                              color: AppColors.textColor, fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '0',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          'Hosted',
                          style: TextStyle(
                              color: AppColors.textColor, fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '\$${user.balance}',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          'Earned',
                          style: TextStyle(
                              color: AppColors.textColor, fontSize: 16),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Positioned(
            top: -50,
            right: 0,
            left: 0,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.greenAccent.withOpacity(0.2),
              child: const CircleAvatar(
                backgroundImage: const NetworkImage(
                    'https://hips.hearstapps.com/hmg-prod/images/katara-avatar-the-last-airbender-1590006359.png'),
                radius: 47,
              ),
            )),
      ],
    );
  }
}
