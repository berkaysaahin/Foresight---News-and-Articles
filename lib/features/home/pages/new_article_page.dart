import "dart:io";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:foresight_news_and_articles/core/app_rounded_button.dart";
import "package:foresight_news_and_articles/core/rectangle_rounded_button.dart";
import "package:foresight_news_and_articles/core/utils/app_date_formatters.dart";
import "package:foresight_news_and_articles/features/home/widgets/side_bar.dart";
import "package:foresight_news_and_articles/theme/app_colors.dart";
import "package:image_picker/image_picker.dart";
import 'package:permission_handler/permission_handler.dart';

class NewArticlePage extends StatefulWidget {
  NewArticlePage({Key? key}) : super(key: key);

  @override
  State<NewArticlePage> createState() => _NewArticlePageState();
}

class _NewArticlePageState extends State<NewArticlePage> {
  final titleController = TextEditingController();

  final contentController = TextEditingController();

  String category = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  File? _selectedImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    _auth.authStateChanges().listen((User? user) {
      if (mounted) {
        setState(() {
          _currentUser = user;
        });
      }
    });
  }

  Future<void> _pickImage() async {
    if (await _requestPermission(Permission.photos)) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    var status = await permission.status;

    if (status.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result.isGranted) {
        return true;
      } else if (result.isPermanentlyDenied) {
        _showPermissionDeniedDialog();
      }
      return false;
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Permission Required'),
        content: const Text(
          'Storage permission is required to select an image. Please enable it in the settings.',
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Open Settings'),
            onPressed: () {
              openAppSettings();
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser != null) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: const SideBar(),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      AppRoundedButton(
                        iconData: Icons.menu,
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                      const SizedBox(
                        width: 17,
                      ),
                      Text(
                        "Post Your Article",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          height: 50.0,
                          width: 50.0,
                          color: AppColors.azureRadiance,
                          child: CircleAvatar(
                            child: _currentUser != null &&
                                    _currentUser!.photoURL != null
                                ? CircleAvatar(
                                    radius: 55,
                                    backgroundImage:
                                        NetworkImage(_currentUser!.photoURL!),
                                  )
                                : const Icon(
                                    Icons.person,
                                    size: 55,
                                    color: AppColors.porcelain,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Text(
                          _currentUser != null
                              ? _currentUser!.displayName ?? 'Anonymous'
                              : 'Loading...',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const Spacer(),
                      RectangleRoundedButton(
                        onTap: () async {
                          String formattedDate =
                              AppDateFormatters.mdY(DateTime.now());
                          CollectionReference collRef =
                              FirebaseFirestore.instance.collection("news");
                          String title = titleController.text.trim();
                          String content = contentController.text.trim();

                          if (title.isEmpty || content.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('All fields are required.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                          if (_selectedImage == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please select an image for your article.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          } else {
                            try {
                              String imageUrl = '';
                              if (_selectedImage != null) {
                                // Upload the image to Firebase Storage
                                String fileName =
                                    _selectedImage!.path.split('/').last;
                                Reference ref = FirebaseStorage.instance
                                    .ref()
                                    .child('images/$fileName');
                                UploadTask uploadTask =
                                    ref.putFile(_selectedImage!);
                                TaskSnapshot snapshot = await uploadTask;
                                imageUrl = await snapshot.ref.getDownloadURL();
                              }

                              // Add data to Firestore, including the image URL
                              await collRef.add({
                                "title": title,
                                "content": content,
                                "category": category,
                                "date": formattedDate,
                                "imageAsset": imageUrl,
                                "author": _currentUser?.displayName,
                                "authorImage": _currentUser?.photoURL
                                // URL of the uploaded image
                              });

                              // Clear text fields
                              titleController.clear();
                              contentController.clear();
                              imageUrl = "";
                              category = "";

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Article submitted successfully!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Failed to submit article: $error'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                            setState(() {});
                          }
                        },
                        buttonText: "Submit",
                        buttonColor: AppColors.athenasGray,
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    color: AppColors.white,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.porcelain,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      height: 180,
                      child: _selectedImage != null
                          ? Padding(
                              padding: const EdgeInsets.all(4),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0),
                                    ), // Set desired radius
                                    child: Image.file(
                                      _selectedImage!,
                                      height: 180,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    left: 8,
                                    child: Text(
                                      "Tap to change cover photo",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                        color: Colors
                                            .white, // Make text transparent
                                        shadows: [
                                          const Shadow(
                                            // Adjust offset values for desired outline thickness
                                            offset: Offset(-1, -1),
                                            color:
                                                Colors.black, // Outline color
                                            blurRadius:
                                                0.0, // No blur for sharp outline
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.image,
                                    size: 36,
                                    color: AppColors.osloGray,
                                  ), // You can change the icon and size as needed
                                  const SizedBox(
                                      width:
                                          8), // Adds space between the icon and the text
                                  Text(
                                    "Add Cover Photo",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: AppColors.osloGray,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    hintText: 'Select a category for your article',
                    fillColor: AppColors.porcelain,
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none // Border color when focused
                        ),
                    // Add an icon
                    // ... other InputDecoration properties ...
                  ),
                  value: category.isEmpty ? null : category,
                  items: <String>[
                    'Business',
                    'Politics',
                    'Science',
                    'Technology',
                    'Health',
                    'Education',
                    'Travel',
                    'Art',
                    'Sports',
                    'Books',
                    'Movies',
                    'Fashion',
                    'Dining',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      category = newValue ?? '';
                    });
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: AppColors.porcelain,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: titleController,
                            maxLines: 1,
                            minLines: 1,
                            decoration: const InputDecoration(
                              hintText:
                                  'Enter a compelling title for your article.',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.zero, // No top border radius
                                  bottom:
                                      Radius.zero, // No bottom border radius
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            color: AppColors.porcelain,
                            thickness: 3,
                          ),
                          TextField(
                            controller: contentController,
                            minLines: 8,
                            maxLines: null,
                            decoration: const InputDecoration(
                                focusColor: AppColors.osloGray,
                                hoverColor: AppColors.azureRadiance,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.zero, // No top border radius
                                    bottom:
                                        Radius.zero, // No bottom border radius
                                  ),
                                ),
                                hintText:
                                    'Write your article, include sections and paragraphs.',
                                contentPadding: EdgeInsets.only(
                                    top: 20.0, left: 10.0, right: 10.0),
                                alignLabelWithHint: true),
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
    } else {
      return const Center(
        child: Text("Log in to post your article"),
      );
    }
  }
}
