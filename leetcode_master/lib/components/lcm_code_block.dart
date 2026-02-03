import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool _copied = false;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.language;
  }

  @override
  void didUpdateWidget(LCMCodeBlock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.code != widget.code ||
        oldWidget.language != widget.language) {
      _selectedLanguage = widget.language;
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
                    color: _copied
                        ? LCMColors.success
                        : LCMColors.textSecondary,
                  ),
                  tooltip: 'Copy code',
                  splashRadius: 20,
                ),
              ],
            ),
          ),

          // Code text (read-only)
          Container(
            padding: const EdgeInsets.all(LCMDimensions.paddingSM),
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableText(
                widget.code[_selectedLanguage] ?? '',
                style: const TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 13,
                  height: 1.5,
                  color: LCMColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
