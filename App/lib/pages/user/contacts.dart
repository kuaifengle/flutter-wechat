import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import './talk.dart';
import './detailed.dart';
import '../home/searchPage.dart';


class Contacts extends StatefulWidget{
  @override
  _ContactsState createState() => new _ContactsState();
}

class _ContactsState extends State<Contacts>{

  List a2z = ['A', 'B', 'C','D', 'E', 'F','G', 'H', 'I','J', 'K', 'L','M', 'N', 'O','P', 'Q', 'R','S', 'T', 'U','V', 'W', 'X','Y', 'Z',];

  Map<String , List<Map>> userInfoList = {
    'A': [
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
        ],
      'B': [
          {
            'name': 'kuaifengle',
            'id': 1,
            'checkInfo': 'git',
            'lastTime': '20.11',
            'imageUrl': 'https://image.lingcb.net/goods/201812/2ad6f1b0-2b2c-4d71-8d0d-01679e298afc-150x150.png',
            'backgroundUrl': 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544591217574&di=cbe8bb555ee75a64d442738db9cb4e01&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D5f1716e99a529822113e3180bfa311be%2F730e0cf3d7ca7bcb1372ed01b4096b63f624a896.jpg'

          },
          {
            'name': 'Only',
            'id': 2,
            'checkInfo': '砖石一颗即永恒',
            'lastTime': '16.18',
            'imageUrl': 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1667994205,255365672&fm=5',
            'backgroundUrl': ''

          },
          {
            'name': '哈哈',
            'id': 3,
            'checkInfo': '呵呵',
            'lastTime': '24.00',
            'imageUrl': 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2406161785,701397900&fm=5',
            'backgroundUrl': ''

          },
          {
            'name': '呵呵',
            'id': 4,
            'checkInfo': '干嘛,呵呵, 去洗澡',
            'lastTime': '10.20',
            'imageUrl': 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1853832225,307688784&fm=5',
            'backgroundUrl': ''

          },
          {
            'name': 'Dj',
            'id': 5,
            'checkInfo': '如果我是Dj你会爱我吗',
            'lastTime': '19.28',
            'imageUrl': 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2247692397,1189743173&fm=5',
            'backgroundUrl': ''

          }
        ],
      'C': [
          {
            'name': 'kuaifengle',
            'id': 1,
            'checkInfo': 'git',
            'lastTime': '20.11',
            'imageUrl': 'https://image.lingcb.net/goods/201812/2ad6f1b0-2b2c-4d71-8d0d-01679e298afc-150x150.png',
            'backgroundUrl': ''

          },
          {
            'name': 'Only',
            'id': 2,
            'checkInfo': '砖石一颗即永恒',
            'lastTime': '16.18',
            'imageUrl': 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1667994205,255365672&fm=5',
            'backgroundUrl': ''

          },
          {
            'name': '哈哈',
            'id': 3,
            'checkInfo': '呵呵',
            'lastTime': '24.00',
            'imageUrl': 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2406161785,701397900&fm=5',
            'backgroundUrl': ''

          },
          {
            'name': '呵呵',
            'id': 4,
            'checkInfo': '干嘛,呵呵, 去洗澡',
            'lastTime': '10.20',
            'imageUrl': 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1853832225,307688784&fm=5',
            'backgroundUrl': ''

          },
          {
            'name': 'Dj',
            'id': 5,
            'checkInfo': '如果我是Dj你会爱我吗',
            'lastTime': '19.28',
            'imageUrl': 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2247692397,1189743173&fm=5',
            'backgroundUrl': ''

          }
        ],
  };

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
            caption: '消息',
            color: Color(0xFF61ab32),
            icon: Icons.message,
            onTap: (){
              Navigator.of(context).push(
                new MaterialPageRoute(
                 builder: (_) => new Talk(detail: item)
                )
              );
            }
          ),
          new IconSlideAction(
            caption: '删除',
            color: Color(0xFFf76767),
            icon: Icons.delete_outline,
            onTap: () => _showSnackBar('Delete'),
          ),
        ],
      ),
      onTap: (){
        Navigator.of(context).push(
          new MaterialPageRoute(builder: (_){
            return new Detailed(detail: item);
          })
        );
      },
    );
  }

  getUserList() {
    List widgetList = <Widget>[
      new SliverToBoxAdapter(
        child:  new GestureDetector(
          child: new Container(
            height: 50.0,
            color: new Color(0xFFefeef3),
            child: ListTile(
              leading: IconButton(
                padding: EdgeInsets.all(0.0),
                alignment: Alignment.centerLeft,
                icon: Icon(Icons.arrow_back_ios,),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: new Text('Search'),
              trailing: Icon(Icons.search, color: Color(0xFF61ab32)),
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
      )

    ];

    for (var i = 0; i < a2z.length; i++) {
      if (userInfoList[a2z[i]] != null && userInfoList[a2z[i]].length > 0) {
        widgetList.add(returnSSHbuilder(a2z[i], i));
      } else {
        continue;
      }
    }
    return widgetList;
  }

  returnSSHbuilder(name, index){
    return new SliverStickyHeaderBuilder(
      builder: (context, state) {
       return returnHeader(context, state, name);
      },
      sliver: new SliverList(
        delegate: new SliverChildBuilderDelegate(
          (context, i){
            return returnListTile(context, i, name);
          },
          childCount: userInfoList[name].length,
        ),
      ),
    );
  }


  returnHeader(context, state, name) {
    return new Container(
      height: 34.0,
      color: (state.isPinned ? Color(0xFF94c875) : Color(0xFFc5c5cf))
          .withOpacity(1.0 - state.scrollPercentage),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: new Text(
        '${name}',
        style: const TextStyle(color: Color(0xFFffffff), fontWeight: FontWeight.bold),
      ),
    );
  }

  returnListTile(context, i, name) {
   return returnUserItem(userInfoList[name][i]);
  }
  
  _showSnackBar(val) {
    print(val);
  }

  var controller = new ScrollController();

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: SafeArea(
        child: new Stack(
          children: <Widget>[
            new CustomScrollView(
              controller: controller,
              slivers: getUserList()
            ),
          ],
        ),
      )
    );
  }
}