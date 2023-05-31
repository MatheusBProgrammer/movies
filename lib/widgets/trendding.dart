import 'package:flutter/material.dart';
import 'package:movies/description.dart';
import 'package:movies/utils/text.dart';

//Widget de exibição do Lançamentos
class trendingMovies extends StatelessWidget {
  //Recebe uma lista como parâmetro
  final List trending;

  const trendingMovies({Key? key, required this.trending}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(text: 'Trending Movies', color: Colors.white, size: 28),
          Container(
            height: 250,
            child: ListView.builder(
                //Ordem de Exibição e rolagem do ListView
                scrollDirection: Axis.horizontal,
                itemCount: trending.length,
                itemBuilder: (_, index) {
                  return InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => Description(
                            name: trending[index]['title'] ?? '',
                            description: trending[index]['overview'] ?? '',
                            bannerurl:
                                (trending[index]['backdrop_path'] == null)
                                    ? 'http://image.tmdb.org/t/p/w500' +
                                        trending[index]['poster_path']
                                    : 'http://image.tmdb.org/t/p/w500' +
                                        trending[index]['backdrop_path'],
                            posterurl: 'http://image.tmdb.org/t/p/w500' +
                                    trending[index]['poster_path'] ??
                                'http://image.tmdb.org/t/p/w500' +
                                    trending[index]['backdrop_path'],
                            vote: trending[index]['vote_average'].toString() ??
                                'No votes',
                            launch_on: trending[index]['release_date'] ?? '',
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
                        width: 150,
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
                                              trending[index]['poster_path']))),
                            ),
                            Container(
                              child: modified_text(
                                text: trending[index]['title'] != null
                                    ? trending[index]['title']
                                    : 'Loading',
                                color: Colors.white,
                                size: 12,
                              ),
                            )
                          ],
                        ),
                      ));
                }),
          )
        ],
      ),
    );
  }
}
