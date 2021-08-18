import 'package:test1/AddEditPage.dart';
import 'package:test1/movie.dart';
import 'package:test1/db.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Movie> movieList;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yellow Class Task'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEditPage(
                    movie: Movie(),
                  ))).then((value) {
            refreshList();
          });
        },
      ),
      body: loading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          Movie movie = movieList[index];
          return Card(
            elevation: 3,
            child: ListTile(
              onTap: (){
                setState(() {
                  loading = true;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddEditPage(
                            movie: movie,
                          ))).then((value) {
                    refreshList();
                  });
                });
              },
              leading: IconButton(
                icon: Icon(Icons.view_headline),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context){
                        return SimpleDialog(
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.pink,
                          title: Text(movie.title),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () {},
                              child: Text(movie.body),
                            ),
                            SizedBox(height: 20,),
                            MaterialButton(
                              color: Colors.white,
                              child: Text('Cancel'),
                              onPressed: (){
                                Navigator.pop(context);
                              },),
                          ],);
                      });
                },
              ),
              title: Text(movie.title),
              subtitle: Text(movie.body,maxLines: 3,),
              trailing: Text(movie.date),
            ),
          );
        },
      ),
    );
  }

  Future<void> refreshList() async {
    movieList = await DB().getMovie();
    setState(() => loading = false);
  }
}