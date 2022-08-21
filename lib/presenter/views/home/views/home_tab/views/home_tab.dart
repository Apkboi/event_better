import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:square_tickets/data/remote/events/models/event_model.dart';
import 'package:square_tickets/data/remote/repository/data_repository.dart';
import 'package:square_tickets/presenter/bloc/events_bloc/events_bloc.dart';
import 'package:square_tickets/presenter/theme/app_colors.dart';
import 'package:square_tickets/presenter/views/home/widgets/event_item.dart';
import 'package:square_tickets/presenter/views/home/views/home_tab/widgets/featured_event_item.dart';
import 'package:square_tickets/presenter/views/home/views/home_tab/widgets/trending_event_item.dart';
import 'package:square_tickets/presenter/widgets/app_bar_button.dart';
import '../../../../../../di/injector.dart';
import '../../../../../bloc/auth/auth_bloc.dart';
import '../../../../../widgets/filled_textfield.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  int currentIndex = 0;
  final EventsBloc _eventsBloc = EventsBloc(injector.get());

  @override
  void initState() {
    _eventsBloc.add(GetAllEventEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              height: 330,
              decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  image: const DecorationImage(
                      image: NetworkImage(
                        'https://i.pinimg.com/564x/33/64/1e/33641e566a3cb829a8a53669a734d7aa.jpg',
                      ),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.amber,
                        child: CircleAvatar(
                          radius: 23,
                          backgroundImage: NetworkImage(
                              'https://hips.hearstapps.com/hmg-prod/images/katara-avatar-the-last-airbender-1590006359.png'),
                        ),
                      ),
                      Expanded(
                          child: Center(
                              child: Text(
                                'Hello Dear 😄',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ))),
                      AppBarButton(),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: 'Discover ',
                          style: TextStyle(
                              color: AppColors.amber,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: 'Amazing Events',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold))
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const FilledTextField(
                    hint: 'Find events around you ',
                    preffix: Icon(
                      LineIcons.searchengin,
                      color: AppColors.textColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Featured',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            StreamBuilder<List<EventModel>>(

              stream: injector.get<DataRepository>().getAllEvents(),
              builder: (context, state) {
                if (!state.hasData) {
                  return  Center(

                    child: Column(
                      children: const [
                        SizedBox(height: 400,),
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                } else if (state.hasData) {
                  return Container(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 260,
                        ),
                        SizedBox(
                          height: 155,
                          child: GestureDetector(
                            onHorizontalDragStart: (details) {},
                            child: PageView.builder(
                                onPageChanged: (index) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                                controller:
                                PageController(viewportFraction: 0.8),
                                itemCount: state.data!.length,
                                itemBuilder: (context, index) {
                                  var _scale =
                                  currentIndex == index ? 1.0 : 0.9;
                                  return TweenAnimationBuilder<double>(
                                    curve: Curves.easeIn,
                                    duration: const Duration(milliseconds: 335),
                                    tween: Tween(begin: _scale, end: _scale),
                                    builder: (context, value, child) {
                                      return Transform.scale(
                                        child: child,
                                        scale: value,
                                      );
                                    },
                                    child:  FeaturedEventItem(eventModel: state.data![index]),
                                  );
                                }),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Trending',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                              const Text(
                                'See all',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: AppColors.textColor),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 224,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            dragStartBehavior: DragStartBehavior.start,
                            shrinkWrap: true,
                            itemCount: state.data!.length,

                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                TrendingEventItem(
                                  eventModel: state.data![index],
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recommended',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                              const Text(
                                'See all',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: AppColors.textColor),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.data!.length,
                          itemBuilder: (context, index) =>  EventItem( eventModel: state.data![index],),
                        )
                      ],
                    ),
                  );
                }
                else if(state.hasError) {
                  return Container(color: Colors.red,height: 500,);
                }else {

                  return Container(color: Colors.blue,height: 500,);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
