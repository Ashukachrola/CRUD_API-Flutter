import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Insert_User extends StatefulWidget {

  Insert_User(this.map);

  Map? map;

  @override
  State<Insert_User> createState() => _Insert_UserState();
}

class _Insert_UserState extends State<Insert_User> {
  var formKey = GlobalKey<FormState>();

  var facultyNameController = TextEditingController();

  var departmentController = TextEditingController();

  var facultyMobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    facultyNameController.text=widget.map==null?'':widget.map!['FacultyName'];
    departmentController.text=widget.map==null?'':widget.map!['Department'];
    facultyMobileController.text=widget.map==null?'':widget.map!['FacultyMobile'].toString();
  }

  String Url = 'https://6310390036e6a2a04ee856d8.mockapi.io/Faculties';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'Enter Your Name:'),
                validator: (Value) {
                  if (Value != null && Value.isEmpty) {
                    return 'Enter Valid Input';
                  }
                },
                controller: facultyNameController,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Enter Your Department:'),
                validator: (Value) {
                  if (Value != null && Value.isEmpty) {
                    return 'Enter Valid Input';
                  }
                },
                controller: departmentController,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Enter Your MobileNo:'),
                validator: (Value) {
                  if (Value != null && Value.isEmpty) {
                    return 'Enter Valid Input';
                  }
                },
                controller: facultyMobileController,
              ),
              TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if(widget.map==null) {
                        insertUser().then((value) => Navigator.of(context).pop(true));
                      }
                      else{
                        updateUser(widget.map!['id']).then((value) => Navigator.of(context).pop(true));
                      }
                    }
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateUser(id) async {
    Map map = {};
    map['FacultyName'] = facultyNameController.text;
    map['Department'] = departmentController.text;
    map['FacultyMobile']=facultyMobileController.text;

    var resp = await http.put(Uri.parse('https://637f5cd65b1cc8d6f942aebf.mockapi.io/students/$id'),body: map);
    print(resp);
  }

  Future<void> insertUser() async {
    Map map = {};
    map['FacultyName'] = facultyNameController.text;
    map['Department'] = departmentController.text;
    map['FacultyMobile']=facultyMobileController.text;

    var res = await http.post(Uri.parse('https://637f5cd65b1cc8d6f942aebf.mockapi.io/students'),body: map);
    print(res);
  }
}