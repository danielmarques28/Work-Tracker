import 'dart:async';
import 'package:flutter/material.dart';

import 'package:worktracker/helpers/responsive.dart';
import 'package:worktracker/models/RoutineFile.dart';
import 'package:worktracker/widgets/CustomSubmit.dart';
import 'package:worktracker/widgets/CustomTextField.dart';
import 'package:worktracker/widgets/GoBackTopBar.dart';

class RoutineForm extends StatefulWidget {
  @override
  _RoutineFormState createState() => _RoutineFormState();
}

class _RoutineFormState extends State<RoutineForm> {
  final GlobalKey<FormState> _formKey
    = GlobalKey<FormState>();
  String _name = '';
  String _description = '';

  void saveRoutine() {
    if(_formKey.currentState.validate()) {
      Map<String, dynamic> routine = {
        'name': _name,
        'description': _description
      };
      RoutineFile().writeFile(routine)
        .then((calendar) {
          Timer(
            Duration(milliseconds: 100),
            () => Navigator.pop(context, calendar)
          );
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeigth(context, 0.85),
      margin: EdgeInsets.only(
        top: deviceHeigth(context, 0.02),
        left: deviceWidth(context, 0.025),
        right: deviceWidth(context, 0.025)
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            CustomTextField(
              labelText: 'Nome',
              icon: Icons.subtitles,
              isNotEmpty: true,
              value: (text) => setState(() => _name = text)
            ),
            CustomTextField(
              labelText: 'Descrição',
              icon: Icons.subject,
              isNotEmpty: true,
              value: (text) => setState(() => _description = text)
            ),
            CustomSubmit(callback: () => saveRoutine())
          ]
        )
      )
    );
  }
}

class CreateRoutine extends StatefulWidget {
  @override
  _CreateRoutineState createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF1F253D),
      body: Container(
        width: deviceWidth(context),
        height: deviceHeigth(context),
        // decoration: background(),
        child: ListView(
          children: [
            GoBackTopBar(screenTitle: 'Criar Rotina'),
            RoutineForm()
          ]
        )
      )
    );
  }
}
