import 'package:flutter/material.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
import 'package:laza/Veiw/product_detail_screen.dart';

import '../../Models/new_arrival_model.dart';
import '../../Resources/MediaQuery/media_query.dart';
import '../../Resources/Widgets/new_arrival_tile.dart';

class AllArrivalScreen extends StatefulWidget {
  const AllArrivalScreen({super.key});

  @override
  State<AllArrivalScreen> createState() => _AllArrivalScreenState();
}

class _AllArrivalScreenState extends State<AllArrivalScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: appBar(context, title: 'Arrivals'),
      body:   Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
            height: getScreenSize(context).height,
            width: getScreenSize(context).width,
            child: GridView.builder(itemCount: 9,
                gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    mainAxisExtent: 270,
                    childAspectRatio: 1

                ),
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      // NavigatorTo(context, ProductDetailScreen());
                    },
                    child: Text('')
                  );
                })
        ),
      ),
    ));
  }
}
