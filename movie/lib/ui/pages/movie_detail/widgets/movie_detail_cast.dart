import 'package:flutter/material.dart';
import 'package:vinhcine/configs/app_uri.dart';

import '../../../../configs/app_color.dart';
import '../../../../models/entities/movie.dart';

class MovieDetailAvailable extends StatelessWidget {
  final Movie? movie;

  const MovieDetailAvailable({super.key, this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Available on",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _labelWidget(
                  label: "Netflix",
                  color: AppColor.black,
                  imageString: XR().assetsImage.ic_netflix),
              const SizedBox(width: 10),
              _labelWidget(
                  label: "Hotstar+",
                  color: Color(0xff091E82),
                  imageString: XR().assetsImage.ic_disney_plus),
              const SizedBox(width: 10),
              _labelWidget(
                  label: "YouTube",
                  color: Color(0xffC82A1D),
                  imageString: XR().assetsImage.ic_youtube),
            ],
          )
        ],
      ),
    );
  }

  Widget _availableWidget() {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(
                  "https://image.tmdb.org/t/p/w500/6MKr3KgOLmzOP6MSuZERO41Lpkt.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Flexible(
          child: Text(
            "Tom Holland",
            style: TextStyle(
              fontSize: 12,
              color: AppColor.black,
            ),
          ),
        )
      ],
    );
  }

  Widget _labelWidget(
      {required String label,
      required Color color,
      required String imageString}) {
    return Container(
      constraints: BoxConstraints(maxHeight: 34),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              constraints: BoxConstraints(maxHeight: 20, maxWidth: 20),
              child: Image.asset(imageString, height: 20, width: 20)),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: AppColor.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
