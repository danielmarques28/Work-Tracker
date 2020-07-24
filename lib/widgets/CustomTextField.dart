import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worktracker/helpers/responsive.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class CustomTextField extends StatefulWidget {
  final Function value;
  final String labelText;
  final IconData icon;
  final bool isNotEmpty;

  CustomTextField({
    @required this.value,
    @required this.labelText,
    @required this.icon,
    @required this.isNotEmpty
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String _text = '';
  FocusNode _focus = FocusNode();

  @override
  void dispose() {
    
    super.dispose();
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: deviceHeigth(context, 0.02)),
      child: TextFormField(
        onTap: () {
          _focus.requestFocus();
        },
        focusNode: _focus,
        onChanged: (text) {
          setState(() => _text = text);
          widget.value?.call(text);
        },
        inputFormatters: [
          UpperCaseTextFormatter()
        ],
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            _text.isNotEmpty
            ? Icons.check_circle
            : widget.icon
          ),
          labelText: widget.labelText
        ),
        validator: (text) {
          if(widget.isNotEmpty && text.isEmpty)
            return 'Digite um ${widget.labelText.toLowerCase()}';
          return null;
        },
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) =>
          FocusScope.of(context).unfocus()
      )
    );
  }
}
