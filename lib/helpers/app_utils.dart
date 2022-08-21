import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:square_tickets/presenter/theme/app_colors.dart';

import '../presenter/widgets/custom_button.dart';

class AppUtils {
  AppUtils._();

  // static Future<Widget> getFirstScreen() async {
  //   bool isFirstTimeUser =
  //   await StorageHelper.getBoolean(StorageKeys.firsTimeUser, true);
  //   bool isLoggedIn =
  //   await StorageHelper.getBoolean(StorageKeys.stayLoggedIn, false);
  //
  //   String? regStatus =
  //   await StorageHelper.getString(StorageKeys.registrationStage);
  //
  //   // String? token =
  //   // await StorageHelper.getString(StorageKeys.token);
  //   log("IS FIRST TIME USER: $isFirstTimeUser");
  //   log("IS LOGGED IN: $isLoggedIn");
  //   if (isFirstTimeUser) {
  //     return const OnboardingScreen();
  //   } else {
  //     //-----------Login Check--------------
  //     if (isLoggedIn) {
  //       return const HomeScreen();
  //     } else {
  //       return const LoginScreen();
  //     }
  //   }
  // }

  // static Future<Widget> getLogo() async {
  //   bool isDarkMode =
  //   await StorageHelper.getBoolean(StorageKeys.isDarkmode, true);
  //   if (isDarkMode) {
  //     return Image.asset(
  //       'assets/png/bond_logo.png',
  //       width: 100,
  //     );
  //   } else {
  //     return Image.asset(
  //       'assets/png/bond_logo_dark.png',
  //       width: 100,
  //     );
  //   }
  //
  // }

  static String formatDateTime(DateTime? t) {
    return DateFormat("E MMM d, yyyy")
        .format(t!);
  }
  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (ctx) => Container());
  }

  // static String getDateAndTime(DateTime createdAt) {
  //   return DateFormat("MMMM dd, yyyy hh:mm a").format(createdAt);
  // }

  static void showSuccessSuccessDialog(BuildContext context,
      {String? title, String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/png/success.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(
              height: 32.0,
            ),
            if (title != null)
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            if (title != null)
              const SizedBox(
                height: 32.0,
              ),
            Text(
              '$message',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(
              height: 32.0,
            ),
            CustomButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }

  static void showAnimatedProgressDialog(BuildContext context,
      {String? title}) {
    showGeneralDialog(
      useRootNavigator: false,
      context: context,
      barrierDismissible: false,
      barrierLabel: 'label',
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => Dialog(
        backgroundColor: Theme.of(context).cardTheme.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(width: 30),
                  Flexible(
                    child: Text(
                      title ?? 'Please wait...',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }

  static Future<List<PlatformFile>> fetchMedia(
      {bool allowMultiple = false,
        Function(FilePickerResult? result)? onSelect}) async {
    try {
      FilePicker filePicker = FilePicker.platform;
      FilePickerResult? result = await filePicker.pickFiles(
        type: FileType.custom,
        allowCompression: true,
        allowMultiple: allowMultiple,
        allowedExtensions: ['mp4', 'mov', 'jpg', 'jpeg', 'png'],
      ).then((value) {
        log(value!.files.length.toString());
        onSelect!(value);
      });
      if (result != null) {
        return result.files;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<void> copyText(String text) async {
    Clipboard.setData(ClipboardData(text: text));
  }

  static void showContentDialog(BuildContext context,{required String paymentLink,required VoidCallback onclose,}) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(

          backgroundColor: Theme.of(context).scaffoldBackgroundColor,

              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        child: TextButton(

                            style: TextButton.styleFrom(backgroundColor: Colors.red,shape: const StadiumBorder()),
                            onPressed: (){
                              Navigator.pop(context);
                              onclose();
                            }, child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const[
                            Icon(Icons.close,size: 15,color: Colors.white,),
                           SizedBox(width: 5,),
                           Text('Close',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                        ],)),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Image.asset('assets/images/png/success.png',height: 70,width: 70,),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Generated PaymentLink',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                        '''Congratulations!!! you just created a payment link to book this ticket below is your payment link. you can now share''',
                        style: TextStyle(color: AppColors.textColor),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                paymentLink,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  copyText(paymentLink);
                                  CustomSnackBar.show(context, message: 'Link Copied');
                                }, icon: const Icon(Icons.copy))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    CustomButton(child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.ios_share,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text('Share',style: TextStyle(color: Colors.white),),
                      ],
                    ), onPressed: ()  {
                       Share.share('You can Use this link to Checkout my event ticket $paymentLink',subject: 'Square chekout link');
                    })
                  ],
                ),
              ),
            ));
  }

//   static void showCustomToast(String msg, [Color? bgColor, Color? textColor]) =>
//       Fluttertoast.showToast(
//           msg: msg,
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//           backgroundColor: bgColor ?? Colors.black,
//           textColor: textColor ?? Colors.white,
//           fontSize: 16);
//
//   static Future<void> launchInAppBrowser(
//       BuildContext context, String url) async {
//     try {
//       return launch(
//         url,
//         customTabsOption: CustomTabsOption(
//           toolbarColor: Theme.of(context).primaryColor,
//           enableDefaultShare: false,
//           enableUrlBarHiding: false,
//           showPageTitle: false,
//           animation: CustomTabsSystemAnimation.slideIn(),
//           extraCustomTabs: const <String>[
//             'org.mozilla.firefox',
//             'com.microsoft.emmx',
//           ],
//         ),
//         safariVCOption: SafariViewControllerOption(
//           preferredBarTintColor: Theme.of(context).primaryColor,
//           preferredControlTintColor: Colors.white,
//           barCollapsingEnabled: true,
//           entersReaderIfAvailable: false,
//           dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
//         ),
//       );
//     } catch (e) {
// // An exception is thrown if browser app is not installed on Android device.
//       debugPrint(e.toString());
//       return Future.error("error");
//     }
//   }
//
//   static String formatDateTime(int? t) {
//     return DateFormat("E MMM d, yyyy・h:mm a")
//         .format(DateTime.fromMillisecondsSinceEpoch(t!));
//   }
//
//   static String formatMoney(int? t) {
//     return NumberFormat.currency(
//       symbol: "\$",
//     ).format(t);
//   }

}

class CustomSnackBar {
  final BuildContext context;

  CustomSnackBar({required this.context});

  CustomSnackBar.show(
    this.context, {
    required String message,
    Function? action,
    String? actionMessage,
    Color? backgroundColor,
  }) {
    final snackBar = SnackBar(
      action: action == null
          ? null
          : SnackBarAction(
              label: actionMessage ?? "OK",
              onPressed: () => action,
              textColor: Colors.white,
            ),
      backgroundColor: backgroundColor ?? backgroundColor ?? Colors.black,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  CustomSnackBar.showError(
    this.context, {
    required String message,
    Function? action,
    String? actionMessage,
    Color? backgroundColor,
  }) {
    final snackBar = SnackBar(
      action: action == null
          ? null
          : SnackBarAction(
              label: actionMessage ?? "OK",
              onPressed: () => action,
              textColor: Colors.white,
            ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: backgroundColor ?? backgroundColor ?? Colors.red,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
