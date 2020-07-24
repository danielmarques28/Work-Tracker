import 'package:flutter/material.dart';
import 'package:worktracker/helpers/background.dart';
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
      RoutineFile().writeFile(routine);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: deviceHeigth(context, 0.05),
        left: deviceWidth(context, 0.05),
        right: deviceWidth(context, 0.05)
      ),
      child: Form(
        key: _formKey,
        autovalidate: true,
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
            CustomSubmit(
              callback: () => saveRoutine()
            )
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
    return WillPopScope(
      onWillPop: () async {
        print('create routine back-button');
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: background(),
          child: ListView(
            children: [
              GoBackTopBar(screenName: 'Criar Rotina'),
              RoutineForm()
            ]
          )
        )
      )
    );
  }
}
