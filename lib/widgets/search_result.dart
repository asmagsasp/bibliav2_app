import 'package:flutter/material.dart';
import '../conection/api.dart';
import 'notice.dart';

class SearchResultPage extends StatefulWidget{

  final String query;

  SearchResultPage(this.query);

  @override
  State<StatefulWidget> createState() {
   return new _SearchResultState();
  }

}

class _SearchResultState extends State<SearchResultPage> with TickerProviderStateMixin{

  List _news = new List();
  var carregando = false;
  var empty = false;

  var repository = new NewsApi();

  @override
  void initState() {
    super.initState();
    loadSearch(widget.query);
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.query),
      ),
      body: _getListViewWidget(),

    );
    
  }

  Widget _getListViewWidget(){

    ListView listView = new ListView.builder(
        itemCount: _news.length,
        padding: new EdgeInsets.only(top: 5.0),
        itemBuilder: (context, index){

          return _news[index];
        }
    );

    return new Stack(
      children: <Widget>[
        listView,
        _getProgress(),
        _getEmpty()
      ],
    );

  }

  Widget _getProgress(){

    if(carregando){
      return new Container(
        child: new Center(
          child: new CircularProgressIndicator(),
        ),
      );
    }else{
      return new Container();
    }

  }

  loadSearch(query) async{

      setState((){

        carregando = true;
        empty = false;

      });

      Map result = await repository.loadSearch(query);

      setState(() {

        if(result['op']){

          result['data'].forEach((item) {
            var notice = new Notice(
                item['url_img'] == null ? '' : item['url_img'],
                item['tittle'] == null ? '' : item['tittle'],
                item['date'] == null ? '' : item['date'],
                item['description'] == null ? '' : item['description'],
                item['category'] == null ? '' : item['category'],
                item['link'] == null ? '' : item['link'],
                item['origin'] == null ? '' : item['origin'],
                new AnimationController(
                  duration: new Duration(milliseconds: 300),
                  vsync: this,
                )
            );
            _news.add(notice);
            notice.animationController.forward();
          });

        }else{

          empty = true;

        }


        carregando = false;
      }

      );

  }

  Widget _getEmpty() {

    if(empty){
      return new Container(
        child: new Center(
          child: new Text("Nenhuma noticia encontrada :-("),
        ),
      );
    }else{
      return new Container();
    }
  }

}