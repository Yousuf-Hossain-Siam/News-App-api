import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_api/model/news_channels_headlines_model.dart';
import 'package:news_app_api/view/categories_screen.dart';
import 'package:news_app_api/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).height * 1;
    final height = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoriesScreen()));
          },
          icon: Image.asset("assets/images/category_icon.png",
        height: 30,
        width: 30,),),
        centerTitle: true,
        title: Text("News", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700 ),),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .65,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
           
            future: newsViewModel.fetchNewsChannelsHeadlinesApi(),
             builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
            if(snapshot.connectionState  == ConnectionState.waiting){
         return Center(
          child: SpinKitCircle(
            size: 50,
            color: Colors.blueAccent,
          ),
         );
            }else{
          return ListView.builder(
            itemCount: snapshot.data!.articles!.length ,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index){
             return SizedBox(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                   
                    child: CachedNetworkImage(imageUrl: snapshot.data.articles![index].urlToImage.toString(),
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>  Container(
                      child: spinKit2,
                    ),
                    errorWidget: (context, url ,error) => Icon(Icons.error, color: Colors.red,),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: height * .15,
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: width * 0.37 ,
                              child: Text(snapshot.data!.articles![index].title.toString(), style: 
                              GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700),)
                            )
                           ],
                        ),
                      )
                    ),
                  )
                ],
              ),
             );
            });
            }
             }
             ),
          )
        ],
      ),
    );
  }

  
}

const spinKit2 = SpinKitFadingCircle(
    color: Colors.amber,
    size: 50 ,
  );