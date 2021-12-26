import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:programming_languages_project/models/comment_model.dart';
import 'package:programming_languages_project/providers/product_detailes_provider.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CommentsLayout extends StatefulWidget {
  final int productId;
  const CommentsLayout({Key? key, required this.productId}) : super(key: key);

  @override
  _CommentsLayoutState createState() => _CommentsLayoutState();
}

class _CommentsLayoutState extends State<CommentsLayout> {
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductDetailesProvider>(context);
    var lan = AppLocalizations.of(context)!;
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: darkBlue,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          //comments section
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //user profile photo
                      CircleAvatar(
                        child: provider.comments[index].user!.image == null
                            ? const Icon(Icons.person)
                            : Image.network(
                                provider.comments[index].user!.image!,
                                fit: BoxFit.cover,
                              ),
                        radius: 25,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        //comment body
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //username
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(provider.comments[index].user!.name!),
                                    Text(
                                      provider.comments[index].time!,
                                      style: const TextStyle(
                                        color: Colors.black26,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                //user comment
                                Text(
                                  provider.comments[index].comment!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                provider.comments[index].edit == 1
                                    ?  Text(
                                        AppLocalizations.of(context)!.edited,
                                        style:const TextStyle(
                                          color: Colors.black26,
                                          fontSize: 12,
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: provider.comments.length,
            ),
          ),

          //Input section
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Card(
                  margin: const EdgeInsets.only(
                    top: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    child: TextFormField(
                      controller: commentController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration:  InputDecoration(
                        border: InputBorder.none,
                        hintText: lan.commentsHint,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: mainRed,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: InkWell(
                  focusColor: Colors.amber,
                  //TODO:
                  // onLongPress: () {
                  //   showMenu(
                  //       context: context,
                  //       position: RelativeRect.fromSize(
                  //           Rect.largest, const Size(150, 300)),
                  //       items: [
                  //         PopupMenuItem(
                  //           child: Text('edit'),
                  //         ),
                  //       ]);
                  // },
                  child: IconButton(
                    onPressed: () {
                      if (commentController.text.isNotEmpty) {
                        Provider.of<ProductDetailesProvider>(context,
                                listen: false)
                            .postComment(
                          productId: widget.productId,
                          comment: commentController.text,
                        );
                        commentController.text = '';
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
          ),
        ],
      ),
    );
  }
}
