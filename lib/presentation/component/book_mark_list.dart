import 'package:flutter/material.dart';

class Bookmark {
  final String title;
  final String time;

  Bookmark({required this.title, required this.time});
}

class BookmarkList extends StatelessWidget {
  final String headerTitle;
  final String? seeAllText;
  final List<Bookmark> bookmarks;

  const BookmarkList({
    super.key,
    this.headerTitle = "Bookmarks",
    this.seeAllText,
    required this.bookmarks,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER -----------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                headerTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontFamily: 'UniNeue',
                  color: Color(0xff4F4F4F),
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (seeAllText != null)
                Text(
                  seeAllText!,
                  style: const TextStyle(
                    color: Color(0xffF26B6C),
                    fontFamily: 'UniNeue',
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // ITEMS ------------------------------------------
          ...bookmarks.map((bookmark) => Column(
            children: [
              _bookmarkItem(title: bookmark.title, time: bookmark.time),
              _divider(),
            ],
          )),
        ],
      ),
    );
  }

  Widget _bookmarkItem({required String title, required String time}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.play_circle,
            color: Color(0xffF26B6C),
            size: 22,
          ),
          const SizedBox(width: 12),

          // TEXTS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:  TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 1,
      color: Colors.grey.withOpacity(0.2),
    );
  }
}
