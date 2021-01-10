import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmov/models/movie.dart';
import 'package:filmov/screens/details_screen.dart';
import 'package:filmov/util/constants.dart';
import 'package:filmov/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieCard extends StatelessWidget {
  final Function onTap;
  final Movie movie;
  MovieCard({
    @required this.movie,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap:onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(8),
        height: SizeConfig.blockSizeVertical * 35,
        width: SizeConfig.blockSizeHorizontal * 35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: movie.backdropPath != null
                  ? "$kImagePath${movie.backdropPath}"
                  : "https://bit.ly/34gLECx",
              imageBuilder: (context, imageProvider) =>
                  movie.backdropPath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: imageProvider,
                            height: SizeConfig.blockSizeVertical * 25,
                            width: SizeConfig.blockSizeHorizontal * 35,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: SizeConfig.blockSizeVertical * 25,
                          width: SizeConfig.blockSizeHorizontal * 35,
                          child: Image.network(
                            "https://bit.ly/34gLECx",
                            fit: BoxFit.cover,
                          ),
                        ),
              placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF764bc4),
                ),
                height: SizeConfig.blockSizeVertical * 25,
                width: SizeConfig.blockSizeHorizontal * 35,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: SizeConfig.blockSizeVertical * 25,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: SizeConfig.blockSizeVertical * 25,
                width: SizeConfig.blockSizeHorizontal * 35,
                child: Column(
                  children: [
                    Icon(Icons.error),
                    Text(
                      error.toString(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Flexible(
              child: Text(
                movie.title != null ? movie.title : "",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
