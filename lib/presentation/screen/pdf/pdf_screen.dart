import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class PdfScreen extends StatefulWidget {
  final String pdfUrl;
  final String bookName;

  const PdfScreen({super.key, required this.pdfUrl, required this.bookName});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  String? localPath;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _downloadAndSavePdf();
  }

  Future<void> _downloadAndSavePdf() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/temp.pdf";

      final dio = Dio();
      final response = await dio.download(widget.pdfUrl, filePath);

      if (response.statusCode == 200) {
        setState(() {
          localPath = filePath;
          loading = false;
        });
      }
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.bookName)),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : localPath != null
          ? PDFView(filePath: localPath)
          : const Center(child: Text("PDF ochib bo‘lmadi")),
    );
  }
}
