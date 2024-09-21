import 'package:flutter/material.dart';

class UrlTextField extends StatefulWidget {
  const UrlTextField({
    super.key,
    this.onChanged,
    this.initValue = '',
    required this.isValid,
    required this.errorMassage,
    this.icon,
  });

  final String initValue;
  final ValueChanged<String>? onChanged;
  final bool isValid;
  final String errorMassage;
  final Widget? icon;

  @override
  State<UrlTextField> createState() => _UrlTextFieldState();
}

class _UrlTextFieldState extends State<UrlTextField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.initValue;
    super.initState();
  }

  @override
  void didUpdateWidget(UrlTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initValue != oldWidget.initValue) {
      _controller.text = widget.initValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        icon: widget.icon,
        hintText: 'Enter URL',
        errorText: widget.isValid ? null : widget.errorMassage,
      ),
    );
  }
}
