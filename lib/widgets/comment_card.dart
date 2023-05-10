import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snap;
  const CommentCard({Key? key, required this.snap, }) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['photoUrl']),
            radius: 18,
          ),
          Expanded(
            child: Padding(padding: const EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                RichText(text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.snap['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    ),

                    TextSpan(
                        text: ' ${widget.snap['text']}',
                      style: const TextStyle(
                        color: Colors.white
                      )
                    )
                  ]
                )
                ),
                  Padding(
                 padding: const EdgeInsets.only(top: 4),
                 child: Text(DateFormat.yMMMd().format(widget.snap['datePublished'].toDate()),
                 style: const TextStyle(color: secondaryColor)
                 )
                )
              ],
            ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.favorite),
          )
        ],
      ),
    );
  }
}
