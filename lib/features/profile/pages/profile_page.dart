import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:foresight_news_and_articles/core/app_rounded_button.dart";
import "package:foresight_news_and_articles/core/rectangle_rounded_button.dart";
import "package:foresight_news_and_articles/features/home/widgets/side_bar.dart";
import "package:foresight_news_and_articles/features/profile/pages/signin_page.dart";
import "package:foresight_news_and_articles/theme/app_colors.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    _user = _auth.currentUser;
    if (_user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Navigate to SignInPage if user is not logged in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInPage(),
          ),
        );
      });
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    setState(() {
      _user = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      color: AppColors.porcelain,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.white,
                              radius: 55,
                              child: _user?.photoURL != null
                                  ? CircleAvatar(
                                      radius: 55,
                                      backgroundImage:
                                          NetworkImage(_user!.photoURL!),
                                    )
                                  : const Icon(
                                      Icons.person,
                                      size: 55,
                                      color: AppColors.porcelain,
                                    ),
                            ),
                            const Positioned(
                              bottom: 1.0, // Adjust for desired position
                              right: 1.0, // Adjust for desired position
                              child: CircleAvatar(
                                backgroundColor: AppColors.azureRadiance,
                                radius: 16,
                                child: Icon(
                                  CupertinoIcons
                                      .photo_camera, // Replace with your desired icon
                                  color: Colors.white, // Adjust color as needed
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 15,
                    child: AppRoundedButton(
                      iconData: Icons.menu,
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  ),
                  Positioned(
                    left: 92,
                    top: 28,
                    child: Text(
                      "Profile",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                color: AppColors.porcelain,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        ListTile(
                          title: const Text(
                            "Name",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: _user != null
                              ? Text(_user!.displayName ?? 'No name found')
                              : const Text(''),
                          trailing:
                              const Icon(Icons.edit, color: AppColors.osloGray),
                        ),
                        const Divider(
                          height: 40,
                          color: AppColors.porcelain,
                          thickness: 3,
                        ),
                        ListTile(
                          title: const Text(
                            "Email",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: _user != null
                              ? Text(_user!.email ?? 'No email found')
                              : const Text(''),
                          trailing:
                              const Icon(Icons.edit, color: AppColors.osloGray),
                        ),
                        const Divider(
                          height: 40,
                          color: AppColors.porcelain,
                          thickness: 3,
                        ),
                        const ListTile(
                          title: Text(
                            "Password",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "",
                          ),
                          trailing: Icon(Icons.edit, color: AppColors.osloGray),
                        ),
                        const Divider(
                          height: 40,
                          color: AppColors.porcelain,
                          thickness: 3,
                        ),
                        const ListTile(
                          title: Text(
                            "Country/Region",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "",
                          ),
                          trailing: Icon(Icons.edit, color: AppColors.osloGray),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: RectangleRoundedButton(
                              onTap: () async {
                                await _signOut();
                                if (_user == null) {
                                  // Optionally show a dialog or snackbar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('You have been signed out.'),
                                    ),
                                  );
                                }
                              },
                              buttonText: "Sign Out",
                              buttonColor: AppColors.athenasGray,
                            ),
                          ),
                        ),
                      ],
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
