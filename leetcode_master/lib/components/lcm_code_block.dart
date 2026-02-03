import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/javascript.dart';
import '../config/constants.dart';

/// Supported programming languages
enum CodeLanguage { python, java, cpp, javascript }

/// Code block component with syntax highlighting and copy functionality
class LCMCodeBlock extends StatefulWidget {
  const LCMCodeBlock({
    super.key,
    required this.code,
    this.language = CodeLanguage.python,
    this.onLanguageChanged,
    this.showLanguageSelector = true,
  });

  final Map<CodeLanguage, String> code;
  final CodeLanguage language;
  final ValueChanged<CodeLanguage>? onLanguageChanged;
  final bool showLanguageSelector;

  @override
  State<LCMCodeBlock> createState() => _LCMCodeBlockState();
}

class _LCMCodeBlockState extends State<LCMCodeBlock> {
  late CodeLanguage _selectedLanguage;
  late CodeController _controller;
  bool _copied = false;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.language;
    _initController();
  }

  @override
  void didUpdateWidget(LCMCodeBlock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.code != widget.code ||
        oldWidget.language != widget.language) {
      _selectedLanguage = widget.language;
      _initController();
    }
  }

  void _initController() {
    final currentCode = widget.code[_selectedLanguage] ?? '';
    _controller = CodeController(
      text: currentCode,
      language: _getLanguageMode(),
    );
  }

  dynamic _getLanguageMode() {
    switch (_selectedLanguage) {
      case CodeLanguage.python:
        return python;
      case CodeLanguage.java:
        return java;
      case CodeLanguage.cpp:
        return cpp;
      case CodeLanguage.javascript:
        return javascript;
    }
  }

  String _getLanguageLabel(CodeLanguage lang) {
    switch (lang) {
      case CodeLanguage.python:
        return 'Python';
      case CodeLanguage.java:
        return 'Java';
      case CodeLanguage.cpp:
        return 'C++';
      case CodeLanguage.javascript:
        return 'JavaScript';
    }
  }

  void _onLanguageSelected(CodeLanguage? lang) {
    if (lang == null) return;
    setState(() {
      _selectedLanguage = lang;
      _initController();
    });
    widget.onLanguageChanged?.call(lang);
  }

  Future<void> _copyToClipboard() async {
    final code = widget.code[_selectedLanguage] ?? '';
    await Clipboard.setData(ClipboardData(text: code));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _copied = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LCMColors.codeBackground,
        borderRadius: BorderRadius.circular(LCMDimensions.radiusMD),
        border: Border.all(color: LCMColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with language selector and copy button
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: LCMDimensions.paddingSM,
              vertical: LCMDimensions.paddingXS,
            ),
            decoration: const BoxDecoration(
              color: LCMColors.cardBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(LCMDimensions.radiusMD),
                topRight: Radius.circular(LCMDimensions.radiusMD),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.showLanguageSelector)
                  DropdownButton<CodeLanguage>(
                    value: _selectedLanguage,
                    onChanged: _onLanguageSelected,
                    dropdownColor: LCMColors.cardBackground,
                    underline: const SizedBox(),
                    style: const TextStyle(
                      color: LCMColors.textPrimary,
                      fontSize: 12,
                    ),
                    items: widget.code.keys.map((lang) {
                      return DropdownMenuItem<CodeLanguage>(
                        value: lang,
                        child: Text(_getLanguageLabel(lang)),
                      );
                    }).toList(),
                  ),
                IconButton(
                  onPressed: _copyToClipboard,
                  icon: Icon(
                    _copied ? Icons.check : Icons.copy,
                    size: 18,
                    color: _copied ? LCMColors.success : LCMColors.textSecondary,
                  ),
                  tooltip: 'Copy code',
                  splashRadius: 20,
                ),
              ],
            ),
          ),

          // Code editor (read-only)
          Padding(
            padding: const EdgeInsets.all(LCMDimensions.paddingSM),
            child: CodeTheme(
              data: CodeThemeData(
                styles: _dracula,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: CodeField(
                  controller: _controller,
                  textStyle: const TextStyle(
                    fontFamily: 'JetBrainsMono',
                    fontSize: 13,
                    height: 1.5,
                  ),
                  readOnly: true,
                  minLines: 1,
                  maxLines: null,
                  wrap: false,
                  background: LCMColors.codeBackground,
                  gutterStyle: const GutterStyle(
                    showLineNumbers: true,
                    textStyle: TextStyle(
                      color: LCMColors.textMuted,
                      fontSize: 12,
                      fontFamily: 'JetBrainsMono',
                    ),
                    background: LCMColors.codeBackground,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dracula theme colors for code highlighting
const _dracula = {
  'root': TextStyle(backgroundColor: LCMColors.codeBackground, color: Color(0xFFF8F8F2)),
  'keyword': TextStyle(color: Color(0xFFFF79C6)),
  'selector-tag': TextStyle(color: Color(0xFFFF79C6)),
  'literal': TextStyle(color: Color(0xFFFF79C6)),
  'section': TextStyle(color: Color(0xFFFF79C6)),
  'link': TextStyle(color: Color(0xFFFF79C6)),
  'subst': TextStyle(color: Color(0xFFF8F8F2)),
  'string': TextStyle(color: Color(0xFFF1FA8C)),
  'title': TextStyle(color: Color(0xFF50FA7B)),
  'name': TextStyle(color: Color(0xFF50FA7B)),
  'type': TextStyle(color: Color(0xFF8BE9FD)),
  'attr': TextStyle(color: Color(0xFF8BE9FD)),
  'symbol': TextStyle(color: Color(0xFF8BE9FD)),
  'bullet': TextStyle(color: Color(0xFF8BE9FD)),
  'addition': TextStyle(color: Color(0xFF8BE9FD)),
  'variable': TextStyle(color: Color(0xFFF8F8F2)),
  'template-tag': TextStyle(color: Color(0xFFF8F8F2)),
  'template-variable': TextStyle(color: Color(0xFFF8F8F2)),
  'comment': TextStyle(color: Color(0xFF6272A4)),
  'quote': TextStyle(color: Color(0xFF6272A4)),
  'deletion': TextStyle(color: Color(0xFFFF5555)),
  'meta': TextStyle(color: Color(0xFFFF79C6)),
  'doctag': TextStyle(color: Color(0xFF6272A4)),
  'number': TextStyle(color: Color(0xFFBD93F9)),
  'built_in': TextStyle(color: Color(0xFF8BE9FD)),
  'class': TextStyle(color: Color(0xFF8BE9FD)),
  'function': TextStyle(color: Color(0xFF50FA7B)),
  'params': TextStyle(color: Color(0xFFFFB86C)),
};
