// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:intl/intl.dart';
import 'package:parties_hall_app/services/endpoint.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants/colors_constants.dart';
import '../constants/string_constants.dart';
import '../helper/common_helper.dart';
import '../helper/form_validator.dart';
import '../models/hallModel.dart';
import '../providers/AuthProvider.dart';
import '../services/rest_api_services.dart';
import '../utils/progressIndicatorDialog.dart';
import '../utils/style.dart';
import '../utils/utils.dart';
import '../widgets/customButton.dart';
import '../widgets/customTextForm.dart';
import '../widgets/toast.dart';


class BookingCalendarWidget extends StatefulWidget {
  const BookingCalendarWidget({Key? key, required this.model}) : super(key: key);
  final Result model;
  @override
  _BookingCalendarWidgetState createState() => _BookingCalendarWidgetState();
}

class _BookingCalendarWidgetState extends State<BookingCalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  // Initial Selected Value
  String dropdownvalue = 'الفترة الصباحية';

  // List of items in our dropdown menu
  var items = [
    'الفترة الصباحية',
    'الفترة المسائية',
    ' يوم كامل',
  ];

  @override
  Widget build(BuildContext context) {
    double height = CommonHelper.getScreenHeight(context) - CommonHelper.getSizePaddingTopScreen(context);
    double width = CommonHelper.getScreenWidth(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                // Use `selectedDayPredicate` to determine which day is currently selected.
                // If this returns true, then `day` will be marked as selected.

                // Using `isSameDay` is recommended to disregard
                // the time-part of compared DateTime objects.
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day

                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  print('--------_selectedDay-------------${_selectedDay}');
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 10,),
            DropdownButton(

              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          
            const SizedBox(height: 20,),
            CustomButton(
              onPressed: () async {
                if(Provider.of<AuthProvider>(context,listen: false).userId == 0){
                  showToast(message: 'يرجى تسجيل الدخول', state: ToastStates.error);
                  return;
                }
                if (await CommonHelper.checkInternetConnection()) {
                  ProgressIndicatorDialog().show(context, text: 'جاري الحجز...');
                dynamic response = await RestApiServices().postData(context,
                    {
                      'hallId':widget.model.hallId.toString() ?? '0',
                      'userId':Provider.of<AuthProvider>(context,listen: false).userId.toString() ?? '0',
                      'date':DateFormat('yyyy-MM-dd').format(_selectedDay!),
                      'name':nameController.text.toString().trim(),
                      'phone':phoneNumberController.text.toString().trim(),
                      'period':dropdownvalue,
                    }, EndPoint.addBookingHall);
                if(response !=null){
                if(response['success']){


                 // sendMail();


                  showToast(message: response['message'], state: ToastStates.success);
                }else{
                  showToast(message: response['message'], state: ToastStates.error);
                }
                }
                  Navigator.of(context).pop();
                } else {
                showToast(message: txt_notInternet, state: ToastStates.error);

                }

              },
              margin: const EdgeInsets.symmetric(
                  horizontal: 5.0, vertical: 8.0),
              width: width,
              bgColor: AppColor.PrimaryColor,
              bgOverlayColor: Colors.white.withOpacity(0.8),
              txtColor: Colors.white,
              text: 'حجز',
            ),
            const SizedBox(height: 10,),
          ],
        ),
      )
    );
  }

  Future<void> sendMail() async {
    // final Email email = Email(
    //   body: 'تم الحجز بنجاح',
    //   subject: 'تم الحجز بنجاح',
    //   recipients:Provider.of<AuthProvider>(context,listen: false).email ,
    //   isHTML: false,
    // );
    //
    // String platformResponse;
    //
    // try {
    //   await FlutterEmailSender.send(email);
    //   platformResponse = 'success';
    // } catch (error) {
    //   platformResponse = error.toString();
    // }

    String username = '';
    String password = '';

    final smtpServer = gmail(username, password);
    // Creating the Gmail server
    // Create our email message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add(Provider.of<AuthProvider>(context,listen: false).email) //recipent email
      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
      // ..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
      ..subject = 'تم الحجز بنجاح :: 😀 :: ${DateTime.now()}' //subject of the email
      ..text = 'تم الحجز بنجاح'; //body of the email

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString()); //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n'+ e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }


  }
}