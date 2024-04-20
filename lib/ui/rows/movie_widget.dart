import 'package:flutter/material.dart';
import 'package:vinhcine/utils/widgets/my_loading_image.dart';

import '../../models/entities/movie.dart';

class MovieWidget extends StatelessWidget {
  final Movie? movie;
  final VoidCallback? onPressed;

  MovieWidget({this.movie, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  MyLoadingImage(
                    imageUrl: movie?.posterUrl ?? '',
                    size: 48,
                    borderRadius: 4,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      child: Text(movie?.title ?? '',
                          style: TextStyle(fontSize: 14, color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        onPressed: () {
          onPressed?.call();
        },
      ),
    );
  }
}
