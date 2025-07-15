import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import 'chat_page.dart';
import '../providers/chat_provider.dart';

class LibraryPage extends ConsumerStatefulWidget {
  const LibraryPage({super.key});

  @override
  LibraryPageState createState() => LibraryPageState();
}

class LibraryPageState extends ConsumerState<LibraryPage> {
  final List<String> _fallbackBookCovers = [
    'assets/images/book-red.png',
    'assets/images/book-grey.png',
    'assets/images/book-navy.png',
    'assets/images/book-black.png',
    'assets/images/book-green.png',
    'assets/images/book-blue.png',
    'assets/images/book-white.png',
  ];

  final Random _random = Random();

  String _getFallbackCover() {
    return _fallbackBookCovers[_random.nextInt(_fallbackBookCovers.length)];
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final chatNotifier = ref.read(chatProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Calibre-AI Library',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Builder(
        builder: (context) {
          if (chatState.isLoading && chatState.documents.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }

          return Column(
            children: [
              if (chatState.isLoading)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Ingesting document, please wait...',
                        style: GoogleFonts.inter(color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      const LinearProgressIndicator(
                        backgroundColor: Colors.black12,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              if (chatState.documents.isEmpty && !chatState.isLoading)
                const Expanded(
                  child: Center(
                    child: Text(
                      'No documents found.\nPress the + button to ingest a PDF.',
                    ),
                  ),
                )
              else
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await chatNotifier.getDocuments();
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: chatState.documents.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200.0,
                            mainAxisSpacing: 16.0,
                            crossAxisSpacing: 16.0,
                            childAspectRatio: 0.65,
                          ),
                      itemBuilder: (context, index) {
                        final doc = chatState.documents[index];
                        return GestureDetector(
                          onTap: () {
                            chatNotifier.setConversationId(doc.id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChatPage(documentId: doc.id),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4.0,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Thumbnail or fallback image
                                Expanded(
                                  flex: 3,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      // Use actual thumbnail if available, otherwise fallback
                                      doc.thumbnailUrl != null
                                          ? Image.network(
                                              'http://localhost:8000${doc.thumbnailUrl}',
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                    // Fallback to random cover if thumbnail fails to load
                                                    return Image.asset(
                                                      _getFallbackCover(),
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                            )
                                          : Image.asset(
                                              _getFallbackCover(),
                                              fit: BoxFit.cover,
                                            ),
                                      // Gradient overlay for better text readability
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Colors.black.withValues(
                                                alpha: 0.7,
                                              ),
                                              Colors.transparent,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Document info section
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Title
                                        Flexible(
                                          child: Text(
                                            doc.filename,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                              color: Colors.black87,
                                              height: 1.2,
                                            ),
                                          ),
                                        ),
                                        // Author (if available)
                                        if (doc.author != null &&
                                            doc.author!.isNotEmpty) ...[
                                          const SizedBox(height: 2),
                                          Flexible(
                                            child: Text(
                                              'by ${doc.author}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.inter(
                                                fontSize: 9,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ],
                                        const SizedBox(height: 4),
                                        // Metadata row
                                        Row(
                                          children: [
                                            if (doc.pageCount != null) ...[
                                              Icon(
                                                Icons.description,
                                                size: 10,
                                                color: Colors.black45,
                                              ),
                                              const SizedBox(width: 2),
                                              Text(
                                                '${doc.pageCount}p',
                                                style: GoogleFonts.inter(
                                                  fontSize: 9,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ],
                                            const Spacer(),
                                            // File type indicator
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 3,
                                                    vertical: 1,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.black12,
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                              child: Text(
                                                doc.fileExtension
                                                        ?.toUpperCase()
                                                        .replaceAll('.', '') ??
                                                    'PDF',
                                                style: GoogleFonts.inter(
                                                  fontSize: 7,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: chatState.isLoading
            ? null
            : () => chatNotifier.ingestDocument(),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        tooltip: 'Ingest new PDF',
        child: const Icon(Icons.add),
      ),
    );
  }
}
