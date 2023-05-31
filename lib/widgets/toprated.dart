import 'package:flutter/material.dart';

import '../description.dart';
import '../utils/text.dart';

class topRatedMovies extends StatelessWidget {
  final List topRatedMoviesList;

  const topRatedMovies({Key? key, required this.topRatedMoviesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        //Titulo da Sessão + Conteudo da Sessão
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Título da Sessão
            modified_text(
              text: 'Top Rated Movies',
              color: Colors.white,
              size: 28,
            ),
            //Conteúdo da Sessão
            Container(
              height: 250,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topRatedMoviesList.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => Description(
                            name: topRatedMoviesList[index]['title'] ?? '',
                            description: topRatedMoviesList[index]['overview'] ?? '',
                            bannerurl: (
                                topRatedMoviesList[index]['backdrop_path'] ==
                                    null)
                                ? 'http://image.tmdb.org/t/p/w500' +
                                topRatedMoviesList[index]['poster_path']
                                : 'http://image.tmdb.org/t/p/w500' +
                                topRatedMoviesList[index]['backdrop_path'],
                            posterurl: 'http://image.tmdb.org/t/p/w500' +
                                topRatedMoviesList[index]['poster_path'] ??
                                'http://image.tmdb.org/t/p/w500' +
                                    topRatedMoviesList[index]['backdrop_path'],
                            vote:
                            topRatedMoviesList[index]['vote_average'].toString() ??
                                'No votes',
                            launch_on: topRatedMoviesList[index]['release_date'] ?? '',
                          ),
                        );

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => Description(
                        //             name: trending[index]['title'],
                        //             description:
                        //                 trending[index]['overview'],
                        //             bannerurl:  'http://image.tmdb.org/t/p/w500'+trending[index]['backdrop_path'],
                        //             posterurl: trending[index]['poster_path'],
                        //             vote: trending[index]['vote_average'].toString(),
                        //             launch_on: trending[index]['release_date'])));

                      },
                      child: Container(
                        padding: EdgeInsets.all(2),
                        width: 250,
                        //Imagem + nome
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'http://image.tmdb.org/t/p/w500' +
                                            topRatedMoviesList[index]
                                                ['backdrop_path'])),
                              ),
                            ),
                            Container(
                              child: modified_text(
                                text: topRatedMoviesList[index]['title'] != null
                                    ? topRatedMoviesList[index]['title']
                                    : 'Loading',
                                color: Colors.white,
                                size: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
