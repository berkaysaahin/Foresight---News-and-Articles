import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/features/home/widgets/single_news_item_header_delegate.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class SingleNewsItemPage extends StatefulWidget {
  final String title;
  final String content;
  final String author;
  final String category;
  final String authorImageAssetPath;
  final String imageAssetPath;
  final String date;
  final bool isBookmarked;
  const SingleNewsItemPage(
      {super.key,
      required this.title,
      required this.content,
      required this.author,
      required this.category,
      required this.authorImageAssetPath,
      required this.imageAssetPath,
      required this.date,
      required this.isBookmarked});

  @override
  State<SingleNewsItemPage> createState() => _SingleNewsItemPageState();
}

class _SingleNewsItemPageState extends State<SingleNewsItemPage> {
  double _borderRadiusMultiplier = 1;
  bool isBookmarked = false;
  String? bookmarkId;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // Initialize local isBookmarked state from passed data
    isBookmarked = widget.isBookmarked;
    _getBookmarkId(); // Get the bookmark ID if it exists
  }

  Future<void> _getBookmarkId() async {
    if (user != null) {
      try {
        QuerySnapshot querySnapshot = await _firestore
            .collection('bookmarks')
            .where('newsId', isEqualTo: widget.title)
            .where('userId', isEqualTo: user!.uid)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          setState(() {
            bookmarkId = querySnapshot.docs.first.id;
            isBookmarked = true;
          });
        }
      } catch (e) {
        print("Error getting bookmark ID: $e");
      }
    }
  }

  void toggleBookmark() async {
    setState(() {
      isBookmarked = !isBookmarked;
    });
    if (user != null) {
      try {
        if (isBookmarked) {
          DocumentReference bookmarkRef =
              _firestore.collection('bookmarks').doc();
          bookmarkId = bookmarkRef.id;
          await bookmarkRef.set({
            'newsId': widget.title,
            'userId': user!.uid,
            'title': widget.title,
            'author': widget.author,
            'category': widget.category,
            'isBookmarked': true,
            'imageAsset': widget.imageAssetPath,
            'content': widget.content,
            'date': widget.date,
            'authorImage': widget.authorImageAssetPath,
          });
        } else if (bookmarkId != null) {
          await _firestore.collection('bookmarks').doc(bookmarkId).delete();
          bookmarkId = null;
        }
      } catch (e) {
        print("Error updating bookmark: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final maxScreenSizeHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SingleNewsItemHeaderDelegate(
              borderRadiusAnimationValue: (value) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _borderRadiusMultiplier = value;
                  });
                });
              },
              isBookmarked: isBookmarked,
              onBookmarkToggle: toggleBookmark,
              title: widget.title,
              category: widget.category,
              date: widget.date,
              imageAssetPath: widget.imageAssetPath,
              minExtent: topPadding + 56,
              maxExtent: maxScreenSizeHeight / 2,
              topPadding: topPadding,
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: AnimatedContainer(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(16 * _borderRadiusMultiplier),
                color: AppColors.white,
              ),
              duration: const Duration(milliseconds: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.author,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(widget.content),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
