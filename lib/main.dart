import 'package:flutter/material.dart';
import 'package:flutter_multi_textfield/add_screen.dart';
import 'package:flutter_multi_textfield/database/database_hepler.dart';
import 'package:flutter_multi_textfield/database/list.dart';
import 'package:flutter_multi_textfield/database/model/Contact.dart';

void main() => runApp(MyApp());
abstract class HomeContract {
  void screenUpdate();
}
class MyApp extends StatelessWidget {
  HomeContract _view;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;
  List<Contact> contact;
  var db = new DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter layout demo'),
        ),
        body:new FutureBuilder<List<Contact>>(
          future:  db.getContact(),
          builder: (context,AsyncSnapshot<List<Contact>> snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              print("***snop");
//              print(snapshot.co.);
              print("***snop");
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Contact contact = snapshot.data[index];
                    return new Card(
                      child: new Container(
                          child: new Center(
                            child: new Row(
                              children: <Widget>[
                                new CircleAvatar(
                                  radius: 30.0,
                                  child: new Text(getShortName(contact)),
                                  backgroundColor: const Color(0xFF20283e),
                                ),
                                new Expanded(
                                  child: new Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Text(
                                          contact.adresse +
                                              " " +
                                              contact.etat,
                                          // set some style to text
                                          style: new TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.lightBlueAccent),
                                        ),
                                        new Text(
                                          "DATE: " + contact.date,
                                          // set some style to text
                                          style: new TextStyle(
                                              fontSize: 20.0, color: Colors.amber),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: const Color(0xFF167F67),
                                        ),
                                        onPressed: () {}
//                              => edit(contact[index], context)

                                    ),

                                    new IconButton(
                                      icon: const Icon(Icons.delete_forever,
                                          color: const Color(0xFF167F67)),
                                      onPressed: () =>
                                          delete(contact),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
                    );
                  });
            }
            else{
              return Center(child: new CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            Navigator.push(
              context,
              //  MaterialPageRoute(builder: (context) => ContactList(contact,data)),
              MaterialPageRoute(builder: (context) => AddScreen()),
            );
          },
        ),
      ),
    );

  }
  String getShortName(Contact Contact) {
    String shortName = "";
    if (!Contact.adresse.isEmpty) {
      shortName = Contact.adresse.substring(0, 1) + ".";
    }

    if (!Contact.date.isEmpty) {
      shortName = shortName + Contact.date.substring(0, 1);
    }
    return shortName;
  }
  delete(Contact contact) {
    var db = new DatabaseHelper();
    db.deleteContact(contact);
    updateScreen();
  }
  updateScreen() {


  }
}
