import 'package:flutter/material.dart';
import 'package:network_test/loading_body.dart';
import 'package:network_test/post_model.dart';
import 'package:network_test/widget_message_container.dart';

import 'network.dart';

class PageFirst extends StatefulWidget {
  PageFirst({Key key}) : super(key: key);

  @override
  _PageFirstState createState() => _PageFirstState();
}

class _PageFirstState extends State<PageFirst> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  List<Post> mData = new List<Post>();
  bool isLoading = false;
  Future<void> getPost() async {
    ETPHttp().get("https://jsonplaceholder.typicode.com/posts",
        successCallback: (value) {
      setStateIfMounted(() {
        mData = allPostsFromJson(value);
      });
    }, errorCallback: (value) {
      setStateIfMounted(() {
        mData = [];
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
    }, loadingCallback: (value) {
      setStateIfMounted(() {
        isLoading = value;
      });
      if (!isLoading) {
        return null;
      }
    });
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  void postPost() {
    ETPHttp().post("https://jsonplaceholder.typicode.com/posts",
        body: new Post(title: "Başlık", body: "ascsac", id: 123, userId: 123),
        successCallback: (value) {
      setStateIfMounted(() {
        mData = allPostsFromJson(value);
      });
    }, errorCallback: (value) {
      setStateIfMounted(() {
        mData = [];
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
    }, loadingCallback: (value) {
      setStateIfMounted(() {
        isLoading = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingBody(
        loadingText: "Yükleniyor...",
        isLoading: false,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color(0xffd8d8d8),
          appBar: AppBar(
            title: Text("ETPHttp"),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PageFirst()));
                    },
                    child: Icon(
                      Icons.pages,
                      size: 26.0,
                    ),
                  ))
            ],
          ),
          body: MessageContainer(
            isShow: mData.isEmpty,
            actionTap: getPost,
            actionText: "Yenile",
            icon: Icons.list,
            message: "Liste Boş",
            child: 
              RefreshIndicator(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var item = mData[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.body),
                    ),
                  );
                },
                itemCount: mData.length,
              ),
              onRefresh: getPost)
            
          ),
        ));
  }
}
