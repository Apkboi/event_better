import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:square_tickets/data/remote/events/models/event_model.dart';
import 'package:square_tickets/data/remote/models/user_model.dart';
import 'package:square_tickets/di/injector.dart';
import 'package:square_tickets/presenter/bloc/auth/auth_bloc.dart';
import 'package:square_tickets/presenter/widgets/custom_button.dart';
import 'package:square_tickets/presenter/widgets/filled_textfield.dart';
import 'package:square_tickets/presenter/widgets/outlined_form_field.dart';

import '../../../../helpers/app_utils.dart';
import '../../../bloc/events_bloc/events_bloc.dart';
import '../../../widgets/image_picker_item.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final EventsBloc _eventsBloc = EventsBloc(injector.get());
  DateTime dob = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  List<String> pickedImages = [];
  List<String> firebaseImages = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController eventThemeController = TextEditingController();
  final TextEditingController eventDetailsController = TextEditingController();
  final TextEditingController locationCotroller = TextEditingController();
  final TextEditingController ticketSizeController = TextEditingController();
  final TextEditingController ticketPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: BlocListener<EventsBloc, EventsState>(
        bloc: _eventsBloc,
        listener: (context, state) {
          if (state is AddEventLoadingState) {
            AppUtils.showAnimatedProgressDialog(context);
          } else if (state is AddEventSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            AppUtils.showSuccessSuccessDialog(context,
                title: 'Event Added Successfully',
                message: 'Hurray you successfully added an event ');
            log('Success');
          } else if (state is AddEventFailureState) {
            Navigator.pop(context);
            CustomSnackBar.showError(context, message: state.error);
            log('Failed');
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Event theme',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedFormField(
                      controller: eventThemeController,
                      hint: 'Event Theme',
                      validator:
                          RequiredValidator(errorText: 'Enter event theme')),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Event Date and Time',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                        dialogBackgroundColor: Theme.of(context).cardColor),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1),
                                      lastDate: DateTime(2030))
                                  .then((value) => {
                                        setState(() {
                                          dob = value!;
                                        })
                                      });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(context).cardColor),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    size: 18,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppUtils.formatDateTime(dob),
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) => {
                                    setState(() {
                                      time = value!;
                                    })
                                  });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(context).cardColor),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 18,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      time.format(context),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Event Location',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedFormField(
                      controller: locationCotroller,
                      hint: 'Event Location',
                      validator:
                          RequiredValidator(errorText: 'Enter event location')),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Ticket Size',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedFormField(
                      controller: ticketSizeController,
                      hint: 'Free event',
                      inputType: TextInputType.number,
                      validator:
                          RequiredValidator(errorText: 'Enter ticket size')),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Ticket Price',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedFormField(
                      controller: ticketPriceController,
                      hint: 'Free event',
                      inputType: TextInputType.number,
                      validator:
                          RequiredValidator(errorText: 'Enter ticket price')),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Event Details',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedFormField(
                      controller: eventDetailsController,
                      hint: 'Event Details',
                      maxLine: 5,
                      validator:
                          RequiredValidator(errorText: 'Enter event details')),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Event Images',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      _fetchMedia();
                    },
                    child: pickedImages.isNotEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: pickedImages.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        ImagePickerItem(
                                          image: pickedImages[index],
                                          onClose: () {
                                            setState(() {
                                              pickedImages
                                                  .remove(pickedImages[index]);
                                              // mediaFiles.removeAt(index);
                                            });
                                          },
                                        )),
                              ),
                              const Text(
                                'Tap to add image',
                                style: TextStyle(color: Colors.blueGrey),
                              )
                            ],
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Theme.of(context).cardColor),
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/png/upload_image.png',
                                    height: 200,
                                  ),
                                  const Text(
                                    'Tap To Upload Card',
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                      child: const Text('Add Event'),
                      onPressed: () {
                        addEvent();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _fetchMedia() async {
    var images = ['jpg', 'jpeg', 'png',  'PNG'];
    // var videos = ['mp4', 'mov'];
    // var files = await AppUtils.fetchMedia(
    //     allowMultiple: true,
    //     onSelect: (result) {
    //       if (result!.files.isNotEmpty) {
    //         for (var file in result.files) {
    //           if (images
    //               .where((element) => element == file.extension)
    //               .isNotEmpty) {
    //             pickedImages.add(file.path!);
    //
    //             setState(() {});
    //           }
    //         }
    //       }
    //     });
    await AppUtils.fetchMedia(
        allowMultiple: true,
        onSelect: (result) {
          if (result!.files.isNotEmpty) {
            for (var file in result.files) {
              if (images
                  .where((element) => element == file.extension)
                  .isNotEmpty) {
                pickedImages.add(file.path!);
                setState(() {});

                log(firebaseImages.length.toString());
              }
            }
          }
        });
  }

  void addEvent() {
    if (_formKey.currentState!.validate()) {
      log('validated');
      _eventsBloc.add(AddEventEvent(
          EventModel(
              eventTheme: eventThemeController.text,
              eventDate: dob,
              attending: [],
              aboutEvent: eventDetailsController.text,
              location: locationCotroller.text,
              ticketSize: int.parse(ticketSizeController.text),
              hostId: injector.get<AuthBloc>().uid,
              available_tickets: int.parse(ticketSizeController.text),
              posterUrl: pickedImages,
              host: injector.get<AuthBloc>().userModel!,
              ticketPrice: int.parse(ticketPriceController.text)),
          pickedImages));
    }
  }
}
