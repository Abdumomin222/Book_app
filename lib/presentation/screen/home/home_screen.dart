import 'dart:math';
import 'package:flutter/material.dart';
import '../play/now_playing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Book> books = const [

    Book(
      id: 'one_way',
      title: 'One Way',
      author: 'Unknown',
      image: 'assets/images/img.png',
      audios: [
        'https://qnruszdpdbaqxrkkvfxz.supabase.co/storage/v1/object/public/book_audios/01.%20Hijron%20kunlari%20(Ufq_%202-kitob).mp3',
        'https://qnruszdpdbaqxrkkvfxz.supabase.co/storage/v1/object/public/book_audios/02.%20Hijron%20kunlari%20(Ufq_%202-kitob).mp3',
      ],
      pdfPath: 'https://iwvhxjuglxwkocplaqbu.supabase.co/storage/v1/object/sign/pdf/One_Way_Ticket.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV82YmM2NjkyYi1kNzM0LTRmMjMtOWNiNi1mZGUzOWQ3NDQ1NmQiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwZGYvT25lX1dheV9UaWNrZXQucGRmIiwiaWF0IjoxNzY1NDU1OTcxLCJleHAiOjE3OTY5OTE5NzF9.0yRWtBW062JX1lVQcBdQnJ2lCloZh52cQXhJk111lLQ',
    ),

    Book(
      id: 'hijron',
      title: 'Hijron Kunlari',
      author: 'Unknown',
      image: 'assets/images/hijron_kunlari.png',
      audios: [
        'https://qnruszdpdbaqxrkkvfxz.supabase.co/storage/v1/object/public/book_audios/01.%20Hijron%20kunlari%20(Ufq_%202-kitob).mp3',
        'https://qnruszdpdbaqxrkkvfxz.supabase.co/storage/v1/object/public/book_audios/02.%20Hijron%20kunlari%20(Ufq_%202-kitob).mp3',
      ],
      pdfPath: 'https://iwvhxjuglxwkocplaqbu.supabase.co/storage/v1/object/sign/pdf/said_ahmad._hijron_kunlari_ikkinchi_k.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV82YmM2NjkyYi1kNzM0LTRmMjMtOWNiNi1mZGUzOWQ3NDQ1NmQiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwZGYvc2FpZF9haG1hZC5faGlqcm9uX2t1bmxhcmlfaWtraW5jaGlfay5wZGYiLCJpYXQiOjE3NjU0NTU5ODksImV4cCI6MTc5Njk5MTk4OX0.IhCBa2zu-TLpo3u6WBPWsOjogZQ7PyxdOPy5NgBJ5Wc',
    ),

    Book(
      id: 'saodat_asri',
      title: 'Soadat Asri Qissalari',
      author: 'Unknown',
      image: 'assets/images/saodat_asri.png',
      audios: [
        'https://qnruszdpdbaqxrkkvfxz.supabase.co/storage/v1/object/public/book_audios/001.%20Al-Kimyogar.mp3',
        'https://qnruszdpdbaqxrkkvfxz.supabase.co/storage/v1/object/public/book_audios/002.%20Al-Kimyogar.mp3',
        'https://qnruszdpdbaqxrkkvfxz.supabase.co/storage/v1/object/public/book_audios/003.%20Al-Kimyogar.mp3',
        'https://qnruszdpdbaqxrkkvfxz.supabase.co/storage/v1/object/public/book_audios/004.%20Al-Kimyogar.mp3',
        'https://qnruszdpdbaqxrkkvfxz.supabase.co/storage/v1/object/public/book_audios/005.%20Al-Kimyogar.mp3',
        'https://qnruszdpdbaqxrkkvfxz.supabase.co/storage/v1/object/public/book_audios/006.%20Al-Kimyogar.mp3',
      ],
      pdfPath: 'https://iwvhxjuglxwkocplaqbu.supabase.co/storage/v1/object/sign/pdf/Saodat%20asri%20qissalari.%201-kitob.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV82YmM2NjkyYi1kNzM0LTRmMjMtOWNiNi1mZGUzOWQ3NDQ1NmQiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwZGYvU2FvZGF0IGFzcmkgcWlzc2FsYXJpLiAxLWtpdG9iLnBkZiIsImlhdCI6MTc2NTQ1NjAwOSwiZXhwIjoxNzk2OTkyMDA5fQ.RtzplYNizduFhXqnB45rBKvtw7AWgCIid88spHhMbFw',
    ),

    Book(
      id: 'molhona',
      title: 'Molxona',
      author: 'Jorj Oruell',
      image: 'assets/images/molhona.png',
      audios: [
        'https://qnruszdpdbaqxrkkvfxz.supabase.co/storage/v1/object/public/book_audios/Audiokitob%20%20Jorj%20Oruell%20%20Molxona%20%2012%20-%20bob.mp3',
      ],
      pdfPath: 'https://iwvhxjuglxwkocplaqbu.supabase.co/storage/v1/object/sign/pdf/Molxona%20Jorj%20Oruzel%20(@AniKitoblar).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV82YmM2NjkyYi1kNzM0LTRmMjMtOWNiNi1mZGUzOWQ3NDQ1NmQiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwZGYvTW9seG9uYSBKb3JqIE9ydXplbCAoQEFuaUtpdG9ibGFyKS5wZGYiLCJpYXQiOjE3NjU0NTU5NDUsImV4cCI6MTc5Njk5MTk0NX0.SdE6DQLH70LBVscu3NjEA8LZPsqwqoAVpos_xfu2hA4',
    ),

    Book(
      id: 'yosh_bola',
      title: 'Yosh bola demang ularni',
      author: 'Adem Gunesh',
      image: 'assets/images/img_1.png',
      audios: [
        'https://iwvhxjuglxwkocplaqbu.supabase.co/storage/v1/object/public/Book/1-qism%20Yosh%20bola%20demang%20ularni.mp3',
        'https://iwvhxjuglxwkocplaqbu.supabase.co/storage/v1/object/public/Book/2-qism%20Yosh%20bola%20demang%20ularni.mp3',
        'https://iwvhxjuglxwkocplaqbu.supabase.co/storage/v1/object/public/Book/4-qism%20Yosh%20bola%20demang%20ularni.mp3',
      ],
      pdfPath: 'https://iwvhxjuglxwkocplaqbu.supabase.co/storage/v1/object/sign/pdf/Molxona%20Jorj%20Oruzel%20(@AniKitoblar).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV82YmM2NjkyYi1kNzM0LTRmMjMtOWNiNi1mZGUzOWQ3NDQ1NmQiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwZGYvTW9seG9uYSBKb3JqIE9ydXplbCAoQEFuaUtpdG9ibGFyKS5wZGYiLCJpYXQiOjE3NjU0NTU5NDUsImV4cCI6MTc5Njk5MTk0NX0.SdE6DQLH70LBVscu3NjEA8LZPsqwqoAVpos_xfu2hA4',
    ),

    Book(
      id: 'gazablanma',
      title: 'Gazablanma',
      author: 'Dr. Oiz Qarniy',
      image: 'assets/images/img_2.png',
      audios: [
        "https://iwvhxjuglxwkocplaqbu.supabase.co/storage/v1/object/public/Book/3-qism%20G'azablanma.mp3",
        "https://iwvhxjuglxwkocplaqbu.supabase.co/storage/v1/object/public/Book/4-qism%20G'azablanma.mp3",
        "https://iwvhxjuglxwkocplaqbu.supabase.co/storage/v1/object/public/Book/5-qism%20G'azablanma.mp3",
      ],
      pdfPath: 'https://iwvhxjuglxwkocplaqbu.supabase.co/storage/v1/object/sign/pdf/Molxona%20Jorj%20Oruzel%20(@AniKitoblar).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV82YmM2NjkyYi1kNzM0LTRmMjMtOWNiNi1mZGUzOWQ3NDQ1NmQiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwZGYvTW9seG9uYSBKb3JqIE9ydXplbCAoQEFuaUtpdG9ibGFyKS5wZGYiLCJpYXQiOjE3NjU0NTU5NDUsImV4cCI6MTc5Njk5MTk0NX0.SdE6DQLH70LBVscu3NjEA8LZPsqwqoAVpos_xfu2hA4',
    ),

    Book(
      id: 'yashamoq',
      title: 'Yashamoq Sokinlik Istar',
      author: 'Unknown',
      image: 'assets/images/yashamoq.png',
      audios: [
        'https://qnruszdpdbaqxrkkvfxz.supabase.co/storage/v1/object/public/book_audios/Yashamoq%20sokinlik%20istar%20(25-26-qism).mp3',
        'https://qnruszdpdbaqxrkkvfxz.supabase.co/storage/v1/object/public/book_audios/Yashamoq%20sokinlik%20istar%20(31-32-qism).mp3',
        'https://qnruszdpdbaqxrkkvfxz.supabase.co/storage/v1/object/public/book_audios/Yashamoq%20sokinlik%20istar%20(35-36-qism).mp3',
      ],
      pdfPath: 'https://iwvhxjuglxwkocplaqbu.supabase.co/storage/v1/object/sign/pdf/Molxona%20Jorj%20Oruzel%20(@AniKitoblar).pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV82YmM2NjkyYi1kNzM0LTRmMjMtOWNiNi1mZGUzOWQ3NDQ1NmQiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwZGYvTW9seG9uYSBKb3JqIE9ydXplbCAoQEFuaUtpdG9ibGFyKS5wZGYiLCJpYXQiOjE3NjU0NTU5NDUsImV4cCI6MTc5Njk5MTk0NX0.SdE6DQLH70LBVscu3NjEA8LZPsqwqoAVpos_xfu2hA4',
    ),


  ];

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
          'Explore',
          style: TextStyle(
            color: Color(0xffF26B6C),
            fontSize: 20,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'New Releases Book',
                    style: TextStyle(
                      fontSize: 20,
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: GestureDetector(
                      onTap: () {
                        if (books[index].audios.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NowPlayingScreen(book: books[index]),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${books[index].title} uchun audio yo\'q')),
                          );
                        }
                      },
                      child: _bookCard(books[index].image),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 20,
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
              height: 60,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _categoryChip('Thriller', getRandomColor(), getRandomTextColor()),
                    const SizedBox(width: 12),
                    _categoryChip('Suspense', getRandomColor(), getRandomTextColor()),
                    const SizedBox(width: 12),
                    _categoryChip('Humour', getRandomColor(), getRandomTextColor()),
                    const SizedBox(width: 12),
                    _categoryChip('Romance', getRandomColor(), getRandomTextColor()),
                    const SizedBox(width: 12),
                    _categoryChip('Science', getRandomColor(), getRandomTextColor()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Featured Books',
                    style: TextStyle(
                      fontSize: 20,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 6,
                mainAxisSpacing: 8,
                childAspectRatio: 0.70,
                children: List.generate(
                  books.length,
                      (index) => GestureDetector(
                    onTap: () {
                      if (books[index].audios.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NowPlayingScreen(book: books[index]),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${books[index].title} uchun audio yo\'q')),
                        );
                      }
                    },
                    child: _bookCard(books[index].image),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget _bookCard(String imagePath) {
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

  static Widget _categoryChip(String label, Color bgColor, Color textColor) {
    return Container(
      height: 50,
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
class Book {
  final String id;
  final String title;
  final String author;
  final String image;
  final List<String> audios;
  final String? pdfPath;


  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.image,
    required this.audios,
    required this.pdfPath,
  });
}