import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardPostItem extends StatelessWidget {
  final String title;
  final String image;
  final String contenu;
  final String date;
  final VoidCallback onTapItem;

  CardPostItem({this.title,this.contenu, this.image, this.date, this.onTapItem});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: onTapItem,
        child: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              //entete
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 2.0, vertical: 4.0),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                  )),
              Container(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    contenu,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                  )),
              Container(
                color: Colors.grey.withAlpha(100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.comment,
                      color: Colors.blue,
                    ),
                    FlatButton(
                        onPressed: () {},
                        child: Text(
                          "comment",
                          style: TextStyle(fontSize: 18.0, color: Colors.blue),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
