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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //Carregamento da função de requisição de filmes
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
  final String apikey = '';

  //Token da API
  final readaccesstoken = '';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
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
            //Or, you can use SingleChildScrollView + Collumn
            return CustomScrollView(
              slivers: [
                // SliverAppBar
                SliverAppBar(
                  backgroundColor: Colors.black54,
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,

                    // Background Stack
                    // O FlexibleSpaceBar possui um Stack como plano de fundo.
                    // O Stack contém uma imagem e uma DecoratedBox para adicionar um gradiente sobre a imagem.
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Imagem de fundo
                        Image.network(
                          'http://image.tmdb.org/t/p/w500' +
                              topratedmovies[2]['backdrop_path'],
                          fit: BoxFit.cover,
                        ),

                        // DecoratedBox para o gradiente
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0, 0.8),
                              end: Alignment(0, 0),
                              colors: [
                                Color.fromRGBO(0, 0, 0, 0.6),
                                Color.fromRGBO(0, 0, 0, 0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Título centralizado
                    title: Text(
                      'Movies App',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // SliverList
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      // SliverChildBuilderDelegate para os itens da lista
                      if (index == 0) {
                        // Widget de filmes mais bem avaliados
                        return topRatedMovies(
                            topRatedMoviesList: topratedmovies);
                      } else if (index == 1) {
                        // Widget de filmes em tendência
                        return trendingMovies(trending: trendingmovies);
                      } else if (index == 2) {
                        // Widget de programas de TV
                        return tvShowsMovies(tvShowsList: tvshows);
                      }
                      return SizedBox.shrink();
                    },
                    childCount: 3,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
