import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/screens/comment_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class PostCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;

  @override
  void initState() {
    super.initState();
    getComments();
  }
  void getComments() async{
    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('posts').doc(widget.snap['postsId']).collection('comments').get();
      commentLen = snapshot.docs.length;
    }catch(err){
      showSnackBar(err.toString(), context);
    }
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
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
                  NetworkImage(widget.snap["postUrl"]),
                ),

                //username section
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(widget.snap['username'],
                      style: const TextStyle(fontWeight: FontWeight.bold),)
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
                        onTap: () async{
                          FireStoreMethods().deletePost(widget.snap['postId']);
                          Navigator.of(context).pop();
                        },
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
          GestureDetector(
            onDoubleTap: () async{
              await FireStoreMethods().likesPost(widget.snap['postId'], user.uid, widget.snap['likes']);
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image.network(widget.snap['postImage'],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                      isAnimating: isLikeAnimating,
                      duration: const Duration(milliseconds: 400),
                      onEnd: (){
                          setState(() {
                            isLikeAnimating = false;
                          });
                      },
                      child: const Icon(Icons.favorite, color: Colors.white,size: 120,)),
                )
              ]
            ),
          ),
          // Like and Comment Section
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                  smallLike: true,
                  child: IconButton(
                      onPressed: () async{
                        await FireStoreMethods().likesPost(widget.snap['postId'], user.uid, widget.snap['likes']);
                      },
                      icon: widget.snap['likes'].contains(user.uid)?
                      const Icon(Icons.favorite, color: Colors.red,)
                      : const Icon(Icons.favorite_border)
                  )
              ),
              IconButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
               CommentScreen(
                snap: widget.snap,
              )
              )), icon: const Icon(Icons.comment_outlined)),
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
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w800),
                    child: Text('${widget.snap['likes'].length} likes', style: Theme.of(context).textTheme.bodyMedium,)),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 9),
                  child: RichText(
                    text:  TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: widget.snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold)
                        ),

                        TextSpan(
                            text: ' ${widget.snap['description']}',
                        )
                      ]
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical:3),
                    child: Text('view all $commentLen comments',
                      style: const TextStyle(
                        fontSize: 15,
                        color: secondaryColor
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical:1 ),
                  child: Text(
                    DateFormat.yMMMd().format(widget.snap['datePublished'].toDate())
                    ,
                    style: const TextStyle(
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
