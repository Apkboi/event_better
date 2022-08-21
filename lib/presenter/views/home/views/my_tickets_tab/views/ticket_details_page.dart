import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:square_tickets/presenter/theme/app_colors.dart';
import 'package:square_tickets/presenter/views/home/views/my_tickets_tab/widgets/ticket_detail_item.dart';

import '../../../../../../data/remote/events/models/tickets_model.dart';

class TicketDetailsPage extends StatefulWidget {
  const TicketDetailsPage({Key? key, required this.pageIndex, required this.ticketModel}) : super(key: key);
  final int pageIndex;
  final TicketModel ticketModel;

  @override
  State<TicketDetailsPage> createState() => _TicketDetailsPageState();
}

class _TicketDetailsPageState extends State<TicketDetailsPage> {
   late PageController pageController;
  int currentIndex =0;
  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:  [

            const SizedBox(height: 30,),
            // Row(
            //   children: [
            //     Visibility(
            //       visible: currentIndex !=0,
            //       child: IconButton(
            //           onPressed: () {
            //            navigatePage( currentIndex-1);
            //           }, icon: const Icon(Icons.arrow_back_ios),color: AppColors.textColor,),
            //     ),
            //      Expanded(
            //         child: Text('Ticket ${currentIndex+1} of 5',style: const TextStyle(color: AppColors.textColor),textAlign: TextAlign.center,)),
            //     Visibility(
            //       visible: currentIndex !=4,
            //       child: IconButton(
            //           onPressed: () {
            //            navigatePage( currentIndex+1);
            //           }, icon:  const Icon(Icons.arrow_forward_ios),color: AppColors.textColor,),
            //     )
            //
            //   ],
            // ),
            Expanded(child: TicketDetailtem(pageIndex: 0, ticketModel: widget.ticketModel,)),

            const SizedBox(height: 10,),
            // Expanded(
            //   child: PageView.builder(
            //     controller: pageController,
            //     itemCount: 5,
            //     onPageChanged: (index){
            //       setState(() {currentIndex = index;});
            //     },
            //     itemBuilder: (context, index) =>  TicketDetailtem(pageIndex: index == 0 ? widget.pageIndex:index+1,),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
  void navigatePage(int index){

    log(index.toString());

    pageController.animateToPage(index,curve: Curves.easeIn,duration: const Duration(seconds: 1));
    setState(() {
      currentIndex = index;
    });
  }
}
