import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopsphere/constants/global_variables.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CarouselSlider(
          items: GlobalVariables.carouselImages.map(
            (i) {
              return Builder(
                builder: (BuildContext context) => Image.network(
                  i,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              );
            },
          ).toList(),
          options: CarouselOptions(
            autoPlay: true,
            pauseAutoPlayOnTouch: true,
            viewportFraction: 1, // to take full width for one image.s
            height: 200,
          ),
        ),
      ),
    );
  }
}
