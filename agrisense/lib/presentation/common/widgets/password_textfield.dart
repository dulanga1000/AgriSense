import 'package:flutter/material.dart';

enum PasswordFieldStyle { standard, card }

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final String? label;
  final PasswordFieldStyle style;

  final String? Function(String?)? validator;
  final Widget? extraContent;
  final bool showExtraContentOnFocusAndText;

  const PasswordTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText = 'Enter your password',
    this.label,
    this.style = PasswordFieldStyle.standard,
    this.validator,
    this.extraContent,
    this.showExtraContentOnFocusAndText = false,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscurePassword = true;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChanged() {
    setState(() {});
  }

  bool get _showExtraContent {
    if (widget.extraContent == null) return false;
    if (!widget.showExtraContentOnFocusAndText) return true;
    return _focusNode.hasFocus && widget.controller.text.isNotEmpty;
  }

  Widget? _buildLabel() {
    if (widget.label == null) return null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label!,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 6),
      ],
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      hintText: widget.hintText,
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: IconButton(
        icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => obscurePassword = !obscurePassword),
      ),
      filled: true,
      fillColor: widget.style == PasswordFieldStyle.card
          ? const Color(0xFFF6F7F9)
          : const Color(0xFFFFFFFF),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF0E8F3E), width: 2),
      ),
    );
  }

  Widget _buildField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          obscureText: obscurePassword,
          onChanged: (value) {
            widget.onChanged?.call(value);
            if (widget.showExtraContentOnFocusAndText) {
              setState(() {});
            }
          },
          decoration: _buildDecoration(),

          validator: widget.validator,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          child: _showExtraContent
              ? Column(
                  children: [const SizedBox(height: 8), widget.extraContent!],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final label = _buildLabel();
    final field = _buildField();

    if (widget.style == PasswordFieldStyle.card) {
      return Card(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [if (label != null) label, field],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [if (label != null) label, field],
    );
  }
}
