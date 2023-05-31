import 'package:flutter/material.dart';
import 'package:movies/utils/text.dart';

import '../description.dart';

class tvShowsMovies extends StatelessWidget {
  final List tvShowsList;

  const tvShowsMovies({Key? key, required this.tvShowsList}) : super(key: key);

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
            text: 'Tv Shows',
            color: Colors.white,
            size: 28,
          ),
          //Conteúdo da Sessão

          Container(
              height: 250,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tvShowsList.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => Description(
                            name: tvShowsList[index]['name'] ?? '',
                            description: tvShowsList[index]['overview'] ?? '',
                            bannerurl: (
                                        tvShowsList[index]['backdrop_path'] ==
                                    null)
                                ? 'http://image.tmdb.org/t/p/w500' +
                                    tvShowsList[index]['poster_path']
                                : 'http://image.tmdb.org/t/p/w500' +
                                    tvShowsList[index]['backdrop_path'],
                            posterurl: 'http://image.tmdb.org/t/p/w500' +
                                    tvShowsList[index]['poster_path'] ??
                                'http://image.tmdb.org/t/p/w500' +
                                    tvShowsList[index]['backdrop_path'],
                            vote:
                                tvShowsList[index]['vote_average'].toString() ??
                                    'No votes',
                            launch_on: tvShowsList[index]['release_date'] ?? '',
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(2),
                        width: 140,
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
                                              tvShowsList[index]
                                                  ['poster_path']))),
                            ),
                            Container(
                              child: modified_text(
                                color: Colors.white,
                                size: 12,
                                text: tvShowsList[index]['name'] != null
                                    ? tvShowsList[index]['original_name']
                                    : 'Loading...',
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
