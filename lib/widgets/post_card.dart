import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding:const EdgeInsets.symmetric( vertical: 10),
      child: Column(
        children: [
          // Header section
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ).copyWith(right: 0),
            child: Row(
              children: [
                  CircleAvatar(
                  backgroundImage:
                  NetworkImage("https://images.unsplash.com/photo-1682289571993-32a168b263bf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzOHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60"),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(snap['username'],
                      style: TextStyle(fontWeight: FontWeight.bold),)
                  ]
                      )
                    )
                ),
                IconButton(onPressed: (){
                  showDialog(context: context, builder: (context) => Dialog(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shrinkWrap: true,
                      children: [
                        'Delete',
                      ].map((e) => InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Text(e),
                        ),
                      )).toList()
                    ),
                  ));
                }, icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          const SizedBox(height: 10),
          //Image Section
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.network("https://images.unsplash.com/photo-1682289571993-32a168b263bf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzOHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
            fit: BoxFit.cover,
            ),
          ),
          // Like and Comment Section
          Row(
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.favorite, color: Colors.red,)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.comment_outlined)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.send)),
              Expanded(child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(onPressed: (){}, icon: const Icon(Icons.bookmark_border),),
              ))
            ],
          ),
          //DESCRIPTION AND COMMENT SECTION
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w800),
                    child: Text('${snap['likes'].length} likes', style: Theme.of(context).textTheme.bodyText2,)),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 9),
                  child: RichText(
                    text:  TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold)
                        ),

                        TextSpan(
                            text: ' ${snap['description']}',
                        )
                      ]
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical:3),
                    child: Text('view all 200 comments',
                      style: TextStyle(
                        fontSize: 15,
                        color: secondaryColor
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical:1 ),
                  child: Text(
                    DateFormat.yMMMd().format(snap['datePublished'].toDate())
                    ,
                    style: TextStyle(
                        fontSize: 15,
                        color: secondaryColor
                    ),
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
