import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:foresight_news_and_articles/core/main_page.dart";
import "package:foresight_news_and_articles/core/rectangle_rounded_button.dart";
import "package:foresight_news_and_articles/core/services/authentication.dart";
import "package:foresight_news_and_articles/features/home/widgets/form_field.dart";
import "package:foresight_news_and_articles/features/home/widgets/secondary_top_buttons.dart";
import "package:foresight_news_and_articles/features/home/widgets/side_bar.dart";
import "package:foresight_news_and_articles/features/profile/pages/signup_page.dart";
import "package:foresight_news_and_articles/theme/app_colors.dart";

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SecondaryTopButtons(
              pageTitle: 'Sign In',
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
                          Text(
                            "Login to Your Account",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 26,
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
                              final message = await AuthService().login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              if (message!.contains('Success')) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const MainPage(),
                                  ),
                                );
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
                                child: Text("Or Login With"),
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
                                      builder: (context) => const SignInPage(),
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
                                      builder: (context) => const SignInPage(),
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
                                "Don't have an account? ",
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Add your navigation logic here
                                  // For example:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()),
                                  );
                                },
                                child: const Text(
                                  "Sign up",
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
