import 'package:flutter/material.dart';
import 'package:journalnova/DatabaseHandler.dart';

class EditEntry extends StatefulWidget {
  const EditEntry({Key? key,required this.data}) : super(key: key);

  final Map data;

  @override
  _EditEntryState createState() => _EditEntryState();
}

var _date = "";
var _title = "";
var _body = "";


class _EditEntryState extends State<EditEntry> {
  @override
  void initState() {
    super.initState();
    _date = widget.data["date"];
    _title = widget.data["heading"];
    _body = widget.data["content"];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Entry"),
        backgroundColor: Color(0xffFFC1628B),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                maxLines: 1,
                style: TextStyle(
                    color: Color(0xff9AFF6214),
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
                decoration: InputDecoration(
                  hintText: _date,
                  hintStyle: TextStyle(color: Color(0xffFF9A9B9C)),
                  contentPadding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 10.0),
                  filled: true,
                  fillColor: Color(0xff61F8B18B),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(color: Color(0xffFFFC8955), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(color: Color(0xffFFFC8955), width: 2.0),
                  ),
                ),
                onChanged:(String dval) => _date = dval,
              ),
              SizedBox(height: 20,),
              TextField(
                maxLines: 1,
                style: TextStyle(
                    color: Color(0xff9AFF6214),
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
                decoration: InputDecoration(
                  hintText: _title,
                  hintStyle: TextStyle(color: Color(0xffA4979797)),
                  contentPadding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 10.0),
                  filled: true,
                  fillColor: Color(0xff61F8B18B),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(color: Color(0xffFFFC8955), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(color: Color(0xffFFFC8955), width: 2.0),
                  ),
                ),
                onChanged:(String tval) => _title = tval,
              ),
              SizedBox(height: 20,),
              TextField(
                maxLines: 20,
                style: TextStyle(
                    color: Color(0xff9AFF6214),
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
                decoration: InputDecoration(
                  hintText: _body,
                  hintStyle: TextStyle(color: Color(0xffA4979797)),
                  contentPadding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 10.0),
                  filled: true,
                  fillColor: Color(0xff61F8B18B),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(color: Color(0xffFFFC8955), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(color: Color(0xffFFFC8955), width: 2.0),
                  ),
                ),
                onChanged:(String bval) => _body = bval,
              ),
              SizedBox(height: 25,),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(color: Colors.greenAccent),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Update",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color(
                          0xff1c1c1c)),),
                    ),
                  ),
                ),
                onTap: () async{
                  int rowsUpdated = await DatabaseHandler.instance.update(
                      {
                        DatabaseHandler.columnId: widget.data["_id"],
                        DatabaseHandler.columnDate : _date,
                        DatabaseHandler.columnHeading: _title,
                        DatabaseHandler.columnContent: _body
                      });
                  print('The inserted id is $rowsUpdated');
                  setState(() {
                    _date = "";
                    _title = "";
                    _body = "";
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Awesome, your entry is updated !"),
                    action: SnackBarAction(
                      label: "Okay",
                      onPressed: (){Navigator.pop(context, false);},
                    ),
                    backgroundColor: Colors.greenAccent,
                    behavior: SnackBarBehavior.floating,
                  ),);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

