import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import '../chapter/chapter_screen.dart';
import '../home/home_screen.dart';
import '../pdf/pdf_screen.dart';


class NowPlayingScreen extends StatefulWidget {
  final Book book;

  const NowPlayingScreen({super.key, required this.book});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  late AudioPlayer _player;
  late ScrollController _scrollController;

  Duration _audioDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;

  int currentChapter = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _player = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    await _setAudio(currentChapter);

    _player.durationStream.listen((duration) {
      if (duration != null) setState(() => _audioDuration = duration);
    });

    _player.positionStream.listen((position) {
      setState(() => _currentPosition = position);
    });
  }

  Future<void> _setAudio(int chapterIndex) async {
    await _player.setUrl(widget.book.audios[chapterIndex]);
    // _player.play();
  }

  @override
  void dispose() {
    _player.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _formatTime(Duration d) {
    final hours = d.inHours;
    final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');

    if (hours > 0) {
      return "$hours:$minutes:$seconds";
    } else {
      return "$minutes:$seconds";
    }
  }

  void _nextChapter() {
    if (currentChapter < widget.book.audios.length - 1) {
      currentChapter++;
      _setAudio(currentChapter);
      setState(() {});
    }
  }

  void _prevChapter() {
    if (currentChapter > 0) {
      currentChapter--;
      _setAudio(currentChapter);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              height: 225,
              child: Image.asset(
                'assets/images/half_circle.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              title: const Text(
                'Now Playing',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfScreen(pdfUrl: widget.book.pdfPath.toString(),bookName: widget.book.title),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 195,
                      height: 275,
                      child: Image.asset(
                        widget.book.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Chapter - ${(currentChapter + 1).toString().padLeft(2, '0')}",
                    style: const TextStyle(fontSize: 14, color: Color(0xffF26B6C)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.book.title,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    widget.book.author,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          _formatTime(_currentPosition),
                          style: const TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 3,
                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4),
                              activeTrackColor: Colors.red,
                              inactiveTrackColor: Colors.grey.shade300,
                              thumbColor: Colors.red,
                            ),
                            child: Slider(
                              value: _currentPosition.inSeconds.toDouble(),
                              min: 0,
                              max: _audioDuration.inSeconds.toDouble(),
                              onChanged: (value) {
                                _player.seek(Duration(seconds: value.toInt()));
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatTime(_audioDuration),
                          style: const TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: _prevChapter,
                          child: const Icon(Icons.skip_previous_rounded, size: 32),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            final newPos = _currentPosition - Duration(seconds: 10);
                            _player.seek(newPos < Duration.zero ? Duration.zero : newPos);
                          },
                          child: const Icon(Icons.fast_rewind_rounded, size: 32),
                        ),
                        const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            _player.playing ? _player.pause() : _player.play();
                            setState(() {});
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xffFDE8E8),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                _player.playing ? Icons.pause : Icons.play_arrow,
                                color: const Color(0xffF26B6C),
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            final newPos = _currentPosition + Duration(seconds: 10);
                            if (newPos < _audioDuration) {
                              _player.seek(newPos);
                            }
                          },
                          child: const Icon(Icons.fast_forward_rounded, size: 32),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: _nextChapter,
                          child: const Icon(Icons.skip_next_rounded, size: 32),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/moon.png", width: 18, height: 21),
                      const SizedBox(width: 40),
                      Image.asset("assets/images/loop.png", width: 18, height: 21),
                      const SizedBox(width: 40),
                      Image.asset("assets/images/bookmark.png", width: 18, height: 21),
                    ],
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ChapterBottomSheet(
                          book: widget.book,
                          currentChapter: currentChapter,
                          currentPosition: _currentPosition,
                          totalDuration: _audioDuration,
                          audioPlayer: _player,
                          onChapterTap: (index) {
                            setState(() => currentChapter = index);
                            _setAudio(currentChapter);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 84,
                      decoration: const BoxDecoration(
                        color: Color(0xffFDE8E8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.keyboard_double_arrow_up, color: Color(0xffF26B6C), size: 20),
                          SizedBox(height: 8),
                          Text(
                            "CHAPTER",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xffF26B6C),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}