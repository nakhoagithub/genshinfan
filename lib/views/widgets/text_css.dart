import 'package:flutter/material.dart';
import 'package:genshinfan/resources/utils/tools.dart';
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
        'orange': StyledTextTag(style: const TextStyle(color: Colors.orange)),
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
      },
    );
  }
}
