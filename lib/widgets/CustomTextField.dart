import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      margin: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        onChanged: (text) {
          setState(() => _text = text);
          widget.value?.call(text);
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(),
          fillColor: Colors.white24,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
          prefixIcon: Icon(
            _text.isNotEmpty
            ? Icons.check_circle
            : widget.icon,
            color: Colors.white
          )
        ),
        validator: (text) {
          if(widget.isNotEmpty && text.isEmpty)
            return 'Digite um ${widget.labelText.toLowerCase()}';
          return null;
        },
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) =>
          FocusScope.of(context).nextFocus()
      )
    );
  }
}
