import 'package:flutter/material.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:styled_text/styled_text.dart';

class TextCSS extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle? style;
  const TextCSS(
    this.text, {
    super.key,
    this.textAlign,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return StyledText(
      textHeightBehavior: const TextHeightBehavior(),
      text: Tools.handleTextElement(text),
      textAlign: textAlign,
      style: style,
      tags: {
        'b': StyledTextTag(style: const TextStyle(fontWeight: FontWeight.bold)),
        'a': StyledTextTag(
            style: const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        )),
        'red': StyledTextTag(style: const TextStyle(color: Colors.red)),
        'orange': StyledTextTag(style: const TextStyle(color: Colors.orange)),
        'green': StyledTextTag(style: const TextStyle(color: Colors.green)),
        'cryo': StyledTextTag(style: const TextStyle(color: Color(0xff67bbcf))),
        'hydro':
            StyledTextTag(style: const TextStyle(color: Color(0xff0b4dda))),
        'pyro': StyledTextTag(style: const TextStyle(color: Color(0xffca4a25))),
        'electro':
            StyledTextTag(style: const TextStyle(color: Color(0xff9336b0))),
        'anemo':
            StyledTextTag(style: const TextStyle(color: Color(0xff70c7ab))),
        'geo': StyledTextTag(style: const TextStyle(color: Color(0xfff5ac16))),
        'dendro':
            StyledTextTag(style: const TextStyle(color: Color(0xff51810e))),
        'hp': StyledTextTag(style: const TextStyle(color: Color(0xffab0303))),
        'up': StyledTextTag(
            style: const TextStyle(
                color: Colors.orange, fontWeight: FontWeight.bold)),
        // 'color': StyledTextCustomTag(
        //   baseStyle: const TextStyle(),
        //   parse: (baseStyle, attributes) {
        //     if (attributes.containsKey('color') &&
        //         attributes['color'] is String &&
        //         ((attributes['color'] as String).substring(0, 1) == '#') &&
        //         (attributes['color'] as String).length >= 6) {
        //       String color = attributes['color'] as String;
        //       final String hexColor = color.substring(1);
        //       final Color c = Color(int.parse("0x$hexColor"));

        //       return baseStyle?.copyWith(color: c, fontWeight: FontWeight.bold);
        //     } else {
        //       return baseStyle;
        //     }
        //   },
        // ),
      },
    );
  }
}
