class Movie {
  int id;
  String title,body,date;

  Movie();

  Movie.fromMap(Map<String, dynamic> map){
    id = map['id'];
    title = map['title'];
    body = map['body'];
    date = map['date'];
  }

  toMap(){
    return {
      'id' : id,
      'title' : title,
      'body' : body,
      'date' : date,
    };
  }
}