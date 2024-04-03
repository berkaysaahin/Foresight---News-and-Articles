import 'package:flutter/material.dart';

class HomeHeading extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const HomeHeading({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 1, 20, 15),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
