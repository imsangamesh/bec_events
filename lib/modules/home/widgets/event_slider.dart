import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyEventSlider extends StatelessWidget {
  const MyEventSlider(this.eventData, {Key? key}) : super(key: key);

  final Map<String, dynamic> eventData;

  @override
  Widget build(BuildContext context) {
    //

    return CarouselSlider.builder(
      itemCount: eventData['images'].length,
      options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
      itemBuilder: (context, index, realIndex) {
        return SizedBox(
          width: double.infinity,
          child: Image.network(
            eventData['images'][index],
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    value: loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
