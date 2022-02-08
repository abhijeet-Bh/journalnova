import 'package:flutter/material.dart';

class EntryDetails extends StatefulWidget {
  const EntryDetails({Key? key, required this.data}) : super(key: key);

  final Map data;

  @override
  _EntryDetailsState createState() => _EntryDetailsState();
}
 var entry;
class _EntryDetailsState extends State<EntryDetails> {
  @override
  void initState() {
    super.initState();
    entry = widget.data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffFFC1628B)
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end:
                        Alignment.bottomCenter, // 10% of the width, so there are ten blinds.
                        colors: <Color>[
                          Color(0xffFBDA61),
                          Color(0xffFF5ACD)
                        ], // red to yellow
                        tileMode: TileMode.repeated, // repeats the gradient over the canvas
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        entry["heading"],
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        'Written on: ' + entry["date"],
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )
                    ],
                  ),
                ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Text(
                      entry["content"],
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                    ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
