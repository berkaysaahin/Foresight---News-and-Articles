import "dart:io";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:foresight_news_and_articles/core/app_rounded_button.dart";
import "package:foresight_news_and_articles/core/rectangle_rounded_button.dart";
import "package:foresight_news_and_articles/core/services/authentication.dart";
import "package:foresight_news_and_articles/features/home/widgets/side_bar.dart";
import "package:foresight_news_and_articles/features/profile/pages/signin_page.dart";
import "package:foresight_news_and_articles/theme/app_colors.dart";
import "package:image_picker/image_picker.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInPage(),
          ),
        );
      });
    }
    setState(() {});
  }

  Future<void> _pickAndUploadImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File photo = File(pickedFile.path);
        try {
          // Make sure _user is not null
          if (_user != null) {
            String photoURL =
                await _authService.uploadProfilePicture(_user!.uid, photo);
            await _user!.updateProfile(photoURL: photoURL);
            await _user!.reload();
            // Fetch the updated user information
            _user = _auth.currentUser;
            setState(() {});
          } else {
            throw FirebaseAuthException(
                code: 'user-not-found', message: 'User is not authenticated.');
          }
        } catch (e) {
          print('Failed to update profile picture: $e');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Failed to update profile picture. Please try again.')),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No image selected.')),
          );
        }
      }
    } catch (e) {
      print('Failed to pick image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to pick image. Please try again.')),
        );
      }
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
                        child: GestureDetector(
                          onTap: () {
                            _pickAndUploadImage();
                          },
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
                                    color:
                                        Colors.white, // Adjust color as needed
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                          onTap: () {
                            String currentUsername =
                                _user?.displayName ?? 'No name found';
                            TextEditingController textEditingController =
                                TextEditingController(text: currentUsername);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Edit Username'),
                                  content: TextField(
                                    controller: textEditingController,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter your new username',
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Close the dialog
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Get the new username from the text field
                                        String newUsername =
                                            textEditingController.text;

                                        // Get the UID of the current user
                                        String uid = FirebaseAuth
                                            .instance.currentUser!.uid;

                                        // Call the changeUsername method with the new username
                                        AuthService()
                                            .updateUsername(uid, newUsername);

                                        setState(() {});

                                        Navigator.pop(context);

                                        // Close the dialog
                                      },
                                      child: const Text('Save'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
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
                          onTap: () {
                            try {
                              String currentEmail =
                                  _user?.email ?? 'No email found';
                              TextEditingController textEditingController =
                                  TextEditingController(text: currentEmail);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Edit email'),
                                    content: TextField(
                                      controller: textEditingController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your new email',
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context); // Close the dialog
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Get the new username from the text field
                                          String newEmail =
                                              textEditingController.text;

                                          // Get the UID of the current user
                                          String uid = FirebaseAuth
                                              .instance.currentUser!.uid;

                                          // Call the changeUsername method with the new username
                                          AuthService()
                                              .updateEmail(uid, newEmail);

                                          Navigator.pop(context);

                                          // Close the dialog
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } catch (e) {
                              print("error");
                            }
                          },
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
