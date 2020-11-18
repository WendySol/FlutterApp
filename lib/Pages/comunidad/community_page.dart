import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  CommunityPage({Key key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final CategoriesScroller categoriesScroller = CategoriesScroller();

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  bool _hasMore;
  int _pageNumber;
  bool _error;
  bool _loading;
  final int _defaultPhotosPerPageCount = 10;
  List<Photo> _photos;
  final int _nextPageThreshold = 5;

  @override
  void initState() {
    super.initState();
    _hasMore = true;
    _pageNumber = 1;
    _error = false;
    _loading = true;
    _photos = [];
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    try {
      final response = await http.get(
          "https://jsonplaceholder.typicode.com/photos?_page=$_pageNumber");
      List<Photo> fetchedPhotos = Photo.parseList(json.decode(response.body));
      setState(() {
        _hasMore = fetchedPhotos.length == _defaultPhotosPerPageCount;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _photos.addAll(fetchedPhotos);
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          // leading: Builder(
          //     builder: (context) => IconButton(
          //           icon: new Icon(Icons.menu, color: Colors.black),
          //           onPressed: () => Scaffold.of(context).openDrawer(),
          //         )),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            
          ],
        ),
        //drawer: MenuBarra(context),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: size.height,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Siguiendo",
                        style: TextStyle(
                            color: Colors.cyan[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        "Amigos",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: closeTopContainer ? 0 : 1,
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: size.width,
                        alignment: Alignment.topCenter,
                        height: closeTopContainer ? 0 : categoryHeight,
                        child: categoriesScroller),
                  ),
                  Expanded(child: getBody()),
                ],
              ),
            )
          ]),
        ));
  }

  Widget getBody() {
    if (_photos.isEmpty) {
      if (_loading) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (_error) {
        return Center(
            child: InkWell(
          onTap: () {
            setState(() {
              _loading = true;
              _error = false;
              fetchPhotos();
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text("Error while loading photos, tap to try agin"),
          ),
        ));
      }
    } else {
      return ListView.builder(
          itemCount: _photos.length + (_hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _photos.length - _nextPageThreshold) {
              fetchPhotos();
            }
            if (index == _photos.length) {
              if (_error) {
                return Center(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      _loading = true;
                      _error = false;
                      fetchPhotos();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text("Error while loading photos, tap to try agin"),
                  ),
                ));
              } else {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ));
              }
            }
            final Photo photo = _photos[index];
            return Card(
              child: Column(
                children: <Widget>[
                  Image.network(
                    photo.thumbnailUrl,
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    height: 160,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(photo.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ],
              ),
            );
          });
    }
    return Container();
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 180;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              Column(
                children: [
                  Container(
                      width: 70,
                      height: categoryHeight,
                      margin: EdgeInsets.only(right: 10),
                      child: Container(
                        width: 100.00,
                        height: 100.00,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          image: new DecorationImage(
                            image: ExactAssetImage('assets/rostro7.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  Text("Nadia")
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 70,
                    margin: EdgeInsets.only(right: 10),
                    height: categoryHeight,
                    child: Container(
                        width: 100.00,
                        height: 100.00,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          image: new DecorationImage(
                            image: ExactAssetImage('assets/rostro3.jpg'),
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                  Text("Luz"),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 70,
                    margin: EdgeInsets.only(right: 10),
                    height: categoryHeight,
                    child: Container(
                        width: 100.00,
                        height: 100.00,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          image: new DecorationImage(
                            image: ExactAssetImage('assets/rostro5.jpg'),
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                  Text("Diana"),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 70,
                    margin: EdgeInsets.only(right: 10),
                    height: categoryHeight,
                    child: Container(
                        width: 100.00,
                        height: 100.00,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          image: new DecorationImage(
                            image: ExactAssetImage('assets/rostro2.jpg'),
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                  Text("Stef"),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 70,
                    margin: EdgeInsets.only(right: 10),
                    height: categoryHeight,
                    child: Container(
                        width: 100.00,
                        height: 100.00,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          image: new DecorationImage(
                            image: ExactAssetImage('assets/rostro1.jpg'),
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                  Text("Diego"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Photo {
  final String title;
  final String thumbnailUrl;
  Photo(this.title, this.thumbnailUrl);
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(json["title"], json["thumbnailUrl"]);
  }
  static List<Photo> parseList(List<dynamic> list) {
    return list.map((i) => Photo.fromJson(i)).toList();
  }
}
