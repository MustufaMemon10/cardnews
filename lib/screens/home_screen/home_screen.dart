import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../../utils/colors.dart';




class Newsapp extends StatefulWidget {
  const Newsapp({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Newsdata();
  }
}

class Newsdata extends State<Newsapp> {
  String? data;
  var newsdata;
  List<bool> isLikedList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      http.Response response =
      await http.get(Uri.parse("https://inshorts.vercel.app/news/top"));
      if (response.statusCode == 200) {
        data = response.body;
        setState(() {
          newsdata = jsonDecode(data!)["data"]["articles"];
          isLikedList = List.generate(newsdata.length, (index) => false);
        });
      } else {
        // Handle error scenarios here.
      }
    } catch (e) {
      // Handle network or other exceptions here.
    }
  }

  Future<void> _refreshdata() async {
    await getData();
  }

  @override
  Widget build(BuildContext context) {
    if (newsdata == null || newsdata!.isEmpty) {
      return Scaffold(
        body: Center(
            child: Lottie.asset('assets/Animation - 1714901035385.json',
                height: 300, width: 300, repeat: true,reverse: true)),
      );
    }
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(screenWidth * 0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 0.5, color: AppColors.purple.withOpacity(0.7)),
            color: Colors.black26,
          ),
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "News",
                style: GoogleFonts.aladin(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(0.9)),
                )
            ),
            const SizedBox(
              width: 3.0,
            ),
            Text(
                "App",
                style: GoogleFonts.aladin(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(0.9)),
                )
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.purple,
              child: Icon(
                Icons.notification_add,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.purple,
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshdata,
        color: AppColors.purple,
        backgroundColor: Colors.white,
        child: ListView.builder(
            itemCount: newsdata.length,
            itemBuilder: (BuildContext context, int index) {
              final title = newsdata[index]["title"];
              final category = newsdata[index]["categoryNames"][0];
              final content = newsdata[index]["content"];
              final author = newsdata[index]["authorName"];
              final source = newsdata[index]["sourceName"];
              final imageUrl = newsdata[index]["imageUrl"];
              final date = newsdata[index]["date"];
              return FlipCard(
                fill: Fill.fillBack,
                direction: FlipDirection.HORIZONTAL,
                side: CardSide.FRONT,
                front: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0),
                  child: Stack(
                    children: [
                      Container(
                        height: 260,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              imageUrl,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.black.withOpacity(0.5),
                                Colors.white.withOpacity(0.1),
                                Colors.transparent,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5.0,
                        top: 5.0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isLikedList[index] = !isLikedList[index];
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              shape: BoxShape.circle,
                              boxShadow:  [
                                BoxShadow(
                                  color: AppColors.skyBlue.withOpacity(0.4),
                                  offset: Offset(2,0)
                                )
                              ]
                              ),
                            child: IconButton(
                              icon: Icon(
                                isLikedList[index]
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isLikedList[index]
                                    ? Colors.red
                                    : Colors.black,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  isLikedList[index] = !isLikedList[index];
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        bottom: 10,
                        right: 10,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "•",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 3.0,
                                    ),
                                    Text(
                                      source,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8,),
                              Text(
                                title,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    letterSpacing: 0.6),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Icon(
                                        CupertinoIcons.heart,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Text(
                                        "245",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white54),
                                      ),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Text(
                                        "•",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white54),
                                      ),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Icon(
                                        Icons.comment,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Text(
                                        "199",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white54),
                                      ),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Text(
                                        "•",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white54),
                                      ),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Icon(
                                        Icons.ios_share,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Text(
                                        "500",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color:
                                          Colors.white54,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "•",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w100,
                                            color:
                                            Colors.white.withOpacity(0.5)),
                                      ),
                                      const SizedBox(
                                        width: 3.0,
                                      ),
                                      Text(
                                        category,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color:
                                            Colors.white54
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                back: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0),
                  child: Stack(
                    children: [
                      Container(
                        height: 270,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              imageUrl,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.black.withOpacity(0.4)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10.0,
                        top: 10.0,
                        right: 10.0,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 5.0, bottom: 5.0),
                                  child: Text(title,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color:
                                          Colors.white.withOpacity(0.9))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 5.0, bottom: 5.0),
                                child: Text(
                                  content + "...",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white.withOpacity(0.8)),
                                  maxLines: 8,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10.0,
                        bottom: 5.0,
                        child: Text(
                          "~ $author",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.9)),
                          overflow: TextOverflow.clip,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}