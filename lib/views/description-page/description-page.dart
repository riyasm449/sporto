import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:sporto/models/shop.dart';
import 'package:sporto/utils/commons.dart';

class DescriptionPage extends StatefulWidget {
  final ShopDetails shopDetails;

  const DescriptionPage({this.shopDetails});

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white)),
            title: Text('Description', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Container(
                    height: 240,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Commons.bgLightColor),
                    child: (widget.shopDetails.imgUrl == null || widget.shopDetails.imgUrl == '')
                        ? Image.asset('assets/images/shop-bg.png', color: Commons.greyAccent3, fit: BoxFit.cover)
                        : Image.network(widget.shopDetails.imgUrl, fit: BoxFit.cover)),
                if (widget.shopDetails.imgUrl != null && widget.shopDetails.imgUrl != '')
                  Container(height: 240, width: MediaQuery.of(context).size.width, color: Colors.black.withOpacity(.3)),
                Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(widget.shopDetails.shopName ?? 'Shop Name',
                        style: TextStyle(
                            color: (widget.shopDetails.imgUrl != null && widget.shopDetails.imgUrl != '')
                                ? Colors.white
                                : Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)))
              ]),
              Divider(color: Commons.bgColor, thickness: 1, height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: Text('About',
                          style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold))),
                  Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: FlatButton(
                          color: Commons.bgColor,
                          onPressed: () {
                            showAlertDialog(context);
                          },
                          child: Text('Book an Appointment')))
                ],
              ),
              textField(context,
                  value: widget.shopDetails.description ??
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum'),
              textField(context,
                  title: 'Sports Offered', value: widget.shopDetails.sportsOffered ?? 'details not available'),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  child: Text('Contact',
                      style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold))),
              Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: ListTile(
                      leading: Icon(Icons.call_outlined, color: Colors.black, size: 25),
                      title: Text(widget.shopDetails.contactNumber ?? 'Number not available',
                          style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)))),
              Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: ListTile(
                      leading: Icon(Icons.my_location_outlined, color: Colors.black, size: 25),
                      title: Text(widget.shopDetails.address ?? 'Address',
                          style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)))),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    TextEditingController _mail = TextEditingController();
    TextEditingController _phone = TextEditingController();
    Widget okButton = FlatButton(
      child: Text("Confirm"),
      onPressed: () async {
        String username = 'app.sportoapp@gmail.com';
        String password = 'sportoapp123';
        final smtpServer = gmail(username, password);
        final message = Message()
          ..from = Address(username, 'Your name')
          ..recipients.add(widget.shopDetails.mailId)
          ..subject = 'Sporto App - New Appointment'
          ..text =
              '<<< You Have an New Appointment >>>\n\nShop Name: ${widget.shopDetails.shopName} \n Your Id: ${widget.shopDetails.shopId}\n\nContact Details:\n  Mail Id: ${_mail.text}\n  Phone: ${_phone.text}\n\nMail Sent through Sporto App.';
        final message2 = Message()
          ..from = Address(username, 'Your name')
          ..recipients.add(_mail.text)
          ..subject = 'Sporto App - New Appointment'
          ..text =
              '<<< Your Appointment is Placed - ${widget.shopDetails.shopName} >>>\n\nYou Can Also Contact Through \nmail: ${widget.shopDetails.mailId} \nphone: ${widget.shopDetails.contactNumber}\n\n';
        try {
          await send(message, smtpServer);
          await send(message2, smtpServer);
        } on MailerException catch (e) {
          print('Message not sent. $e');
          for (var p in e.problems) {
            print('Problem: ${p.code}: ${p.msg}');
          }
        }
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Book an Appointment"),
      content: Container(
          height: 150,
          child: Column(children: [
            TextField(
              controller: _mail,
              decoration: InputDecoration(hintText: 'Mail Id'),
            ),
            TextField(
                controller: _phone,
                decoration: InputDecoration(hintText: 'Phone Number'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly])
          ])),
      actions: [okButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Widget textField(BuildContext context, {String title, String value}) {
    return Column(
      children: [
        if (title != null)
          Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              child: Text(title ?? '',
                  style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold))),
        Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Text(value ?? '',
                style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w400),
                textAlign: TextAlign.justify))
      ],
    );
  }
}
