import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../home/home_screen.dart';

class ChapterBottomSheet extends StatelessWidget {
  final Book book;
  final int currentChapter;
  final Duration currentPosition;
  final Duration totalDuration;
  final AudioPlayer audioPlayer;
  final Function(int) onChapterTap;

  const ChapterBottomSheet({
    super.key,
    required this.book,
    required this.currentChapter,
    required this.currentPosition,
    required this.totalDuration,
    required this.audioPlayer,
    required this.onChapterTap,
  });

  String _formatTime(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      _formatTime(currentPosition),
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
                          value: currentPosition.inSeconds.toDouble(),
                          min: 0,
                          max: totalDuration.inSeconds.toDouble() > 0
                              ? totalDuration.inSeconds.toDouble()
                              : 1,
                          onChanged: (value) {
                            audioPlayer.seek(Duration(seconds: value.toInt()));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatTime(totalDuration),
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.skip_previous_rounded, size: 32),
                    const SizedBox(width: 10),
                    const Icon(Icons.fast_rewind_rounded, size: 32),
                    const SizedBox(width: 30),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xffFDE8E8),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          audioPlayer.playing ? Icons.pause : Icons.play_arrow,
                          color: const Color(0xffF26B6C),
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    const Icon(Icons.fast_forward_rounded, size: 32),
                    const SizedBox(width: 10),
                    const Icon(Icons.skip_next_rounded, size: 32),
                  ],
                ),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "CHAPTER",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xffF26B6C),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: book.audios.length,
                  itemBuilder: (context, index) {
                    bool isSelected = index == currentChapter;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: GestureDetector(
                        onTap: () => onChapterTap(index),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xffF26B6C)
                                    : const Color(0xffFDE8E8),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.book_outlined,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xffF26B6C),
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Chapter ${(index + 1).toString().padLeft(2, '0')} - ${book.title}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "20 minutes",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}