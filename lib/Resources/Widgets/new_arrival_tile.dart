import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Firebase/DataBase/User_data/get_user_data.dart';
import 'package:laza/Models/wishlist_model.dart';
import 'package:laza/Providers/wishList_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../Firebase/DataBase/user_wishList.dart';
import '../MediaQuery/media_query.dart';
import '../Paths/AssetsPath.dart';
import '../Paths/imports.dart';

class NewArrivalTile extends StatefulWidget {
  final List image;
  final String description;
  final String name;
  final List Size;
  final List reviews;
  final String type;
  final int price;
  final String productId;
  final String? favProductId;
  final String brand;
  int? position;
   NewArrivalTile({super.key,
    required this.image, required this.description,
    required this.type, required this.price,
    required this.productId,this.position, required this.name, required this.Size, required this.reviews,
     required this.brand,  this.favProductId });

  @override
  State<NewArrivalTile> createState() => _NewArrivalTileState();
}

class _NewArrivalTileState extends State<NewArrivalTile> {
   bool wish =false;
   final snapshotRef = FirebaseFirestore.instance
       .collection('Wishlist')
       .doc(FirebaseAuth.instance.currentUser!.uid)
       .collection('WishlistItem')
       .snapshots();

   Future<void> getWishListId ()async {
     final userId = FirebaseAuth.instance.currentUser!.uid;
     final wishlistSnapshot = await FirebaseFirestore.instance
         .collection('Wishlist')
         .doc(userId)
         .collection('WishlistItem')
         .where('ProductId', isEqualTo: widget.productId.toLowerCase())
         .get();

     setState(() {
    wish = wishlistSnapshot.docs.isNotEmpty;
  });
}
@override
  void initState() {
  // TODO: implement initState
  super.initState();
  getWishListId();
}
   @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WishlistProvider>(context, listen: false);
    final fullHeight= getScreenSize(context).height;
    final fullWidth=  getScreenSize(context).width;
    final w  =getScreenSize(context).width*(1/375);
    final h= getScreenSize(context).height*(1/812);




    return  SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 203 ,
            width: 160,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: MyColor.grey,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: NetworkImage(widget.image[0]),fit:  BoxFit.fill)
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child:  Consumer<WishlistProvider>(
                  builder: (BuildContext context, WishlistProvider value,
                      Widget? child) {

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () async {
                              if (wish) {
                                await provider.removeFromWishList(widget.productId);
                                setState(() {
                                  wish = false;
                                });
                              } else {
                                await provider.addToWishlist(
                                  productId: widget.productId,
                                  Producttype: widget.type,
                                  Productname: widget.name,
                                  Productbrand: widget.brand,
                                  ProductimagePath: widget.image,
                                  Size: widget.Size,
                                  Productdescription: widget.description,
                                  ProductReviews: widget.reviews,
                                  Productprice: widget.price,
                                );
                                setState(() {
                                  wish = true;
                                });
                              }
                            },

                            child:wish ? const Icon(
                              Icons.favorite, color: MyColor.textLight,
                              size: 20,)
                                : SvgPicture.asset(
                                Images.heart)
                        ),
                      ],
                    );
                  }
              ),
            ),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            width: 150,
            child: Text(widget.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
                color: MyColor.textBlack,
              ),),
          ),
          SizedBox(
            width: 150,

            child: Text(widget.type,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
                color: MyColor.textBlack,
              ),),
          ),
          const SizedBox(height: 5,),

          Text('\$${widget.price.toString()}',style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
            color: MyColor.textBlack,
          ),),

        ],

      ),
    );
  }
}
