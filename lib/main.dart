import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/features/search/controller/searchbar_controller.dart';
import 'package:salon_app/features/auth/view/pages/auth.dart';
import 'package:salon_app/features/home/view/home_page.dart';
import 'package:salon_app/pages/onboarding.page.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'controller/location_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<LatLonController>(
              create: ((context) => LatLonController())),
          ChangeNotifierProvider<SearchbarController>(
              create: ((context) => SearchbarController())),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Salon app',
            theme: ThemeData(
              fontFamily: "Inter",
            ),
            home: AuthPage()
            //const AuthPage()
            // const Wrapper(),
            //TestWidget()
            ),
      ),
    );
  }
}

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomePage(),
    const OnboardingPage(),
    const OnboardingPage(),
    const OnboardingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          child: Material(child: _children[_currentIndex])),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 5,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(size: 20),
        unselectedIconTheme: const IconThemeData(size: 18),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.calendar,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.chat_bubble,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
