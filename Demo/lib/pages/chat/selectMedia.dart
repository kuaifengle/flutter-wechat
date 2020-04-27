import 'package:flutter/material.dart';




returnMediaBox(context) {
  return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: 170.0,
              color: Color(0xFFededed),
              child: Wrap(
                spacing: 25.0,
                runSpacing: 10.0,
                children: <Widget>[
                  Container(
                    width: (MediaQuery.of(context).size.width - 100) / 4,
                    height: (MediaQuery.of(context).size.width - 100) / 4,
                    color: Color(0xFFffffff),
                    child: IconButton(
                      iconSize: 50.0,
                      icon: Icon(Icons.photo_size_select_actual,
                          color: Colors.black38),
                      onPressed: () {
                        // getImage();
                      },
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 100) / 4,
                    height: (MediaQuery.of(context).size.width - 100) / 4,
                    color: Color(0xFFffffff),
                    child: IconButton(
                      iconSize: 50.0,
                      icon: Icon(Icons.videocam, color: Colors.black38),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 100) / 4,
                    height: (MediaQuery.of(context).size.width - 100) / 4,
                    color: Color(0xFFffffff),
                    child: IconButton(
                      iconSize: 50.0,
                      icon: Icon(Icons.linked_camera, color: Colors.black38),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 100) / 4,
                    height: (MediaQuery.of(context).size.width - 100) / 4,
                    color: Color(0xFFffffff),
                    child: IconButton(
                      iconSize: 50.0,
                      icon: Icon(Icons.add_location, color: Colors.black38),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 100) / 4,
                    height: (MediaQuery.of(context).size.width - 100) / 4,
                    color: Color(0xFFffffff),
                    child: IconButton(
                      iconSize: 50.0,
                      icon: Icon(Icons.library_music, color: Colors.black38),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 100) / 4,
                    height: (MediaQuery.of(context).size.width - 100) / 4,
                    color: Color(0xFFffffff),
                    child: IconButton(
                      iconSize: 50.0,
                      icon: Icon(Icons.library_books, color: Colors.black38),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 100) / 4,
                    height: (MediaQuery.of(context).size.width - 100) / 4,
                    color: Color(0xFFffffff),
                    child: IconButton(
                      iconSize: 50.0,
                      icon: Icon(Icons.video_library, color: Colors.black38),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 100) / 4,
                    height: (MediaQuery.of(context).size.width - 100) / 4,
                    color: Color(0xFFffffff),
                    child: IconButton(
                      iconSize: 50.0,
                      icon: Icon(Icons.local_activity, color: Colors.black38),
                      onPressed: () {},
                    ),
                  ),
                ],
              )),
        ],
      ));
}
