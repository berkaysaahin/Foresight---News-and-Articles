import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/core/app_rounded_button.dart';

class HomeTopButtons extends StatefulWidget {
  final Function(String) onSearchTextChanged;
  final Function(String) onSearchSubmitted;
  const HomeTopButtons(
      {Key? key,
      required this.onSearchTextChanged,
      required this.onSearchSubmitted});

  @override
  State<HomeTopButtons> createState() => _HomeTopButtonsState();
}

class _HomeTopButtonsState extends State<HomeTopButtons> {
  bool _isSearchActive = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            AppRoundedButton(
              iconData: Icons.menu,
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox(
              width: 10,
            ),
            if (_isSearchActive)
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _isSearchActive = false;
                          _searchController.clear();
                          widget.onSearchTextChanged('');
                        });
                      },
                    ),
                  ),
                  onSubmitted: (query) {
                    widget.onSearchTextChanged(query);
                  },
                ),
              )
            else ...[
              const Spacer(),
              AppRoundedButton(
                iconData: Icons.search,
                onTap: () {
                  setState(() {
                    _isSearchActive = true;
                  });
                },
              ),
            ],
            const SizedBox(
              width: 10,
            ),
            AppRoundedButton(
              iconData: Icons.notifications_outlined,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
