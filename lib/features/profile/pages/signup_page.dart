import "dart:io";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:foresight_news_and_articles/core/main_page.dart";
import "package:foresight_news_and_articles/core/rectangle_rounded_button.dart";
import "package:foresight_news_and_articles/core/services/authentication.dart";
import "package:foresight_news_and_articles/features/home/widgets/form_field.dart";
import "package:foresight_news_and_articles/features/home/widgets/secondary_top_buttons.dart";
import "package:foresight_news_and_articles/features/home/widgets/side_bar.dart";
import "package:foresight_news_and_articles/features/profile/pages/signin_page.dart";
import "package:foresight_news_and_articles/theme/app_colors.dart";
import "package:image_picker/image_picker.dart";

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SecondaryTopButtons(
              pageTitle: 'Sign Up',
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: Container(
                  color: AppColors.porcelain,
                  child: Padding(
                    padding: const EdgeInsets.all(48.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(children: [
                            Text(
                              "Create Your Account",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Spacer(),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: GestureDetector(
                                onTap: () async {
                                  final XFile? image = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (image == null) return;
                                  setState(() {
                                    _image = image;
                                  });
                                },
                                child: Container(
                                  height: 70.0,
                                  width: 70.0,
                                  color: AppColors.white,
                                  child: const Icon(
                                    CupertinoIcons.person_add_solid,
                                    color: AppColors.azureRadiance,
                                    size: 50.0,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 26,
                          ),
                          FormFieldSample(
                            controller: _usernameController,
                            hintText: "Full Name",
                            labelText: "Full Name",
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          FormFieldSample(
                            controller: _emailController,
                            hintText: "Email Address",
                            labelText: "Email Address",
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          FormFieldSample(
                            controller: _passwordController,
                            hintText: "Password",
                            labelText: "Password",
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          RectangleRoundedButton(
                            buttonIcon: FontAwesomeIcons.google,
                            buttonColor: AppColors.azureRadiance,
                            textColor: AppColors.white,
                            onTap: () async {
                              final message = await AuthService().registration(
                                email: _emailController.text,
                                password: _passwordController.text,
                                name: _usernameController.text,
                                photo: File(_image!.path),
                              );
                              if (message!.contains('Success')) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainPage()));
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                ),
                              );
                            },
                          ),
                          const Row(
                            children: [
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text("Or Register With"),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RectangleRoundedButton(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUpPage(),
                                    ),
                                  );
                                },
                                buttonIcon: FontAwesomeIcons.google,
                                buttonColor: AppColors.azureRadiance,
                                textColor: AppColors.white,
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              RectangleRoundedButton(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUpPage(),
                                    ),
                                  );
                                },
                                buttonIcon: FontAwesomeIcons.google,
                                buttonColor: AppColors.azureRadiance,
                                textColor: AppColors.white,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account? ",
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Add your navigation logic here
                                  // For example:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInPage()),
                                  );
                                },
                                child: const Text(
                                  "Sign in",
                                  style:
                                      TextStyle(color: AppColors.azureRadiance),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
