import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/features/booking/booking_date.dart';
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
  List<int> selectedServices = [];
  List<Map<String, dynamic>> unselectedServices = [
    {
      "id": 0,
      "price": 49.99,
      "service": "Haircut",
    },
    {
      "id": 1,
      "price": 69.99,
      "service": "Hair Color",
    },
    {
      "id": 2,
      "price": 29.99,
      "service": "Manicure",
    },
    {
      "id": 3,
      "price": 49.99,
      "service": "Pedicure",
    },
    {
      "id": 4,
      "price": 9.99,
      "service": "Nail Art",
    },
  ];

  @override
  Widget build(BuildContext context) {
    double findTotal() {
      double total = 0;
      for (var i = 0; i < selectedServices.length; i++) {
        total += unselectedServices[selectedServices[i]]["price"];
      }
      return total;
    }

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
        title: Text(
          "Book an appointment",
          style: AppTextStyles.bodyRegularBold
              .copyWith(fontSize: 16, color: Styles.primaryColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/artists/a1.jpg'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: AppTextStyles.bodyRegularBold
                            .copyWith(fontSize: 16, color: Styles.primaryColor),
                      ),
                      Text(
                        widget.services.join(", "),
                        style: AppTextStyles.bodyExtraSmall
                            .copyWith(fontSize: 12, color: Styles.textGray),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                          Text(context.read<BookingDate>().formatedDate,
                              style: AppTextStyles.bodySmallMedium),
                          InkWell(
                            onTap: () =>
                                context.read<BookingDate>().closeDialogBox(),
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
                visible: context.watch<BookingDate>().closeDialog,
                child: const CustomDatePicker(),
              ), //
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
              ),
              const SizedBox(height: 20),
              Text(
                "SELECT SERVICES",
                style: AppTextStyles.bodyExtraSmall,
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ...unselectedServices
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                visualDensity: VisualDensity.compact,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                        color: Styles.textGray, width: 1)),
                                contentPadding:
                                    const EdgeInsets.only(left: 10, right: 20),
                                leading: Checkbox(
                                    value: selectedServices.contains(e["id"]),
                                    activeColor: Styles.primaryColor,
                                    onChanged: (value) async {
                                      setState(() {
                                        if (value!) {
                                          selectedServices.add(e["id"]);
                                        } else {
                                          selectedServices.remove(e["id"]);
                                        }
                                        //   unselectedServices.remove(e);
                                      });
                                    }),
                                title: Text(e["service"]),
                                trailing: Text("\$${e["price"]}"),
                              ),
                            ))
                        .toList(),
                  ],
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    "Total: \$ ${findTotal().toStringAsFixed(2)}",
                    style: AppTextStyles.bodyExtraSmall,
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(width: 15)
                ],
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                    backgroundColor: Styles.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/booking/confirm',
                        arguments: {
                          "name": widget.name,
                          "services": widget.services,
                          "id": widget.id,
                          "date": context.read<BookingDate>().formatedDate,
                          "time": time
                              .where((element) => element["isAvailable"])
                              .toList(),
                          "selectedServices": selectedServices
                        });
                  },
                  child: Text('Confirm Appointment',
                      style: AppTextStyles.heading6.copyWith(
                        fontSize: 18,
                        color: Colors.white,
                      ))),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
