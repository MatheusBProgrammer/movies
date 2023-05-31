import 'package:flutter/material.dart';
import 'package:movies/utils/text.dart';
import 'package:movies/widgets/toprated.dart';
import 'package:movies/widgets/trendding.dart';
import 'package:movies/widgets/tv_shows.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> moviesFuture;

  List trendingmovies = [];
  List topratedmovies = [];
  List tvshows = [];

  //ao iniciar o estado, ele carrega uma lista da API
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesFuture = loadmovies();
  }

  //Chave da Api
  final String apikey = 'e717b9329987552e93b366bbec144548';

  //Token da API
  final readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNzE3YjkzMjk5ODc1NTJlOTNiMzY2YmJlYzE0NDU0OCIsInN1YiI6IjY0NzI5ZTg0YTE5OWE2MDBiZjI5YWZmZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.zvRA8xmS1FhW62VqCMN6_ZesSM-9HPHYhoUsAB5UgQw';

  Future<void> loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
        ApiKeys(
          apikey,
          readaccesstoken,
        ),
        logConfig: ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvshowsresult = await tmdbWithCustomLogs.v3.tv.getPopular();
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tvshows = tvshowsresult['results'];
    });
    print(tvshows);
    print(tvshows[1]);
    print(tvshows[2]);
    print(tvshows[3]);
    print(tvshows[4]);
    print(tvshows[5]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title:
              modified_text(text: 'Movie App', color: Colors.white, size: 30),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: moviesFuture,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return (Center(
                child: Text('Error'),
              ));
            } else {
              return ListView(
                //Lançamentos
                  children: [
                    topRatedMovies(topRatedMoviesList: topratedmovies),
                    trendingMovies(trending: trendingmovies),
                    tvShowsMovies(tvShowsList: tvshows)
                  ]) ;
            }
          },

        ));
  }
}
