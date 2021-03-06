import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


void main() => runApp(Contacto());

class Contacto extends StatefulWidget {
  @override
  _ContactoState createState() => _ContactoState();
}

class _ContactoState extends State<Contacto> {
  String attachment;

  final _recipientController = TextEditingController(
    text: 'example@gmail.com',
  );

  final _subjectController = TextEditingController(text: 'The subject');

  final _bodyController = TextEditingController(
    text: 'Mail body.',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   _send()  {
    final String _email = 'mailto:' +
        _recipientController.text +
        '?subject=' +
        _subjectController.text +
        '&body=' +
        _bodyController.text;
    try {
       launch(_email);
    } catch (e) {
      throw 'Could not Call Phone';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget imagePath = Text(attachment ?? '');

    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.red),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Plugin example app'),
          actions: <Widget>[
            IconButton(
              onPressed: _send,
              icon: Icon(Icons.send),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _recipientController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Recipient',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _subjectController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Subject',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _bodyController,
                      maxLines: 10,
                      decoration: InputDecoration(
                          labelText: 'Body', border: OutlineInputBorder()),
                    ),
                  ),
                  imagePath,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  
}