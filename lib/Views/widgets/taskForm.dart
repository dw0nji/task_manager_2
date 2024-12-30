import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Model/Task.dart';

import '../../Controllers/MainController.dart';

class TaskForm extends StatefulWidget{
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
  
}

class _TaskFormState extends State<TaskForm>{
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';


  void _onSubmit(){
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save the form data
      Provider.of<MainController>(context, listen: false).addTask(Task(_title, _description, DateTime(0,0,0,5,20)));
      Navigator.pop(context);
    }
  }
  void _onCancel(){
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    //TODO: add functionality to input the date instead of manually doing it.
    return
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: _onCancel, // Call the _submitForm function when the button is pressed
                  child: Text('cancel'), // Text on the button
                ),
                Spacer(),
                TextButton(
                  onPressed: _onSubmit, // Call the _submitForm function when the button is pressed
                  child: Text('Submit'), // Text on the button
                ),

              ],
            ),
            //Spacer(),
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Please Enter some text.';
                }
                return null;
              },
              onSaved: (value){
                _title = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Please Enter some text.';
                }
                return null;
              },
              onSaved: (value){
                _description = value!;
              },
            )
          ],
        )
    );
  }

}