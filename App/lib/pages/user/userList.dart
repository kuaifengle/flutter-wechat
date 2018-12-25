import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './talk.dart';
import '../home/floatButton.dart';
import '../home/searchPage.dart';


class UserList extends StatefulWidget{
  @override
  _UserListState createState() => new _UserListState();
}

class _UserListState extends State<UserList>{

List<Map> userInfoList = [
    {
      'name': 'kuaifengle',
      'id': 1,
      'checkInfo': 'https://github.com/kuaifengle',
      'lastTime': '20.11',
      'imageUrl': 'https://image.lingcb.net/goods/201812/2ad6f1b0-2b2c-4d71-8d0d-01679e298afc-150x150.png',
      'backgroundUrl': 'http://pic31.photophoto.cn/20140404/0005018792087823_b.jpg'
    },
    {
      'name': 'Only',
      'id': 2,
      'checkInfo': '砖石一颗即永恒',
      'lastTime': '16.18',
      'imageUrl': 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1667994205,255365672&fm=5',
      'backgroundUrl': 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544591217574&di=ccd0b58aa181af2a0ef5dfc44266fde2&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D0f22919fb8b7d0a26fc40cdea3861c7c%2F0df431adcbef7609e92064b224dda3cc7cd99ef0.jpg'

    },
    {
      'name': '哈哈',
      'id': 3,
      'checkInfo': '呵呵',
      'lastTime': '24.00',
      'imageUrl': 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2406161785,701397900&fm=5',
      'backgroundUrl': 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544591217574&di=dd17c39c2f725d8e3f4fd69a668c5d9b&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D93cf8a986f380cd7f213aaaec92dc741%2F902397dda144ad347a33f2afdaa20cf431ad850d.jpg'

    },
    {
      'name': '呵呵',
      'id': 4,
      'checkInfo': '干嘛,呵呵, 去洗澡',
      'lastTime': '10.20',
      'imageUrl': 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1853832225,307688784&fm=5',
      'backgroundUrl': 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544591217574&di=2189213cef3d70c482f52359d2727d15&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F810a19d8bc3eb13584856f6fac1ea8d3fc1f44a0.jpg'

    },
    {
      'name': 'Dj',
      'id': 5,
      'checkInfo': '如果我是Dj你会爱我吗',
      'lastTime': '19.28',
      'imageUrl': 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2247692397,1189743173&fm=5',
      'backgroundUrl': ''

    }
  ];

  final SlidableController slidableController = new SlidableController();

   returnUserItem(item) {
    return new GestureDetector(
      child: new Slidable(
        controller: slidableController,
        delegate: new SlidableDrawerDelegate(),
        actionExtentRatio: 0.2,
        child: new Container(
          decoration: new BoxDecoration(
            border: new BorderDirectional(bottom: new BorderSide(color: Color(0xFFe1e1e1), width:1.0))
          ),
          child: new ListTile(
            leading: new CircleAvatar(
              backgroundImage: new NetworkImage('${item['imageUrl']}'),
            ),
            title: new Text('${item['name']}'),
            subtitle: new Text('${item['checkInfo']}'),
            trailing: new Text('${item['lastTime']}'),
          ),
        ),
        secondaryActions: <Widget>[
          new IconSlideAction(
            caption: '置顶',
            color: Color(0xFF61ab32),
            icon: Icons.vertical_align_top,
            onTap: (){
              // Navigator.of(context).push(
              //   new MaterialPageRoute(
              //    builder: (_) => new Talk(detail: item)
              //   )
              // );
            }
          ),
          new IconSlideAction(
            caption: '删除会话',
            color: Color(0xFFf76767),
            icon: Icons.delete_outline,
            onTap: () => _showSnackBar('Delete'),
          ),
        ],
      ),
      onTap: (){
        Navigator.of(context).push(
          new MaterialPageRoute(builder: (_){
            return new Talk(detail: item);
          })
        );
      },
    );
  }

  getUserList() {
    List widgetList = <Widget>[ 
      new GestureDetector(
        child: new Container(
          height: 50.0,
          color: new Color(0xFFefeef3),
          child: ListTile(
            leading: Icon(Icons.search),
            title: new Text('Search'),
            trailing: new IconButton(
              icon: Icon(Icons.keyboard_voice),
              onPressed: (){
                print('语音');
              },
            ),
          )
        ),
        onTap: (){
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (_) => new SearchPage()
            )
          );
        },
      ),
    ];

    for (var i = 0; i < userInfoList.length; i++) {
      widgetList.add(returnUserItem(userInfoList[i]));
    }
    return widgetList;
  }

  
  _showSnackBar(val) {
    print(val);
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            child: new ListView(
              children: getUserList(),
            ),
          ),
          new MenuFloatButton()
        ],
      )
    );
  }
}