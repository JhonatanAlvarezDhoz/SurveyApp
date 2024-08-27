import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Manga Search App',
      home: MangaDexSearchPage(),
    );
  }
}

class MangaDexSearchPage extends StatefulWidget {
  const MangaDexSearchPage({super.key});

  @override
  _MangaDexSearchPageState createState() => _MangaDexSearchPageState();
}

class _MangaDexSearchPageState extends State<MangaDexSearchPage> {
  List<dynamic> _searchResults = [];
  final _searchController = TextEditingController();

  Future<void> _searchManga(String query) async {
    final response = await http.get(
      Uri.parse(
          'https://api.mangadex.org/manga?title=$query&availableTranslatedLanguage[]=es-la'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _searchResults = data['data'];
      });
    } else {
      throw Exception('Failed to load manga data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Búsqueda de Manga'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar manga',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchManga(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final manga = _searchResults[index];
                final attributes = manga['attributes'];
                final title = attributes['title']['es-la'] ??
                    attributes['title']['en'] ??
                    'Sin título disponible';
                final description = attributes['description']['es-la'] ??
                    attributes['description']['en'] ??
                    'Sin descripción disponible';

                return ListTile(
                  title: Text(title),
                  subtitle: Text(description,
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MangaDexDetailPage(mangaId: manga['id']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MangaDexDetailPage extends StatefulWidget {
  final String mangaId;

  const MangaDexDetailPage({super.key, required this.mangaId});

  @override
  _MangaDexDetailPageState createState() => _MangaDexDetailPageState();
}

class _MangaDexDetailPageState extends State<MangaDexDetailPage> {
  List<dynamic> chapters = [];
  num offset = 0;
  bool isLoading = false;
  bool hasMore = true;
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    _loadMoreChapters();
  }

  Future<void> _loadMoreChapters() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });
    log("offset: $offset");
    log("id: ${widget.mangaId}");
    final response = await http.get(
      Uri.parse(
          'https://api.mangadex.org/manga/${widget.mangaId}/feed?limit=15&offset=$offset&order[chapter]=${isAscending ? 'asc' : 'desc'}&translatedLanguage[]=es-la'),
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final newChapters = data['data'];

      setState(() {
        chapters.addAll(newChapters);
        offset += newChapters.length;
        isLoading = false;
        hasMore = newChapters.length == 15;
      });
    } else {
      setState(() {
        isLoading = false;
        hasMore = false;
      });

      throw Exception('Error al cargar los capítulos del manga');
    }
  }

  void _toggleOrder() {
    setState(() {
      isAscending = !isAscending;
      chapters.clear();
      offset = 0;
      hasMore = true;
    });
    _loadMoreChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Manga'),
        actions: [
          IconButton(
            icon: Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward),
            onPressed: _toggleOrder,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final chapter = chapters[index]['attributes'];
                final chapterNumber = chapter['chapter'] ?? 'Desconocido';
                final chapterTitle = chapter['title'] ?? 'Sin título';
                final language = chapter['translatedLanguage'];
                return ListTile(
                  title: Text('Capítulo $chapterNumber ($language)'),
                  subtitle: Text(chapterTitle),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MangaDexChapterPage(
                          chapterId: chapters[index]['id'],
                          chapters: chapters,
                          currentIndex: index,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          if (hasMore)
            ElevatedButton(
              onPressed: _loadMoreChapters,
              child: const Text('Cargar más capítulos'),
            ),
        ],
      ),
    );
  }
}

class MangaDexChapterPage extends StatefulWidget {
  final String chapterId;
  final List<dynamic> chapters;
  final int currentIndex;

  const MangaDexChapterPage({
    super.key,
    required this.chapterId,
    required this.chapters,
    required this.currentIndex,
  });

  @override
  _MangaDexChapterPageState createState() => _MangaDexChapterPageState();
}

class _MangaDexChapterPageState extends State<MangaDexChapterPage> {
  List<String> pages = [];
  bool isCascadeMode = false;

  @override
  void initState() {
    super.initState();
    _fetchChapterPages();
  }

  Future<void> _fetchChapterPages() async {
    final response = await http.get(
      Uri.parse('https://api.mangadex.org/at-home/server/${widget.chapterId}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final baseUrl = data['baseUrl'];
      final chapter = data['chapter'];
      final hash = chapter['hash'];
      final pageData = chapter['data'];
      setState(() {
        pages = pageData
            .map<String>((page) => '$baseUrl/data/$hash/$page')
            .toList();
      });
    } else {
      throw Exception('Error al cargar las páginas del capítulo');
    }
  }

  void _navigateToNextChapter() {
    final nextIndex = widget.currentIndex + 1;
    if (nextIndex < widget.chapters.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MangaDexChapterPage(
            chapterId: widget.chapters[nextIndex]['id'],
            chapters: widget.chapters,
            currentIndex: nextIndex,
          ),
        ),
      );
    }
  }

  void _navigateToPreviousChapter() {
    final previousIndex = widget.currentIndex - 1;
    if (previousIndex >= 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MangaDexChapterPage(
            chapterId: widget.chapters[previousIndex]['id'],
            chapters: widget.chapters,
            currentIndex: previousIndex,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Capítulo ${widget.chapters[widget.currentIndex]['attributes']['chapter']}'),
        actions: [
          IconButton(
            icon: Icon(isCascadeMode ? Icons.view_day : Icons.view_carousel),
            onPressed: () {
              setState(() {
                isCascadeMode = !isCascadeMode;
              });
            },
          ),
        ],
      ),
      body: pages.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : isCascadeMode
              ? ListView.builder(
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return Image.network(pages[index]);
                  },
                )
              : PageView.builder(
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return Image.network(pages[index]);
                  },
                ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.currentIndex > 0)
              ElevatedButton(
                onPressed: _navigateToPreviousChapter,
                child: const Text('Capítulo Anterior'),
              ),
            const Text(
              'Powered by MangaDex',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            if (widget.currentIndex < widget.chapters.length - 1)
              ElevatedButton(
                onPressed: _navigateToNextChapter,
                child: const Text('Siguiente Capítulo'),
              ),
          ],
        ),
      ),
    );
  }
}
