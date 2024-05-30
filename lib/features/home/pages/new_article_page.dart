import "dart:io";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:foresight_news_and_articles/core/app_rounded_button.dart";
import "package:foresight_news_and_articles/core/rectangle_rounded_button.dart";
import "package:foresight_news_and_articles/core/utils/app_date_formatters.dart";
import "package:foresight_news_and_articles/dummy.dart";
import "package:foresight_news_and_articles/features/home/widgets/side_bar.dart";
import "package:foresight_news_and_articles/theme/app_colors.dart";
import "package:image_picker/image_picker.dart";

class NewArticlePage extends StatefulWidget {
  NewArticlePage({Key? key}) : super(key: key);

  @override
  State<NewArticlePage> createState() => _NewArticlePageState();
}

class _NewArticlePageState extends State<NewArticlePage> {
  final titleController = TextEditingController();

  final contentController = TextEditingController();

  final categoryController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String authorImageAssetPath = newsrItems[4]['authorImageAssetPath']!;
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
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        color: AppColors.azureRadiance,
                        child: Image.asset(
                          authorImageAssetPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Text(
                        "Dave Doe",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const Spacer(),
                    RectangleRoundedButton(
                      onTap: () {
                        String formattedDate =
                            AppDateFormatters.mdY(DateTime.now());
                        CollectionReference collRef =
                            FirebaseFirestore.instance.collection("news");
                        String title = titleController.text.trim();
                        String content = contentController.text.trim();
                        String category = categoryController.text.trim();

                        if (title.isEmpty ||
                            content.isEmpty ||
                            category.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('All fields are required.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        if (title.isNotEmpty &&
                            content.isNotEmpty &&
                            category.isNotEmpty) {
                          collRef.add({
                            "title": title,
                            "content": content,
                            "category": category,
                            "date": formattedDate,
                            "imageAsset": _selectedImage,
                          }).then((_) {
                            titleController.clear();
                            contentController.clear();
                            categoryController.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Article submitted successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Failed to submit article: $error'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          });
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
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    height: 100,
                    child: Center(
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
                          if (_selectedImage != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Image.file(
                                _selectedImage!,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
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
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: titleController,
                          maxLines: 1,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText:
                                'Enter a compelling title for your article.',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.zero, // No top border radius
                                bottom: Radius.zero, // No bottom border radius
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: AppColors.porcelain,
                          thickness: 3,
                        ),
                        TextField(
                          controller: contentController,
                          minLines: 8,
                          maxLines: null,
                          decoration: InputDecoration(
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
                        TextField(
                          controller: categoryController,
                          maxLines: 1,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Select a category for your article.',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.zero, // No top border radius
                                bottom: Radius.zero, // No bottom border radius
                              ),
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