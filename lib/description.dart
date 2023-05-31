import 'package:flutter/material.dart';
import 'package:movies/utils/text.dart';

class Description extends StatelessWidget {
  final String name, description, bannerurl, posterurl, launch_on, vote;

  const Description(
      {Key? key,
      required this.name,
      required this.description,
      required this.bannerurl,
      required this.posterurl,
      required this.vote,
      required this.launch_on})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      height: 250,
                      child: Image.network(
                        bannerurl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: modified_text(
                          text: 'Avarage Rating - ' + vote + ' ⭐ ',
                          color: Colors.white,
                          size: 22,
                        ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  modified_text(text: name, color: Colors.white, size: 24),
                  modified_text(
                      text: launch_on.length == 0
                          ? ''
                          : 'Realising On ' + launch_on,
                      color: Colors.white,
                      size: 16),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  height: 200,
                  width: 140,
                  child: Image.network(
                    posterurl,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 250,
                    child: modified_text(
                      text: description,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
