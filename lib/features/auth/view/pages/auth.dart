import 'package:flutter/material.dart';
import 'package:salon_app/components/textfields.dart';
import 'package:salon_app/features/auth/view/widgets/signin_options.dart';
import 'package:salon_app/utils/ui/styles.dart';
import 'package:salon_app/utils/ui/text.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
              child: const Text(
                'Let\'s get you Login!',
                style: TextStyle(
                  color: Colors.white,
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
            Positioned(
              bottom: 30,
              left: 22,
              right: 22,
              child: Container(
                height: size.height * 0.5 + 40,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 23),
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
                      const VerveField(
                        label: "E-mail address",
                        textFieldType: TextFieldType.email,
                      ),
                      const VerveField(
                        label: "password",
                        textFieldType: TextFieldType.password,
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
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 45),
                            backgroundColor: Styles.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Login')),
                      const SizedBox(
                        height: 12,
                      ),
                      RichText(
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
                          ]))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
