import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Model/Task.dart';
import '../../Controllers/MainController.dart';
import 'package:date_field/date_field.dart';


class TaskForm extends StatefulWidget{
  TaskForm({super.key,this.defaultDate});
  DateTime? defaultDate;

  @override
  State<TaskForm> createState() => _TaskFormState();
  
}

class _TaskFormState extends State<TaskForm>{
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _date = widget.defaultDate != null ? widget.defaultDate!: DateTime.now() ;

  }

  void _onSubmit(){
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save the form data
      Provider.of<MainController>(context, listen: false).addTask(Task(_title, _description, _date));
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
            ),
            DateTimeField(
              value: _date,
              decoration: const InputDecoration(labelText: 'Enter DateTime'),
              onChanged: (DateTime? value){
                _date = value!;


              },
            )
          ],
        )
    );
  }

}