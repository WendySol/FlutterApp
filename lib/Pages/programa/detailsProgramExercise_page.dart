import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:proyecto_codigo/models/resProfileRecovery_model.dart' as log;
import 'package:proyecto_codigo/models/resResEvaProgram_model.dart';
import 'package:proyecto_codigo/utils/httphelper.dart';
import 'package:proyecto_codigo/utils/preferences_user.dart';

import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter/cupertino.dart';

class DetailsProgramPage extends StatefulWidget {
  DetailsProgramPage();

  @override
  _DetailsProgramPageState createState() => _DetailsProgramPageState();
}

class _DetailsProgramPageState extends State<DetailsProgramPage> {
  //final controller = PageController(viewportFraction: 0.8);
  final _currentPageNotifier = ValueNotifier<int>(0);

  log.Profile pro;
  String token;
  String idPro;
  String id;

  @override
  void initState() {
    recuperarIdUser();
    super.initState();
  }

  void recuperarIdUser() async {
    id = await Preferencias().getIdUser();
    token = await Preferencias().getUserToken();

    log.Profile profileRecup =
        await HttpHelper().consultarUsuario(idPro, token);
    print(profileRecup);
    setState(() {
      idPro = profileRecup.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Routine routinesProgram = ModalRoute.of(context).settings.arguments;

    final _pageController =
        PageController(viewportFraction: 0.9, initialPage: 0);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("${routinesProgram.name}"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          _buildCircleIndicator(routinesProgram.exercises),
          Expanded(
            child: PageView.builder(
                controller: _pageController,
                itemCount: routinesProgram.exercises.length,
                onPageChanged: (int index) {
                  _currentPageNotifier.value = index;
                },
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          margin: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: Colors.cyan[800],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          height: 600,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: FadeInImage(
                                  image: NetworkImage(
                                      routinesProgram.exercises[index].urlGif),
                                  height: screenSize.height * 0.5,
                                  width: screenSize.width * 0.6,
                                  fit: BoxFit.fill,
                                  placeholder:
                                      AssetImage("assets/no-image.jpg"),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Nombre :  '),
                                  Text(
                                      '${routinesProgram.exercises[index].name}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('restSerie :  '),
                                  Text(
                                      '${routinesProgram.exercises[index].restSerie}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('series :  '),
                                  Text(
                                      '${routinesProgram.exercises[index].series}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('restExercise :  '),
                                  Text(
                                      '${routinesProgram.exercises[index].restExercise}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),

      /*  Container(
        child: Column(children: [
          cardSwiper(routinesProgram),
          footer(routinesProgram),
          // Text("Holaaaa"),
          // Text("Holaaaa"),
          // Text("Holaaaa"),
          // Text("Holaaaa"),
        ]),
      ), */
    );

    // indicatorLayout: PageIndicatorLayout.COLOR,
    // autoplay: false,
    // itemCount: routinesProgram.exercises.length,
    // pagination: new SwiperPagination(),
    //control: new SwiperControl(),
    //));
    //GestureDetector(
    //   onTap: () {
    //     // Navigator.pushNamed(context, 'muestraEjercicio',
    //     //           arguments: routinesProgram.exercises[i]);
    //   },
    //   child: Container(
    //     height: 110,
    //     width: double.infinity,
    //     margin:
    //         EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 10),
    //     decoration: BoxDecoration(
    //         image: DecorationImage(
    //           image: NetworkImage(
    //             routinesProgram.exercises[i].urlImage,
    //           ), // AssetImage("assets/brazos.jpg"),
    //           //AssetImage("assets/brazos.jpg"),
    //           fit: BoxFit.cover,
    //           colorFilter:
    //               ColorFilter.mode(Colors.black54, BlendMode.darken),
    //         ),
    //         borderRadius: BorderRadius.circular(10)),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           routinesProgram.exercises[i].name,
    //           style: TextStyle(
    //               color: Colors.white,
    //               //color: Theme.of(context).accentColor,
    //               fontSize: 24,
    //               fontWeight: FontWeight.w800),
    //         ),
    //         SizedBox(height: 10),
    //         Text(
    //           "${routinesProgram.exercises[i].type}",
    //           style: TextStyle(
    //               color: Colors.white,
    //               fontSize: 20,
    //               fontWeight: FontWeight.w400),
    //         ),
    //         SizedBox(height: 10),
    //       ],
    //     ),
    //   ),
    // );

    // }));
  }

  _buildCircleIndicator(List<Exercise> routina) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 20,
      child: CirclePageIndicator(
        selectedDotColor: Colors.black,
        dotColor: Colors.grey[400],
        itemCount: routina.length,
        currentPageNotifier: _currentPageNotifier,
      ),
    );
  }

  Widget cardSwiper(Routine routinesProgram) {
    final screenSize = MediaQuery.of(context).size;
    return Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          //height: 200,
          child: Swiper(
            // onTap: (int value) {
            //   setState(() {
            //     value =
            //   });
            // },
            itemWidth: screenSize.width * 0.8,

            itemHeight: screenSize.height * 0.55,

            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      image:
                          NetworkImage(routinesProgram.exercises[index].urlGif),
                      height: screenSize.height * 0.5,
                      width: screenSize.width * 0.6,
                      fit: BoxFit.fill,
                      placeholder: AssetImage("assets/no-image.jpg"),
                    ),
                  ),
                  //         Text(
                  //   routinesProgram.exercises[index].name,
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       //color: Theme.of(context).accentColor,
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.w800),
                  // ),
                  //Text(routinesProgram.exercises[index].type.toString())
                ],
              );
            },

            indicatorLayout: PageIndicatorLayout.COLOR,

            autoplay: false,

            itemCount: routinesProgram.exercises.length,

            //itemWidth: 300,

            //itemHeight: 300,

            pagination: SwiperPagination(),

            //control: new SwiperControl(),

            layout: SwiperLayout.STACK,
          ),
        ),
      ),
    );
  }

  Widget footer(Routine routinesProgram) {
    return Container(
      width: 200,
      height: 50,
      child: ListView.builder(
        itemCount: routinesProgram.exercises.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Text(
                routinesProgram.exercises[index].name,
                style: TextStyle(
                    color: Colors.black,

                    //color: Theme.of(context).accentColor,

                    fontSize: 24,
                    fontWeight: FontWeight.w800),
              ),
              Text(routinesProgram.exercises[index].series.toString())
            ],
          );
        },
      ),
    );
    //Container(
    //   width: double.infinity,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Container(
    //           padding: EdgeInsets.only(left: 20.0),
    //           child: Text('Populares',
    //               style: Theme.of(context).textTheme.subhead)),
    //       SizedBox(height: 5.0),
    //       Expanded(
    //         child: ListView.builder(
    //           itemCount: routinesProgram.exercises.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             return Text(
    //               routinesProgram.exercises[index].name,
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   //color: Theme.of(context).accentColor,
    //                   fontSize: 24,
    //                   fontWeight: FontWeight.w800),
    //             );
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
