import 'package:flutter/material.dart';

class TextHighlighter {
  static List<TextSpan> highlight({
    required String source,
    required String query,
    required TextStyle normalStyle,
    required TextStyle highlightStyle,
  }) {
    if (query.isEmpty) {
      return [TextSpan(text: source, style: normalStyle)];
    }

    final words = query
        .toLowerCase()
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();

    final sourceLower = source.toLowerCase();
    final List<TextSpan> spans = [];
    int lastMatchEnd = 0;

    final matches = <Match>[];
    for (final word in words) {
      matches.addAll(word.allMatches(sourceLower));
    }

    matches.sort((a, b) => a.start.compareTo(b.start));

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(
          TextSpan(
            text: source.substring(lastMatchEnd, match.start),
            style: normalStyle,
          ),
        );
      }

      spans.add(
        TextSpan(
          text: source.substring(match.start, match.end),
          style: highlightStyle,
        ),
      );

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < source.length) {
      spans.add(
        TextSpan(text: source.substring(lastMatchEnd), style: normalStyle),
      );
    }

    return spans;
  }
}
