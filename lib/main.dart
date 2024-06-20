import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_connect_api_app/adBoxAdd.dart';
import 'package:test_connect_api_app/editAdBox.dart';
import 'package:test_connect_api_app/editProduct.dart';
import 'package:test_connect_api_app/service/GetAdBox.dart';
import 'package:test_connect_api_app/service/getProductApi.dart';
import 'package:test_connect_api_app/widget/skeletonLoad.dart';
import 'addProduct.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bundit Store HomePage',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        useMaterial3: true,
        fontFamily: 'NotoSansLao',
      ),
      home: const MyHomePage(title: 'Bundit Store'),
      routes: {
        '/addproduct': (context) => const AddProductPage(),
        '/editproduct': (context) => const EditProductPage(),
        '/adBoxInfoAdd': (context) => const AddAdBoxInfo(),
        '/adBoxEdit': (context) => const EditAdBoxDetailsPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List dataProduct = [];
  List dataAdBox = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              // ignore: sort_child_properties_last
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Product management',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              focusColor: Colors.deepOrange,
              title: const Text(
                'Add Product',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/addproduct');
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_note),
              focusColor: Colors.deepOrange,
              title: const Text(
                'Edit Product',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/editproduct');
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              focusColor: Colors.deepOrange,
              title: const Text(
                'Add ad details',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/adBoxInfoAdd');
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              focusColor: Colors.deepOrange,
              title: const Text(
                'Edit ad details',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/adBoxEdit');
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          //dataProduct = await getProducts();
          setState(() {});
        },
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 250,
              child: FutureBuilder(
                  future: getAdboxdetails(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Dialog(
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 15,
                              ),
                              Text('Loading ...'),
                            ],
                          ),
                        ),
                      );
                    } else if (snap.connectionState == ConnectionState.done) {
                      if (snap.hasData) {
                        List originalDataList = snap.data!;
                        final shuffleList = List.from(originalDataList)
                          ..shuffle();
                        final randomList = shuffleList.take(6);
                        dataAdBox = randomList.toList();
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List<Widget>.generate(
                              dataAdBox.length,
                              (index) => Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  height: 350,
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                        autoPlay: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 5),
                                        pauseAutoPlayOnTouch: true,
                                        pauseAutoPlayOnManualNavigate: true,
                                        pauseAutoPlayInFiniteScroll: true),
                                    items: [
                                      for (int index = 0;
                                          index < dataAdBox.length;
                                          index++)
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 350,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Stack(
                                            children: [
                                              Image.memory(
                                                base64Decode(
                                                    dataAdBox[index]['ad_pic']),
                                                height: double.infinity,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        colors: [
                                                      Colors.black
                                                          .withOpacity(0.5),
                                                      Colors.transparent
                                                    ],
                                                        begin: Alignment
                                                            .bottomCenter,
                                                        end: Alignment
                                                            .topCenter)),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Text(
                                                      dataAdBox[index]
                                                          ['ad_text'],
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (snap.hasError) {
                        return Container(
                          height: 300,
                          child: const Text('something worng'),
                        );
                      }
                    }
                    return Container(
                      height: 300,
                      child: Text("error"),
                    );
                  }),
            ),
            FutureBuilder(
              future: getProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SkeletonBox(
                    key: Key('skeleton'),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    dataProduct = snapshot.data!;
                    Iterable smfilltered = dataProduct.where(
                        (element) => element['prod_type'] == 'Smart Phone');
                    final smSuffle = List.from(smfilltered)..shuffle();
                    List<dynamic> showDataListSm = smSuffle.toList();
                    Iterable dsfilltered =
                        dataProduct.where((ds) => ds['prod_type'] == 'Desktop');
                    final dsSuffle = List.from(dsfilltered)..shuffle();
                    List<dynamic> showDataListds = dsSuffle.toList();
                    Iterable pcfilltered =
                        dataProduct.where((pc) => pc['prod_type'] == 'PC PART');
                    final pcSuffle = List.from(pcfilltered)..shuffle();
                    List<dynamic> showDataListPc = pcSuffle.toList();
                    Iterable tlfilltered =
                        dataProduct.where((tl) => tl['prod_type'] == 'Tablet');
                    final tlSuffle = List.from(tlfilltered)..shuffle();
                    List<dynamic> showDataListTl = tlSuffle.toList();
                    Iterable swfilltered = dataProduct
                        .where((sw) => sw['prod_type'] == 'Smart Watch');
                    final swSuffle = List.from(swfilltered)..shuffle();
                    List<dynamic> showDataListSw = swSuffle.toList();

                    return ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const Padding(
                          //show smart phone part
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Smart phone',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List<Widget>.generate(
                                showDataListSm.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        width: 250,
                                        clipBehavior: Clip.antiAlias,
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.white, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 0.5,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: 120,
                                                child: Image.memory(
                                                    base64Decode(
                                                        showDataListSm[index]
                                                            ['prod_image'])),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    showDataListSm[index]
                                                        ['prod_name'],
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    'ປະເພດ: ${showDataListSm[index]['prod_type']}',
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    'ລາຄາ: ${showDataListSm[index]['prod_price'].toString()}',
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        height: 35,
                                                        child: TextButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .deepOrange),
                                                              foregroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .white),
                                                            ),
                                                            onPressed: () {},
                                                            child: const Text(
                                                              'Buy',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                          ),
                        ),
                        // SizedBox(
                        //   height: 300,
                        //   child: ListView.builder(
                        //     shrinkWrap: true,
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: showDataListSm.length,
                        //     itemBuilder: (context, index) {
                        //       return Container(
                        //         width: 300,
                        //         clipBehavior: Clip.antiAlias,
                        //         margin: const EdgeInsets.all(10),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           border: Border.all(
                        //               color: Colors.white, width: 1.0),
                        //           borderRadius: BorderRadius.circular(13),
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1,
                        //               blurRadius: 0.5,
                        //               offset: const Offset(0, 1),
                        //             ),
                        //           ],
                        //         ),
                        //         child: Column(
                        //           crossAxisAlignment:
                        //               CrossAxisAlignment.start,
                        //           children: [
                        //             Align(
                        //               alignment: Alignment.center,
                        //               child: SizedBox(
                        //                 height: 120,
                        //                 child: Image.memory(base64Decode(
                        //                     showDataListSm[index]
                        //                         ['prod_image'])),
                        //               ),
                        //             ),
                        //             Container(
                        //               margin: const EdgeInsets.all(5),
                        //               child: Column(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                 children: [
                        //                   Text(
                        //                     showDataListSm[index]
                        //                         ['prod_name'],
                        //                     style: const TextStyle(
                        //                         fontSize: 20,
                        //                         fontWeight: FontWeight.bold),
                        //                   ),
                        //                   const SizedBox(
                        //                     height: 6,
                        //                   ),
                        //                   Text(
                        //                     'ປະເພດ: ${showDataListSm[index]['prod_type']}',
                        //                     style: const TextStyle(
                        //                         fontSize: 17,
                        //                         fontWeight: FontWeight.bold),
                        //                   ),
                        //                   const SizedBox(
                        //                     height: 6,
                        //                   ),
                        //                   Text(
                        //                     'ລາຄາ: ${showDataListSm[index]['prod_price'].toString()}',
                        //                     style: const TextStyle(
                        //                         fontSize: 17,
                        //                         fontWeight:
                        //                             FontWeight.normal),
                        //                   ),
                        //                   Align(
                        //                     alignment: Alignment.topRight,
                        //                     child: Padding(
                        //                       padding:
                        //                           const EdgeInsets.all(8.0),
                        //                       child: SizedBox(
                        //                         height: 35,
                        //                         child: TextButton(
                        //                             style: ButtonStyle(
                        //                               backgroundColor:
                        //                                   MaterialStateProperty
                        //                                       .all(Colors
                        //                                           .deepOrange),
                        //                               foregroundColor:
                        //                                   MaterialStateProperty
                        //                                       .all(Colors
                        //                                           .white),
                        //                             ),
                        //                             onPressed: () {},
                        //                             child: const Text(
                        //                               'Buy',
                        //                               style: TextStyle(
                        //                                 fontSize: 14,
                        //                               ),
                        //                             )),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        const Padding(
                          //show desktop part
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Desktop',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List<Widget>.generate(
                                showDataListds.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        width: 250,
                                        clipBehavior: Clip.antiAlias,
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.white, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 0.5,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: 120,
                                                child: Image.memory(
                                                    base64Decode(
                                                        showDataListds[index]
                                                            ['prod_image'])),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    showDataListds[index]
                                                        ['prod_name'],
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    'ປະເພດ: ${showDataListds[index]['prod_type']}',
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    'ລາຄາ: ${showDataListds[index]['prod_price'].toString()}',
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        height: 35,
                                                        child: TextButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .deepOrange),
                                                              foregroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .white),
                                                            ),
                                                            onPressed: () {},
                                                            child: const Text(
                                                              'Buy',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                          ),
                        ),
                        const Padding(
                          //show pc part
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'PC Part',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List<Widget>.generate(
                                showDataListPc.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        width: 250,
                                        clipBehavior: Clip.antiAlias,
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.white, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 0.5,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: 120,
                                                child: Image.memory(
                                                    base64Decode(
                                                        showDataListPc[index]
                                                            ['prod_image'])),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    showDataListPc[index]
                                                        ['prod_name'],
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    'ປະເພດ: ${showDataListPc[index]['prod_type']}',
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    'ລາຄາ: ${showDataListPc[index]['prod_price'].toString()}',
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        height: 35,
                                                        child: TextButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .deepOrange),
                                                              foregroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .white),
                                                            ),
                                                            onPressed: () {},
                                                            child: const Text(
                                                              'Buy',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                          ),
                        ),
                        const Padding(
                          //show tablet
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Tablet',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List<Widget>.generate(
                                showDataListTl.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        width: 250,
                                        clipBehavior: Clip.antiAlias,
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.white, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 0.5,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: 120,
                                                child: Image.memory(
                                                    base64Decode(
                                                        showDataListTl[index]
                                                            ['prod_image'])),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    showDataListTl[index]
                                                        ['prod_name'],
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    'ປະເພດ: ${showDataListTl[index]['prod_type']}',
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    'ລາຄາ: ${showDataListTl[index]['prod_price'].toString()}',
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        height: 35,
                                                        child: TextButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .deepOrange),
                                                              foregroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .white),
                                                            ),
                                                            onPressed: () {},
                                                            child: const Text(
                                                              'Buy',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                          ),
                        ),
                        const Padding(
                          //show smart watch
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Smart Watch',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List<Widget>.generate(
                                showDataListSw.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        width: 250,
                                        clipBehavior: Clip.antiAlias,
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.white, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 0.5,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: 120,
                                                child: Image.memory(
                                                    base64Decode(
                                                        showDataListSw[index]
                                                            ['prod_image'])),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    showDataListSw[index]
                                                        ['prod_name'],
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    'ປະເພດ: ${showDataListSw[index]['prod_type']}',
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    'ລາຄາ: ${showDataListSw[index]['prod_price'].toString()}',
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        height: 35,
                                                        child: TextButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .deepOrange),
                                                              foregroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .white),
                                                            ),
                                                            onPressed: () {},
                                                            child: const Text(
                                                              'Buy',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return ElevatedButton(
                        onPressed: () {
                          setState(() {
                            getProducts();
                          });
                        },
                        child: const Text('Retry'));
                  }
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
