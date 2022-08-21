import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:square_tickets/data/remote/models/user_model.dart';
import 'package:square_tickets/presenter/views/home/views/profile_tab/widgets/card_tile.dart';
import 'package:square_tickets/presenter/views/home/views/profile_tab/widgets/profile_card.dart';
import 'package:square_tickets/presenter/views/home/views/withdrawal_screen.dart';

import '../../../../../../di/injector.dart';
import '../../../../../bloc/auth/auth_bloc.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _authBloc = injector.get<AuthBloc>();
  late UserModel _model;

  @override
  void initState() {
    _model = _authBloc.userModel!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(
              height: 90,
            ),
             ProfileCard(user: _model,),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){

                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  WithdrawalScreen(balance:_model.balance),));
              },
              child: CardTile(
                  preffix: const Icon(
                    LineIcons.wallet,
                    color: Colors.greenAccent,
                    size: 30,
                  ),
                  suffix: Icon(
                    LineIcons.arrowRight,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  tittle: Text(
                    'Withdraw fundz',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            CardTile(
                preffix: const Icon(
                  LineIcons.paypalCreditCard,
                  color: Colors.pinkAccent,
                  size: 30,
                ),
                suffix: Icon(
                  LineIcons.arrowRight,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                tittle: Text(
                  'Payment Methods',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )),
            const SizedBox(
              height: 15,
            ),
            // CardTile(
            //     preffix: const Icon(
            //       LineIcons.user,
            //       color: Colors.amber,
            //       size: 30,
            //     ),
            //     suffix: SizedBox(
            //       height: 30,
            //       child: TextButton(
            //         onPressed: () {},
            //         child: const Text(
            //           'Pending',
            //           style: TextStyle(
            //               color: Colors.amber,
            //               fontSize: 13,
            //               fontWeight: FontWeight.bold),
            //         ),
            //         style: TextButton.styleFrom(
            //             shape: const StadiumBorder(),
            //             padding: const EdgeInsets.symmetric(horizontal: 16),
            //             backgroundColor: Colors.amber.withOpacity(
            //               0.3,
            //             )),
            //       ),
            //     ),
            //     tittle: Text(
            //       'Subscription',
            //       style: TextStyle(
            //           color: Theme.of(context).colorScheme.onPrimary,
            //           fontSize: 16,
            //           fontWeight: FontWeight.w600),
            //     )),
            // const SizedBox(
            //   height: 15,
            // ),
            // CardTile(
            //     preffix: const Icon(
            //       LineIcons.editAlt,
            //       color: Colors.indigo,
            //       size: 30,
            //     ),
            //     suffix: Icon(
            //       LineIcons.arrowRight,
            //       color: Theme.of(context).colorScheme.onPrimary,
            //     ),
            //     tittle: Text(
            //       'Edit Profile',
            //       style: TextStyle(
            //           color: Theme.of(context).colorScheme.onPrimary,
            //           fontSize: 16,
            //           fontWeight: FontWeight.w600),
            //     )),
            // const SizedBox(
            //   height: 15,
            // ),
            BlocConsumer<AuthBloc, AuthState>(
              bloc: _authBloc,
              listener: (context, state) {
                if(state is LogoutLoadingState ){
                  log('logging_out');
                }
              },
              builder: (context, state) {
                return CardTile(
                  preffix: const Icon(
                    LineIcons.doorClosed,
                    color: Colors.redAccent,
                    size: 30,
                  ),
                  suffix: Icon(
                    LineIcons.arrowRight,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  tittle: Text(
                    'Logout',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  onClick: () {
                    _authBloc.add(LogoutEvent());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
