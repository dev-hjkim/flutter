import "package:flutter/material.dart";
import "./http_helper.dart";
import "./movie_detail.dart";

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late String result;
  late HttpHelper helper;
  late int moviesCount;
  late List movies;
  final String iconBase = "https://image.tmdb.org/t/p/w92/";
  final String defaultImage = "https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg";
  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text("Movies");

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: <Widget>[
          IconButton(
            icon: visibleIcon,
            onPressed: () {
              setState(() {
                if (this.visibleIcon.icon == Icons.search) {
                  this.visibleIcon = Icon(Icons.cancel);
                  this.searchBar = TextField(
                    textInputAction: TextInputAction.search,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0
                    ),
                    onSubmitted: (String text) {
                      search(text);
                    },
                  );
                } else {
                  setState(() {
                    this.visibleIcon = Icon(Icons.search);
                    this.searchBar = Text("Movies");
                  });
                }
              });
            },
          ),
        ],
      ),
      body: ListView.builder (
        itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
        itemBuilder: (BuildContext context, int position) {
          if (movies[position].posterPath != null) {
            image = NetworkImage(
              iconBase + movies[position].posterPath
            );
          }
          else {
            image = NetworkImage(defaultImage);
          }
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(movies[position].title),
              subtitle: Text("Released: " + movies[position].releaseDate +
                "- Vote: " + movies[position].voteAverage.toString()),
              leading: CircleAvatar(
                backgroundImage: image,
              ),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (_) => MovieDetail(movies[position])
                );
                Navigator.push(context, route);
              },
            )
          );
        })
    );
  }

  Future initialize() async {
    movies = [];
    movies = await helper.getUpcoming();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  Future search(text) async {
    movies = await helper.findMovies(text);
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }
}