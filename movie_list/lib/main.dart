import "package:flutter/material.dart";
import "./movie_list.dart";

void main() => runApp(MyMovies());

class MyMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyMovies",
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MovieList();
  }
}