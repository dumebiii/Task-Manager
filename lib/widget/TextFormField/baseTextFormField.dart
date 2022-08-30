import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/ui_helpers.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final Iterable<String>? autofillHints;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final AutovalidateMode? autovalidateMode;
  final Widget? prefixIcon;
  final double? height;
  final Color? textColor;
  final String? hintText;
  final bool autoFocus;
  final bool isPasswordTextField;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final String? labelText;
  final FormFieldValidator<String>? validator;
  final String? prefixText;
  final bool? enabled;
  final String? initialValue;
  final Color? fillColor;
  final bool? autocorrect;
  final TextCapitalization? textCapitalization;
  final bool readOnly;
  final Color? cursorColor;
  final double? cursorHeight;
  final InputDecoration? decoration;
  final TextStyle? style;
  final bool? obscureText;

  const CustomTextFormField.regular({
    Key? key,
    this.controller,
    this.readOnly = false,
    this.autofillHints,
    this.onTap,
    this.onChanged,
    this.autovalidateMode,
    this.textColor,
    this.hintText,
    this.autoFocus = false,
    this.height,
    this.onSaved,
    this.onFieldSubmitted,
    this.isPasswordTextField = false,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.prefixIcon,
    this.labelText,
    this.floatingLabelBehavior,
    this.prefixText,
    this.validator,
    this.enabled,
    this.initialValue,
    this.fillColor,
    this.autocorrect,
    this.textCapitalization,
    this.obscureText = false,
    this.cursorColor,
    this.cursorHeight,
    this.decoration,
    this.style,
  }) : super(key: key);

  const CustomTextFormField.password({
    Key? key,
    this.controller,
    this.onChanged,
    this.autofillHints,
    this.onTap,
    this.readOnly = false,
    this.height,
    this.autovalidateMode,
    this.prefixIcon,
    this.textColor,
    this.hintText,
    this.autoFocus = false,
    this.floatingLabelBehavior,
    this.isPasswordTextField = true,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.inputFormatters,
    this.onSaved,
    this.onFieldSubmitted,
    this.labelText,
    this.prefixText,
    this.validator,
    this.enabled,
    this.initialValue,
    this.fillColor,
    this.autocorrect,
    this.textCapitalization,
    this.obscureText,
    this.cursorColor,
    this.cursorHeight,
    this.decoration,
    this.style,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.labelText != null,
          child: Text(
            widget.labelText ?? '',
            style: theme.textTheme.subtitle1
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Visibility(
          visible: widget.labelText != null,
          child: verticalSpaceCustom(4),
        ),
        SizedBox(
          height: widget.height,
          child: TextFormField(
            autofillHints: widget.autofillHints,
            onTap: widget.onTap,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            onFieldSubmitted: widget.onFieldSubmitted,
            onSaved: widget.onSaved,
            autovalidateMode: widget.autovalidateMode,
            onChanged: (value) => widget.onChanged != null
                ? widget.onChanged!(value.trim())
                : null,
            inputFormatters: widget.inputFormatters,
            cursorColor: widget.cursorColor,
            cursorHeight: widget.cursorHeight,
            style: widget.style,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            autocorrect: widget.autocorrect ?? false,
            controller: widget.controller,
            initialValue: widget.initialValue,
            autofocus: widget.autoFocus,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            validator: widget.validator,
            obscureText: widget.obscureText!,
            decoration: widget.decoration,
            // decoration: InputDecoration(
            //   contentPadding:
            //       const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            //   prefixText: widget.prefixText,
            //   prefixStyle: theme.textTheme.subtitle1
            //       ?.copyWith(fontWeight: FontWeight.bold),
            //   floatingLabelBehavior: widget.floatingLabelBehavior,
            //   prefixIcon: widget.prefixIcon,
            // border: const OutlineInputBorder(
            //   borderSide: BorderSide(color: kGrey),
            //   borderRadius: k8pxBorderRadius,
            // ),
            // enabledBorder: const OutlineInputBorder(
            //   borderSide: BorderSide(color: kGrey),
            //   borderRadius: k8pxBorderRadius,
            // ),
            // focusedBorder: const OutlineInputBorder(
            //   borderSide: BorderSide(color: kDarkGrey),
            //   borderRadius: k8pxBorderRadius,
            // ),
            // hintText: widget.hintText,
            // hintStyle:
            //     theme.textTheme.subtitle1?.copyWith(color: Colors.grey),
            // suffixIcon: widget.isPasswordTextField
            //     ? GestureDetector(
            //         child: _obscureText
            //             ? const Icon(Icons.visibility, color: kDarkGrey)
            //             : const Icon(Icons.visibility_off, color: kGrey),
            //         onTap: _toggleObscure,
            //       )
            //     : null,
            // ),
          ),
        ),
      ],
    );
  }
}
