import 'package:test1/movie.dart';
import 'package:test1/db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEditPage extends StatefulWidget {
  final Movie movie;
  AddEditPage({this.movie});
  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  TextEditingController title, body;
  bool loading = false, editmode = false;

  var curnDate = DateFormat.yMd().add_jm().format(DateTime.now());

  @override
  void initState() {
    super.initState();
    title = TextEditingController();
    body = TextEditingController();
    if (widget.movie.id != null) {
      editmode = true;
      title.text = widget.movie.title;
      body.text = widget.movie.body;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(editmode ? 'EDIT' : 'ADD'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              save();
            },
          ),
          if (editmode)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                delete();
              },
            ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: title,
              decoration: InputDecoration(labelText: 'Movie Name'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: body,
              decoration: InputDecoration(labelText: 'Director Name'),
            ),
          ),
        ],
      ),
    );
  }
  Widget imageprofile() {
    return Center(
        child: Stack( children: <Widget>[
        CircleAvatar(
          radius:80.0,
          backgroundImage:AssetImage("assets/profile.jpg") ,
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {},
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        )
      ]),
    );
  }

  Future<void> save()async{
    if (title != null) {
      widget.movie.date = curnDate;
      widget.movie.title = title.text;
      widget.movie.body = body.text;
      if (editmode) await DB().update(widget.movie);
      else await DB().save(widget.movie);
    }
    Navigator.pop(context);
    setState(() => loading = false);
  }

  Future<void> delete() async{
    DB().delete(widget.movie);
    setState(() {
      loading = false;
    });
    Navigator.pop(context);
  }


}