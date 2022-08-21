import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:square_tickets/data/remote/events/models/tickets_model.dart';
import 'package:square_tickets/di/injector.dart';
import 'package:square_tickets/presenter/bloc/auth/auth_bloc.dart';
import 'package:square_tickets/presenter/views/home/views/my_tickets_tab/widgets/my_tickets_item.dart';
import '../../../../../../data/remote/repository/data_repository.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../widgets/filled_textfield.dart';

class MyTicketsTab extends StatefulWidget {
  const MyTicketsTab({Key? key}) : super(key: key);

  @override
  State<MyTicketsTab> createState() => _MyTicketsTabState();
}

class _MyTicketsTabState extends State<MyTicketsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50,),
                  Text('My Tickets',style: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 20,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 10,),
                  const Text('This are the list of tickets you have purchased on SQUARE TICKETS ',style: TextStyle(color: AppColors.textColor,),),
                  const SizedBox(height: 10,),

                  FilledTextField(
                    hint: 'Search for tickets ',
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

                  const SizedBox(height: 10,),


                ],
              ),
              StreamBuilder<List<TicketModel>>(
                stream: injector.get<DataRepository>().getUserTickets(injector.get<AuthBloc>().uid),
                builder: (context, snapshot) {

                  if(snapshot.hasData){
                    if(snapshot.data!.isNotEmpty){
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data?.length ,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>  MyTicketsItem(index: index, ticketModel: snapshot.data![index],),
                      );

                    }else{
                      return  Center(child: Text('You have no tickets',style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),);
                    }
                  }else if(!snapshot.hasData){
                    return const Center(child: CircularProgressIndicator(),);
                  }else {
                    return const Center(child: Text('An Error Occured'),);
                  }



                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
