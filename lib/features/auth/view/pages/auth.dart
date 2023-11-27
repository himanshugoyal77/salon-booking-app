import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/components/textfields.dart';
import 'package:salon_app/db/usermodel.dart';
import 'package:salon_app/features/auth/controller/login_provider.dart';
import 'package:salon_app/features/auth/controller/siginin.dart';
import 'package:salon_app/features/auth/view/widgets/signin_options.dart';
import 'package:salon_app/features/home/view/home_page.dart';
import 'package:salon_app/main.dart';
import 'package:salon_app/utils/ui/styles.dart';
import 'package:salon_app/utils/ui/text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../db/userinfo.dart';
import '../../../../utils/services/notifications.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  String? profileUrl;

  void saveToFirebase(User user) {
    FirebaseFirestore.instance.collection("userInfo").doc(user.uid).set({
      "phone": phoneController.text,
      "age": ageController.text,
      "username": usernameController.text,
      //  "imageUrl": ,
      "email": emailController.text,
      "city": cityController.text,
      "uid": user.uid,
      "profileUrl": profileUrl ??
          'https://img.freepik.com/premium-vector/woman-avatar-profile-round-icon_24640-14047.jpg?w=360',
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
      'pastAppointments': [],
      'upcomingAppointments': [],
      'reviews': [],
      'favourites': [],
      'notifications': [],
    }).then((value) {
      ToastManager.showErrorToast(context, 'Account created successfully');
      FirebaseFirestore.instance
          .collection("userInfo")
          .doc(user.uid)
          .get()
          .then((value) {
        UserDb.setUserInfo(UserModel.fromJson(value.data()!));
      });
    }).then((value) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => Wrapper())));
  }

  File? image;
  UploadTask? uploadTask;

  uploadImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
      uploadToFirebase();
    } on PlatformException catch (e) {
      print("an erroe occures  ${e}");
    }
  }

  uploadToFirebase() async {
    final path = "userProfiles/${image!.absolute.toString().substring(34)}";
    final file = File(image!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print("download Link ${urlDownload}");
    setState(() {
      profileUrl = urlDownload;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authMethodProvider = Provider.of<AuthMethod>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              height: size.height * 0.6,
              width: size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1562322140-8baeececf3df?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      fit: BoxFit.cover)),
              child: Image.asset(
                'assets/transparent1.png',
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height * 0.4,
                width: size.width,
                color: Styles.secondaryColor,
              ),
            ),
            Positioned(
              bottom: 110 + size.height * 0.5,
              left: 0,
              right: 0,
              child: Text(
                "Let\'s get you ${authMethodProvider.isSigin ? 'Login!' : 'SignUp'}",
                style: TextStyle(
                  color: authMethodProvider.isSigin
                      ? Colors.white
                      : Styles.primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              bottom: 85 + size.height * 0.5,
              left: 0,
              right: 0,
              child: const Text(
                'Enter your information below',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            authMethodProvider.isSigin
                ? SigninModal(
                    size: size,
                    email: emailController,
                    password: passwordController,
                  )
                : Positioned(
                    bottom: 30,
                    left: 22,
                    right: 22,
                    child: Container(
                      height: size.height * 0.84,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 3),
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 23),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Styles.primaryColor,
                                  child: profileUrl == null
                                      ? const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 40,
                                        )
                                      : ClipOval(
                                          child: Image.network(
                                            profileUrl!,
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      uploadImage();
                                    },
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Styles.secondaryColor,
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: Styles.primaryColor,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            VerveField(
                              label: "username",
                              textFieldType: TextFieldType.text,
                              controller: usernameController,
                            ),
                            VerveField(
                              label: "E-mail address",
                              textFieldType: TextFieldType.email,
                              controller: emailController,
                            ),
                            VerveField(
                              label: "phone",
                              textFieldType: TextFieldType.number,
                              controller: phoneController,
                            ),
                            VerveField(
                              label: "password",
                              textFieldType: TextFieldType.password,
                              controller: passwordController,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: VerveField(
                                    controller: ageController,
                                    label: 'Age',
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: VerveField(
                                    controller: cityController,
                                    label: 'City',
                                  ),
                                )
                              ],
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width, 45),
                                  backgroundColor: Styles.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  Authentication.creteWithEmailandPassword(
                                          emailController.text,
                                          passwordController.text)
                                      .then((value) {
                                    if (value != null) {
                                      saveToFirebase(value);
                                    } else {
                                      ToastManager.showErrorToast(
                                          context, 'Account already exists');
                                    }
                                  });
                                },
                                child: const Text('Sign Up')),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  authMethodProvider.changeMethodTOSignIn();
                                });
                              },
                              child: RichText(
                                  text: TextSpan(
                                      text: 'Don\'t have an account?',
                                      style: AppTextStyles.bodyExtraSmall
                                          .copyWith(color: Styles.textGray),
                                      children: [
                                    TextSpan(
                                      text: ' Login',
                                      style: AppTextStyles.bodyExtraSmallMedium
                                          .copyWith(color: Styles.primaryColor),
                                    )
                                  ])),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class SigninModal extends StatefulWidget {
  SigninModal({
    Key? key,
    required this.size,
    required this.email,
    required this.password,
  }) : super(key: key);

  final Size size;
  final TextEditingController email;
  final TextEditingController password;

  @override
  State<SigninModal> createState() => _SigninModalState();
}

class _SigninModalState extends State<SigninModal> {
  @override
  Widget build(BuildContext context) {
    final authMethodProvider = Provider.of<AuthMethod>(context);

    return Positioned(
      bottom: 30,
      left: 22,
      right: 22,
      child: Container(
        height: widget.size.height * 0.5 + 40,
        width: widget.size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SignInoptions(
                    icon: Icons.person_3_outlined,
                    text: 'Guest',
                  ),
                  SignInoptions(
                    icon: Icons.mail_outline,
                    text: 'Google',
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Or login with'),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Divider(),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              VerveField(
                label: "E-mail address",
                textFieldType: TextFieldType.email,
                controller: widget.email,
              ),
              VerveField(
                label: "password",
                textFieldType: TextFieldType.password,
                controller: widget.password,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Center(),
                  ),
                  Text(
                    'Forget Password?',
                    style: AppTextStyles.bodyExtraSmallMedium
                        .copyWith(color: Styles.textGray),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 45),
                    backgroundColor: Styles.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    print('Clicked');
                    Authentication.signInWithEmailandPassword(
                            widget.email.text, widget.password.text)
                        .then((value) {
                      FirebaseFirestore.instance
                          .collection("userInfo")
                          .doc(value!.uid)
                          .get()
                          .then((value) {
                        print("value is ${value.data()}");
                        UserModel user = UserModel.fromJson(value.data()!);
                        print("user model is ${user}");
                        UserDb.setUserInfo(user).then((value) =>
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => Wrapper())));
                      });
                    }).catchError((e) => ToastManager.showErrorToast(
                            context, 'Invalid Credentials'));
                  },
                  child: const Text('Login')),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  print('Clicked');
                  setState(() {
                    authMethodProvider.changeMethodTOSignup();
                  });
                },
                child: RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: AppTextStyles.bodyExtraSmall
                            .copyWith(color: Styles.textGray),
                        children: [
                      TextSpan(
                        text: ' Sign Up',
                        style: AppTextStyles.bodyExtraSmallMedium
                            .copyWith(color: Styles.primaryColor),
                      )
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
