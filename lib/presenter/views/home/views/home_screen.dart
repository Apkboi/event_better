import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:square_tickets/presenter/theme/app_colors.dart';
import 'package:square_tickets/presenter/views/home/views/add_event_screen.dart';
import 'package:square_tickets/presenter/views/home/views/my_events_tab/views/my_events_tab.dart';
import 'package:square_tickets/presenter/views/home/views/my_tickets_tab/views/my_tickets_tab.dart';
import 'package:square_tickets/presenter/views/home/views/profile_tab/views/profile_tab.dart';

import '../widgets/fab_bottom_bar.dart';
import 'home_tab/views/home_tab.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activePage = 0;

  List<Widget> pages = [const HomeTab(), const MyEventsTab(), const MyTicketsTab(),const ProfileTab()];

  final PageController _pageController = PageController();

  void _selectedTab(int index) {
    setState(() {
      _activePage = index;
      _pageController.jumpToPage(index);

      // setState(() {
      //   _activePage = index;
      //   if (index == 3) {
      //     StorageHelper.setBoolean(StorageKeys.stayLoggedIn, false);
      //   } else if (index == 2) {
      //     StorageHelper.setBoolean(StorageKeys.hasOnBoarded, false);
      //   }
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FABBottomAppBar(
        iconSize: 25,
          items: [
            FABBottomAppBarItem(iconData: LineIcons.home, text: 'Home'),
            FABBottomAppBarItem(
                iconData: LineIcons.calendarAlt, text: 'My Events'),
            FABBottomAppBarItem(
                iconData: LineIcons.alternateTicket, text: 'My tickets'),
            FABBottomAppBarItem(

                iconData:  LineIcons.user, text: 'More'),
          ],
          centerItemText: '',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          color: Colors.blueGrey,
          selectedColor: AppColors.primarycolor2,
          onTabSelected: (index) {
            _selectedTab(index);
          }),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: pages,
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Card(
        shadowColor: Colors.blueGrey.shade200 ,
        color:Theme.of(context).colorScheme.primary,
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: const BorderSide(width: 2, color: Colors.white)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddEventScreen(),));
          },
          borderRadius: BorderRadius.circular(10.0),
          child: const SizedBox(
            width: 50,
            height: 50,
            child: Icon(
            FontAwesomeIcons.plus,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}
