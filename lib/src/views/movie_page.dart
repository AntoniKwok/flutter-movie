import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_intro/src/models/movie_response.dart';
import 'package:flutter_app_intro/src/services/api_service.dart';
import 'package:flutter_app_intro/src/util/destination.dart';
import 'package:flutter_app_intro/src/util/shimmer_loading.dart';
import 'file:///Users/moka/AI/Latihan/chopper_example/lib/resources/config.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key key, this.destination}) : super(key: key);
  final Destination destination;

  @override
  _MoviePageState createState() => _MoviePageState(destination);
}

class _MoviePageState extends State<MoviePage> {
  final Destination destination;

  _MoviePageState(this.destination);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(destination.title)),
        body: FutureBuilder<Response<MovieResponse>>(
          future: Provider.of<ApiService>(context).getAllMovies(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  log(snapshot.error);
                  return new Text('Error: ${snapshot.error}');
                } else
                  return createGridListView(context, snapshot.data.body);
            }
          },
        ));
  }

  Widget createGridListView(BuildContext context, MovieResponse movieResponse) {
    return GridView.builder(
        itemCount: movieResponse.results.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, position) {
          String title = movieResponse.results[position].title;
          return new GestureDetector(
              child: new Card(
                elevation: 5.0,
                semanticContainer: true,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: Config.IMAGE_URL +
                      movieResponse.results[position].imageUrl,
                  placeholder: (context, url) => new ShimmerLoading(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              onTap: () {
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  child: new CupertinoAlertDialog(
                    title: new Expanded(
                        child : new Column(
                          children: <Widget>[
                            new Text("$title"),
                          ],
                        )
                    ),
                    actions: <Widget>[
                      new FlatButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: new Text("OK"))
                    ],
                  ),
                );
              });
        });
  }
}
