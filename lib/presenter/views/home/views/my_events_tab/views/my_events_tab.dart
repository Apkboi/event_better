import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:square_tickets/data/remote/events/models/event_model.dart';
import 'package:square_tickets/data/remote/repository/data_repository.dart';
import 'package:square_tickets/di/injector.dart';
import 'package:square_tickets/presenter/theme/app_colors.dart';

import '../../../../../widgets/filled_textfield.dart';
import '../widgets/my_events_item.dart';

class MyEventsTab extends StatefulWidget {
  const MyEventsTab({Key? key}) : super(key: key);

  @override
  State<MyEventsTab> createState() => _MyEventsTabState();
}

class _MyEventsTabState extends State<MyEventsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<EventModel>>(
        stream: injector.get<DataRepository>().getUserEvents(),
        builder: (ctx, state) {
          if (!state.hasData) {
            return Center(
              child: Column(
                children: const [
                  SizedBox(
                    height: 400,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else if (state.hasData) {

            if(state.data!.isNotEmpty){ return NestedScrollView(
              floatHeaderSlivers: true,
              physics: const BouncingScrollPhysics(),
              body: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.data!.length,
                  itemBuilder: (context, index) =>
                      MyEventsItem(eventModel: state.data![index]),
                ),
              ),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            'My Events',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'This are the list of events you have hosted on SQUARE TICKETS ',
                            style: TextStyle(
                              color: AppColors.textColor,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FilledTextField(
                            hint: 'Find events around you ',
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
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  )
                ];
              },
            );}else{
              return const Center(child: Text('You have no events'),);
            }

          } else if (state.hasError) {
            return Container(
              color: Colors.red,
              height: 500,
            );
          } else {
            return Container(
              color: Colors.blue,
              height: 500,
            );
          }
        },
      ),
    );
  }
}
