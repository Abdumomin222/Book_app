import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> items = [
    "Bangla audio book 2021",
    "stiphon king audiob books",
    "top audio books in 2020",
    "chapter 2 - mr marcedes by stephen king",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 🔝 CUSTOM TOP BAR
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              // 🔍 Search Input
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "search books",
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: Icon(Icons.search, color: Colors.grey),
                      prefixIcon: Icon(Icons.arrow_back, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),)
      ),

      // 📜 HISTORY LIST
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.grey),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      items[index],
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                   Image.asset("assets/images/ic_share.png",
                      height: 16, color: Colors.grey),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
