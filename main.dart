import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:sliding_window/textstyle.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main(List<String> args) {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // Using "static" so that we can easily access it later

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      theme: ThemeData.dark(),

      darkTheme: ThemeData.dark(),

      home: const slidingApp(),
    );
  }
}

class slidingApp extends StatefulWidget {
  const slidingApp({super.key});

  @override
  State<slidingApp> createState() => _slidingAppState();
}

class _slidingAppState extends State<slidingApp> with TickerProviderStateMixin {
  int activeIndex = 0;
  final controlller =
      CarouselController(); //this is a controller variable of a carouselcontroller class to controll the sliding effect, we can use this variable to controll the effects of sliding and assign to this any button to controll the sliding effect
  animateToslide(int index) => controlller.animateToPage(index);
  final imageList = [
    "https://th.bing.com/th/id/OIP.vRbEf7cGdFda2LBP9yMP9AHaER?w=302&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
    "https://th.bing.com/th/id/OIP.SwYwwi-pKPGwJ4ong6bZ_wHaEK?w=265&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
    "https://th.bing.com/th/id/OIP.4GLBLAz94YgCvB2C6hRU3gHaEo?w=267&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
    "https://th.bing.com/th/id/OIP.b_MrNDt-VqNnlzswfkfF8QHaEo?w=267&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
    "https://th.bing.com/th/id/OIP.b_MrNDt-VqNnlzswfkfF8QHaEo?w=267&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
  ];

  @override
  Widget build(BuildContext context) {
    Widget buildImage(String url, int index) {
      return SizedBox(
        //width: 320,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            //shape: BoxShape.circle
          ),
          /*surfaceTintColor: const Color.fromARGB(255, 203, 14, 0),
            color: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            elevation: 20,*/
          margin: const EdgeInsets.symmetric(
              horizontal: 0), //spacing between the images

          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    Widget buldIndicator() {
      return AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        onDotClicked:
            animateToslide, //this is for slide the page by tapping on the dots
        count: imageList.length,
        effect: const JumpingDotEffect(
          dotHeight: 15,
          dotWidth: 15,
          dotColor: Color.fromRGBO(161, 191, 212, 1),
          activeDotColor: Color.fromARGB(255, 19, 5, 150),
        ),
        /* effect: const SlideEffect(
          spacing: 8.0,
          radius: 10,
          dotWidth: 24.0,
          dotHeight: 16.0,
          paintStyle: PaintingStyle.stroke,
          strokeWidth: 1.5,
          dotColor: Colors.grey,
          activeDotColor: Colors.indigo,
        ),*/
      );
    }

    return Scaffold(
      backgroundColor: Colors.white60,
      drawer: const Drawer(),
      appBar: AppBar(
        actions: const [
          Icon(
            Icons.notifications,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.face,
          )
        ],
        title: const Text(
          "Sync Verse",
          style: TextStyle(
              color: Color.fromRGBO(6, 28, 94, 0.527),
              fontWeight: FontWeight.w700,
              fontSize: 18),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        color: Colors.white60,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.27, //
              margin: const EdgeInsets.only(top: 5),
              child: Center(
                child: Stack(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarouselSlider.builder(
                      itemCount: imageList.length,
                      options: CarouselOptions(
                        initialPage:
                            0, //setting the one page as a initial page any page can be the initial page by setting this
                        // enlargeStrategy: CenterPageEnlargeStrategy.height,
                        enlargeCenterPage: true,
                        height: 246,

                        enableInfiniteScroll:
                            true, //means it stop the scrolling at the begning and end of the image
                        //autoPlay: true,
                        //pageSnapping: false,//means scrolling every pixel check it by make it true
                        // reverse: true,
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        viewportFraction: 0.7,
                        // 1, //setting how many images display on the display at a time
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        },
                      ),
                      itemBuilder: (context, index, realindex) {
                        final urlImage = imageList[index];
                        return buildImage(urlImage, index);
                      },
                    ),
                    /*const SizedBox(
                      height: 30,
                    ),*/
                    Container(
                        height: MediaQuery.of(context).size.height * 0.27,
                        alignment: Alignment.bottomCenter,
                        margin: const EdgeInsets.only(
                            //top: 180,
                            //bottom: 50,
                            ),
                        child: buldIndicator()),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Card(
              color: Colors.white70,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40))),
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (ctx, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 12,
                              bottom: 5,
                              right: 5,
                              left: 5,
                            ),
                            height: MediaQuery.of(context).size.height * 0.18,
                            width: MediaQuery.of(context).size.width * 1,
                            child: Card(
                              color: const Color.fromARGB(255, 201, 242, 244),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              elevation: 10,
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.all(5),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: const Card(
                                        color: Colors.white,
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      )),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.58,
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Sync Verse",
                                          style: titleStyle,
                                        ),
                                        const Center(
                                          child: Text(
                                            "best company to provide fundamental and elements to secure your house and business",
                                            style: subtitleStyle,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      255, 167, 242, 247),
                                                ),
                                                onPressed: () {},
                                                child: const Text(
                                                  "3000",
                                                  style: titleStyle,
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        Colors.orangeAccent),
                                                onPressed: () {},
                                                child: const Text(
                                                  "Buy",
                                                  style: titleStyle,
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            height: MediaQuery.of(context).size.height * 0.18,
                            width: MediaQuery.of(context).size.width * 1,
                            child: Card(
                              color: const Color.fromARGB(255, 201, 242, 244),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              elevation: 10,
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.all(5),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: const Card(
                                        color: Colors.white,
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      )),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.58,
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Sync Verse",
                                          style: titleStyle,
                                        ),
                                        const Center(
                                          child: Text(
                                            "best company to provide fundamental and elements to secure your house and business",
                                            style: subtitleStyle,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      255, 167, 242, 247),
                                                ),
                                                onPressed: () {},
                                                child: const Text(
                                                  "3000",
                                                  style: titleStyle,
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        Colors.orangeAccent),
                                                onPressed: () {},
                                                child: const Text(
                                                  "Buy",
                                                  style: titleStyle,
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            height: MediaQuery.of(context).size.height * 0.18,
                            width: MediaQuery.of(context).size.width * 1,
                            child: Card(
                              color: const Color.fromARGB(255, 201, 242, 244),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              elevation: 10,
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.all(5),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: const Card(
                                        color: Colors.white,
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      )),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.58,
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Sync Verse",
                                          style: titleStyle,
                                        ),
                                        const Center(
                                          child: Text(
                                            "best company to provide fundamental and elements to secure your house and business",
                                            style: subtitleStyle,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      255, 167, 242, 247),
                                                ),
                                                onPressed: () {},
                                                child: const Text(
                                                  "3000",
                                                  style: titleStyle,
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        Colors.orangeAccent),
                                                onPressed: () {},
                                                child: const Text(
                                                  "Buy",
                                                  style: titleStyle,
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            height: MediaQuery.of(context).size.height * 0.18,
                            width: MediaQuery.of(context).size.width * 1,
                            child: Card(
                              color: const Color.fromARGB(255, 201, 242, 244),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              elevation: 10,
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.all(5),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: const Card(
                                        color: Colors.white,
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      )),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.58,
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Sync Verse",
                                          style: titleStyle,
                                        ),
                                        const Center(
                                          child: Text(
                                            "best company to provide fundamental and elements to secure your house and business",
                                            style: subtitleStyle,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      255, 167, 242, 247),
                                                ),
                                                onPressed: () {},
                                                child: const Text(
                                                  "3000",
                                                  style: titleStyle,
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        Colors.orangeAccent),
                                                onPressed: () {},
                                                child: const Text(
                                                  "Buy",
                                                  style: titleStyle,
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
