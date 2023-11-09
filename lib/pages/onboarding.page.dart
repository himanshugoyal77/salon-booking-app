import 'dart:async';

import 'package:flutter/material.dart';

const List<String> imgList = [
  'https://images.unsplash.com/photo-1580618672591-eb180b1a973f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8c2Fsb258ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1632345031435-8727f6897d53?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
  'https://images.unsplash.com/photo-1589710751893-f9a6770ad71b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80',
];

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int imgIndex = 0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        print(imgIndex);
        if (imgIndex == 2) {
          imgIndex = 0;
        } else {
          imgIndex++;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: FractionallySizedBox(
            heightFactor: 0.6,
            widthFactor: 1,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: 0.1,
              child: Image.network(
                imgList[imgIndex],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          child: Column(children: [
            Text(
              'Unlock Your Ultimate Beauty with our Salon App',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ]),
        )
      ],
    ));
  }
}
