import 'dart:math';
import 'package:flutter/material.dart';

import '../../component/book_mark_list.dart';
import '../home/home_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();

    Color getRandomColor() => Colors.primaries[random.nextInt(Colors.primaries.length)];
    Color getRandomTextColor() => Colors.primaries[random.nextInt(Colors.primaries.length)];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Library',
          style: TextStyle(
            color: Color(0xffF26B6C),
            fontSize: 20,
            fontFamily: 'UniNeue',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // New Releases
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'New Releases Book',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'UniNeue',
                      fontWeight: FontWeight.w700,
                      color: Color(0xff4F4F4F),
                    ),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                      color: Color(0xffF26B6C),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  bookCard('assets/images/img_book_1.png'),
                  const SizedBox(width: 5),
                  bookCard('assets/images/img_book_2.png'),
                  const SizedBox(width: 5),
                  bookCard('assets/images/img_book_1.png'),
                  const SizedBox(width: 5),
                  bookCard('assets/images/img_book_2.png'),
                  const SizedBox(width: 5),
                  bookCard('assets/images/img_book_2.png'),
                  const SizedBox(width: 5),
                  bookCard('assets/images/img_book_1.png'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            BookmarkList(
              headerTitle: "Playlists",
              seeAllText: "See All",
              bookmarks: [
                Bookmark(title: "Chapter 01 - Intro", time: "2:00 - 5:00"),
                Bookmark(title: "Chapter 02 - Basics", time: "5:10 - 10:00"),
                Bookmark(title: "Chapter 03 - Advanced", time: "10:10 - 15:00"),
              ],
            ),
            BookmarkList(
              headerTitle: "My Bookmarks",
              seeAllText: "See All",
              bookmarks: [
                Bookmark(title: "Chapter 01 - Intro", time: "2:00 - 5:00"),
                Bookmark(title: "Chapter 02 - Basics", time: "5:10 - 10:00"),
                Bookmark(title: "Chapter 03 - Advanced", time: "10:10 - 15:00"),
              ],
            ),
            BookmarkList(
              headerTitle: "Most Played",
              seeAllText: "See All",
              bookmarks: [
                Bookmark(title: "Chapter 01 - Intro", time: "2:00 - 5:00"),
                Bookmark(title: "Chapter 02 - Basics", time: "5:10 - 10:00"),
                Bookmark(title: "Chapter 03 - Advanced", time: "10:10 - 15:00"),
              ],
            ),
            SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }
}

Widget bookCard(String imagePath) {
  return Container(
    width: 115,
    height: 145,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(imagePath, fit: BoxFit.cover),
    ),
  );
}

