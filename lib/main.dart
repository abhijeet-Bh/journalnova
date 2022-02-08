import 'package:journalnova/AddEntry.dart';
import 'package:journalnova/DatabaseHandler.dart';
import 'package:journalnova/EditEntry.dart';
import 'package:journalnova/Entrydetails.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Journal Nova',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List AllEntries = [];
Future _fetchdata() async{
  AllEntries = await DatabaseHandler.instance.queryAll();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Journal Nova"),
        backgroundColor: Color(0xffB762C1),
      ),
      body: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2), () => _fetchdata()),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 25),
                  Text("Fetching your Entries, Please wait .... !")
                ],
              ));
            }
            if(AllEntries.length == 0){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Oops ! it Seems, you haven't added Anything.",
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            fontFamily: 'Playball',
                            fontStyle: FontStyle.italic,
                            fontSize: 25.0),
                            textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffFFF3AB8A),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text("Add Now!"),
                      ),
                      onTap: (){
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return AddEntry();
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Recent Entries",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Color(0xffA13333)),),
                          IconButton(
                              onPressed: (){
                                setState(() {
                                });},
                              icon: Icon(Icons.refresh,color: Color(0xffA13333),))
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height: 180,
                                    width: MediaQuery.of(context).size.width*0.7,
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
                                            AllEntries[index]["heading"],
                                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
                                          ),
                                        Text(
                                          'Written on: ' + AllEntries[index]["date"],
                                          style: TextStyle(color: Colors.white, fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: (){
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (BuildContext context, animation, secondaryAnimation) {
                                          return EntryDetails(data: AllEntries[index]);
                                        },
                                      ),
                                    );
                                  },
                                ),
                                Positioned(
                                  top:5,
                                  right:5,
                                  child: GestureDetector(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.edit, color: Colors.pinkAccent,),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white24,
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder:
                                              (BuildContext context, animation, secondaryAnimation) {
                                            return EditEntry(data: AllEntries[index]);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                    top: 10,
                                    left: 10,
                                    child: GestureDetector(
                                      child : Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.delete, color: Colors.pinkAccent,),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white24,
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                      ),
                                      onTap: () async{
                                        int rowsDeleted = await DatabaseHandler.instance.delete(AllEntries[index + 2]["_id"]);
                                        print(rowsDeleted);
                                        setState(() {

                                        });
                                      },
                                    )
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: AllEntries.length == 1 ? 1 : 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Older Entries",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Color(0xffA13333)),),
                    ),
                    Container(
                      // height: MediaQuery.of(context).size.height - 250,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Stack(
                                children: [
                                  Container(
                                    height: 180,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end:
                                          Alignment.centerRight, // 10% of the width, so there are ten blinds.
                                          colors: <Color>[
                                            Color(0xff0093E9),
                                            Color(0xff80D0C7)
                                          ], // red to yellow
                                          tileMode: TileMode.repeated, // repeats the gradient over the canvas
                                        ),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AllEntries[index + 2]["heading"],
                                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
                                        ),
                                        Text(
                                          'Written on: ' + AllEntries[index + 2]["date"],
                                          style: TextStyle(color: Colors.white, fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      top: 5,
                                      right: 5,
                                      child: GestureDetector(
                                        child : Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.edit, color: Colors.pinkAccent,),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                        ),
                                        onTap: (){
                                          Navigator.of(context).push(
                                            PageRouteBuilder(
                                              pageBuilder:
                                                  (BuildContext context, animation, secondaryAnimation) {
                                                return EditEntry(data: AllEntries[index + 2]);
                                              },
                                            ),
                                          );
                                        },
                                      )
                                  ),
                                  Positioned(
                                      top: 10,
                                      left: 10,
                                      child: GestureDetector(
                                        child : Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.delete, color: Colors.pinkAccent,),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                        ),
                                        onTap: () async{
                                          int rowsDeleted = await DatabaseHandler.instance.delete(AllEntries[index + 2]["_id"]);
                                          print(rowsDeleted);
                                          setState(() {

                                          });
                                        },
                                      )
                                  )
                                ],
                              ),
                              onTap: (){
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (BuildContext context, animation, secondaryAnimation) {
                                      return EntryDetails(data: AllEntries[index + 2]);
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        },itemCount: AllEntries.length - 2,),
                    )
                  ],
                ),
              ),
            );
          }
      ),
        drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.white),
          child: Drawer(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 150),
                    GestureDetector(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff6AEE9C79),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 100),
                            child: Text("Home",style: TextStyle(color: Colors.white,fontSize: 23),),
                          )),
                      onTap: () {
                        Navigator.pop(context, false);
                      }
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xffA9FF9858),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 75),
                            child: Text("New Entry",style: TextStyle(color: Colors.white,fontSize: 23),),
                          )),
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return AddEntry();
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
