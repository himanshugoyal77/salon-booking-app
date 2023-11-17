import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/features/details/view/widgets/date_piceker.dart';
import 'package:salon_app/utils/ui/styles.dart';
import 'package:salon_app/utils/ui/text.dart';

List<Map<String, dynamic>> time = [
  {"time": "09:00 AM", "isAvailable": false},
  {"time": "10:00 AM", "isAvailable": false},
  {"time": "11:00 AM", "isAvailable": true},
  {"time": "12:00 PM", "isAvailable": false},
  {"time": "01:00 PM", "isAvailable": false},
  {"time": "04:00 PM", "isAvailable": false},
  {"time": "05:00 PM", "isAvailable": false},
  {"time": "06:00 PM", "isAvailable": false},
  {"time": "07:00 PM", "isAvailable": false},
  {"time": "08:00 PM", "isAvailable": true},
  {"time": "09:00 PM", "isAvailable": false}
];

class Book extends StatefulWidget {
  const Book(
      {super.key,
      required this.name,
      required this.services,
      required this.id});

  final String name;
  final int id;
  final List services;

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  bool showDatePicker = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.back,
            color: Styles.primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Book an appointment",
              style: AppTextStyles.bodyRegularBold
                  .copyWith(fontSize: 16, color: Styles.primaryColor),
            ),
            const SizedBox(height: 18),
            Text(
              "PICK A DATE",
              style: AppTextStyles.bodyExtraSmall,
            ),
            const SizedBox(height: 8),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              color: Styles.textGray,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Monday, 12 July',
                            style: AppTextStyles.bodySmallMedium),
                        InkWell(
                          onTap: () => setState(() {
                            showDatePicker = !showDatePicker;
                          }),
                          child: Text(
                            'Edit',
                            style: AppTextStyles.bodyRegularMedium,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Visibility(
              visible: showDatePicker,
              child: const CustomDatePicker(),
            ),
            const SizedBox(height: 18),
            Text(
              "PICK AVAILABLE TIME",
              style: AppTextStyles.bodyExtraSmall,
            ),
            const SizedBox(height: 8),
            GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              shrinkWrap: true,
              children: time
                  .map(
                    (e) => Chip(
                      backgroundColor: !e["isAvailable"]
                          ? Colors.transparent
                          : Styles.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: !e["isAvailable"]
                              ? Colors.grey[400]!
                              : Styles.primaryColor,
                        ),
                      ),
                      color: MaterialStateProperty.all(Styles.primaryColor),
                      labelPadding: const EdgeInsets.all(0),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      visualDensity: VisualDensity.compact,
                      label: Center(
                        child: Text(
                          e['time'] as String,
                          style: !e["isAvailable"]
                              ? AppTextStyles.bodyExtraSmall
                                  .copyWith(color: Colors.grey[600])
                              : AppTextStyles.bodyExtraSmallSemibold
                                  .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
