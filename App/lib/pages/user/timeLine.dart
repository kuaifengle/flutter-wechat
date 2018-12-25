import 'package:flutter/material.dart';

class TimeLine extends StatefulWidget{
  TimeLine({Key key, this.detail}) : super(key: key);
  final detail;

  @override
  _TimeLineState createState() => new _TimeLineState();
}

class _TimeLineState extends State<TimeLine>{


  // List<Map> timeList = [
  //   {
  //     'time': '2018-12-17',
  //     'imgUrl': [
  //       ''
  //     ],
  //     'content': '如果我是DJ你会爱我吗?'
  //   },
  //   {
  //     'time': '2018-12-17',
  //     'imgUrl': [
  //       ''
  //     ],
  //     'content': '如果我是DJ你会爱我吗?'
  //   },
  //   {
  //     'time': '2018-12-17',
  //     'imgUrl': [
  //       ''
  //     ],
  //     'content': '如果我是DJ你会爱我吗?'
  //   },
  //   {
  //     'time': '2018-12-17',
  //     'imgUrl': [
  //       ''
  //     ],
  //     'content': '如果我是DJ你会爱我吗?'
  //   }
  // ];

  @override
  Widget build(BuildContext context){
    
    return new Scaffold(
      body: new ListView(
          children: <Widget>[
            new Container(
              height: 240.0,
              color: const Color(0xFFcccccc),
              child: new Stack(
                children: <Widget>[
                  new Opacity(
                    opacity: 0.4,
                    child: new Container(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(widget.detail['backgroundUrl']),
                          fit: BoxFit.fill
                        )
                      ),
                    )
                  ),
                  new Positioned(
                    top: 0,
                    child:new Container(
                      height:40.0,
                      width: MediaQuery.of(context).size.width,
                      child: new Row(
                        children: <Widget>[
                          IconButton(
                            icon: new Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 30.0),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                          new Container(
                            width: MediaQuery.of(context).size.width - 100,
                            child: new Text('TimeLine', style: new TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ), textAlign: TextAlign.center,)
                          )
                        ],
                      ),
                    ),
                  ),
                  new Positioned(
                    top: 80,
                    child: new Container(
                      width: MediaQuery.of(context).size.width,
                      child: new Column(
                        children: <Widget>[
                          new CircleAvatar(
                            radius: 40.0,
                            backgroundImage: new NetworkImage(widget.detail['imageUrl']),
                          ),
                          new Center(
                            child:  new Text(widget.detail['name'], 
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                height: 1.5       
                              ),
                            ),
                          ),
                          new Center(
                            child:  new Text('如果我是Dj你会爱我吗?', 
                              style: new TextStyle(
                                fontSize: 16.0,   
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              )
            ),
          ],
        ),
    );
  }
}