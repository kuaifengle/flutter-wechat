import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SearchPage extends StatefulWidget{
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{
  Widget searchWrap;

  var _searchController = new TextEditingController();
  var _focusNode = new FocusNode();

  buildSearchList(searchList) {
    List <Widget>widgetList = [];
      for(var i = 1; i < searchList.length; i++) {
        var text = searchList[i];
          widgetList.add(
            new GestureDetector(
              child: 
                new Container(
                  height: 40.0,
                  padding: new EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    color: Colors.black12,
                    borderRadius:  new BorderRadius.circular(10.0)
                  ),
                  child: new Text('${text}',style:new TextStyle(
                    color: Colors.black
                  ),)
                ),
                onTap: (){
                  _searchController.value = new TextEditingValue(text: text);
                },
            )
          );
      }
      
      setState((){
        searchWrap = new Wrap(
          spacing: 10.0, // gap between adjacent chips
          runSpacing: 6.0, 
          children: widgetList,
        );
      }); 
    }

    void getSearchList() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var arr = prefs.getString('searchList');

      var searchList = arr == null || arr.split(',') == null ? [] : arr.split(',');
      buildSearchList(searchList);
    }

    void initState(){
      getSearchList();
    }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: new Container(
        child: new ListView(
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.all(10.0),
              child: new TextField(
                focusNode: _focusNode,
                autofocus: false,
                decoration: new InputDecoration(
                  icon: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: (){
                      _focusNode.unfocus();
                      _searchController.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () async{
                      _searchController.clear();
                      // var value = _searchController.text;
                      // if (value != null && value != '') {
                      //   SharedPreferences prefs = await SharedPreferences.getInstance();
                      //   prefs.setString('searchList', prefs.getString('searchList') + ','+ value.toString());
                      //   getSearchList();
                      // }
                    },
                  )
                ),
                onSubmitted: (String value) async{
                  if (value != null && value != '') {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var arr = prefs.getString('searchList');
                    var searchList = arr == null || arr.split(',') == null ? '' : arr;
                    prefs.setString('searchList', searchList + ','+ value.toString());
                    getSearchList();
                  }
                },
                controller: _searchController,
              ),
            ),
            new Container(
              margin: new EdgeInsets.all(10.0),
              child: new Row(
                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('历史搜索', style: new TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold
                  )),
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('searchList', '');
                      getSearchList();
                    },
                  )
                ]
              )
            ),
            new Container(
              padding: new EdgeInsets.all(10.0),
              child: searchWrap
            ),
          ],
        )
      )
    );
  }
}