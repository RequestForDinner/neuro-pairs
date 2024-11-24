import 'package:flutter/cupertino.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

final class DefaultTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;

  final ValueChanged<String>? onChanged;
  final String? initialValue;

  final String? title;
  final int? maxLength;
  final String? hint;

  const DefaultTextField({
    this.controller,
    this.focusNode,
    this.onChanged,
    this.initialValue,
    this.maxLength,
    this.title,
    this.hint,
    super.key,
  });

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _initializeController();
    _initializeFocusNode();
  }

  void _initializeController() {
    _controller = (widget.controller ?? TextEditingController())
      ..text = widget.initialValue ?? '';
  }

  void _disposeController() {
    if (widget.focusNode == null) _controller.dispose();
  }

  void _initializeFocusNode() {
    _focusNode = (widget.focusNode ?? FocusNode())
      ..addListener(() => setState(() {}));
  }

  void _disposeFocusNode() {
    if (widget.focusNode == null) _focusNode.dispose();
  }

  @override
  void didUpdateWidget(covariant DefaultTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.focusNode == null && widget.focusNode != null) {
      _initializeFocusNode();
    }

    if (oldWidget.focusNode != null && widget.focusNode == null) {
      _disposeFocusNode();
    }
  }

  @override
  void dispose() {
    _disposeController();
    _disposeFocusNode();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: context.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        CupertinoTextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: widget.onChanged,
          placeholder: widget.hint,
          placeholderStyle: context.textTheme.headlineLarge?.copyWith(
            color: context.appTheme.secondaryTextColor,
          ),
          style: context.textTheme.headlineLarge,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          maxLength: widget.maxLength,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(32)),
            color: context.appTheme.nonActiveElementColor,
          ),
          cursorColor: context.appTheme.primaryTextColor,
        ),
      ],
    );
  }
}
