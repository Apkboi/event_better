import 'dart:developer';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:square_tickets/data/remote/events/models/tickets_model.dart';
import 'package:square_tickets/helpers/app_utils.dart';
import 'package:square_tickets/presenter/widgets/my_seperator.dart';
import '../../../../../theme/app_colors.dart';
import '../../../widgets/checkout_webview.dart';

class TicketDetailtem extends StatefulWidget {
  const TicketDetailtem({Key? key, required this.pageIndex, required this.ticketModel}) : super(key: key);
  final int pageIndex ;
  final TicketModel ticketModel;

  @override
  State<TicketDetailtem> createState() => _TicketDetailtemState();
}

class _TicketDetailtemState extends State<TicketDetailtem> {
  late String  svg ;
@override
  void initState() {
  buildBarcode(Barcode.code128(),  widget.ticketModel.id,height: 70,width: 400,);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      physics: const BouncingScrollPhysics(),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'eventImag${widget.pageIndex}',
                transitionOnUserGestures: true,
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 6,
                            offset: Offset(0, 2))
                      ],
                      borderRadius: BorderRadius.circular(16),
                      image:  DecorationImage(
                          image: NetworkImage(
                              widget.ticketModel.event.posterUrl.isEmpty?
                              'https://storage.googleapis.com/io-19-assets/images/recap/carousels/extended/carousel-4_1x.jpg'
                                  : widget.ticketModel.event.posterUrl[0]),
                          fit: BoxFit.cover)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 45,
                        child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                )),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children:  [
                                Text(
                                  widget.ticketModel.event.eventDate.day.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                ),
                                Text(
                                  DateFormat(DateFormat.ABBR_MONTH.toUpperCase()).format(widget.ticketModel.event.eventDate),

                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                )
                              ],
                            )),
                      ),
                      Spacer(),
                      // SizedBox(
                      //   width: 40,
                      //   child: TextButton(
                      //
                      //       onPressed: (){},
                      //       style: TextButton.styleFrom(
                      //
                      //       backgroundColor: Colors.white.withOpacity(0.8),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(8),)),
                      //       child: const Icon(Icons.bookmark,color: Colors.indigo,size: 16,)),
                      // )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.ticketModel.event.eventTheme,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.star,
                              size: 14,
                              color: AppColors.amber,
                            ),
                            Icon(
                              Icons.star,
                              size: 14,
                              color: AppColors.amber,
                            ),
                            Icon(
                              Icons.star,
                              size: 14,
                              color: AppColors.amber,
                            ),
                            Icon(
                              Icons.star,
                              size: 14,
                              color: AppColors.amber,
                            ),
                          ],
                        ),
                         Text(
                          widget.ticketModel.event.location,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                //  Share Button here
                ],
              ),


               const SizedBox(
                height: 20,),
              Stack(
                children: [
                   const SizedBox(
                       height: 50,
                       child: Center(child: MySeparator(color: AppColors.textColor,))),

                  SizedBox(

                    height: 50,

                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,

                      children: [
                        Positioned(
                            left: -25,
                            bottom: 0,
                            top: 0,
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius:15,
                            )),
                        Positioned(
                            right: -25,
                            bottom: 0,
                            top: 0,
                            child: CircleAvatar(
                              backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                              radius:15,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,),

              const Text('Location',style: TextStyle(color: AppColors.textColor,fontSize: 13),),
               Text(widget.ticketModel.event.location,style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,fontWeight: FontWeight.bold),),
              const SizedBox(
                height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                    const Text('Event tittle',style: TextStyle(color: AppColors.textColor,fontSize: 13),),
                    Text(widget.ticketModel.event.eventTheme,style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,fontWeight: FontWeight.w500,),),
                  ],),
                ),
                  const SizedBox(width: 16,),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        const Text('Date ',style: TextStyle(color: AppColors.textColor,fontSize: 13),),
                        Text(AppUtils.formatDateTime(widget.ticketModel.event.eventDate),style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,fontWeight: FontWeight.w500,),),
                      ],),
                  ),

              ],),
              const SizedBox(
                height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        const Text('Time',style: TextStyle(color: AppColors.textColor,fontSize: 13),),
                        Text(DateFormat(DateFormat.HOUR).format(widget.ticketModel.event.eventDate),style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,fontWeight: FontWeight.w500,),),
                      ],),
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        const Text('Dresscode ',style: TextStyle(color: AppColors.textColor,fontSize: 13,fontWeight: FontWeight.bold),),
                        Text('None',style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,fontWeight: FontWeight.w500,),),
                      ],),
                  ),

                ],),
              const SizedBox(
                height: 20,),
              const Text('Ticket size',style: TextStyle(color: AppColors.textColor,fontSize: 13),),
              Text(widget.ticketModel.size.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,fontWeight: FontWeight.w500,),),
              const SizedBox(
                height: 20,),
              Stack(
                children: [
                  const SizedBox(
                      height: 50,
                      child: Center(child: MySeparator(color: AppColors.textColor,))),

                  SizedBox(

                    height: 50,

                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,

                      children: [
                        Positioned(
                            left: -25,
                            bottom: 0,
                            top: 0,
                            child: CircleAvatar(
                              backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                              radius:15,
                            )),
                        Positioned(
                            right: -25,
                            bottom: 0,
                            top: 0,
                            child: CircleAvatar(
                              backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                              radius:15,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,),

            widget.ticketModel.status != 'not paid'?  Column(children: [
                Center(child: Text('SCAN BARCODE',style: TextStyle(fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.onPrimary),)),
                Row(
                  children: [
                    Expanded(child: Container(color:Colors.white,child: SvgPicture.string(svg,))),
                  ],
                )
              ],):


                Column(children: [
                  Center(child: Text('COMPLETE PAYMENT WITH LINK BELOW',style: TextStyle(fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.onPrimary),)),
                  const SizedBox(height: 10,),

                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebViewExample(
                            url: widget.ticketModel.paymentLink,
                            onSuccess: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              AppUtils.showSuccessSuccessDialog(context,message: 'Congrats you successfully purchased a ticket for this event');
                            },
                            ticket: widget.ticketModel),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.ticketModel.paymentLink,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color:
                                    Theme.of(context).colorScheme.primary),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  AppUtils.copyText(widget.ticketModel.paymentLink);
                                  CustomSnackBar.show(context, message: 'Link Copied');
                                }, icon:  Icon(Icons.copy,color: Theme.of(context).colorScheme.onPrimary,))
                          ],
                        ),
                      ),
                    ),
                  ),

                ],),

              const SizedBox(height: 10,)


            ],
          ),
        ),
      ),
    );
  }


  void buildBarcode(
      Barcode bc,
      String data, {
        String? filename,
        double? width,
        double? height,
        double? fontHeight,
      }) {
    /// Create the Barcode
    /// b
     svg = bc.toSvg(

      data,

      width: width ?? 200,
      height: height ?? 80,
      fontHeight: fontHeight,
    );
     log(svg);

    // Save the image
    // filename ??= bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
    // File('$filename.svg').writeAsStringSync(svg);
  }
}
