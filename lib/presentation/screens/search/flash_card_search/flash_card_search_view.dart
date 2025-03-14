import 'package:flutter/material.dart';

import 'package:learn_connect/presentation/screens/search/coponents/search_box.dart';
import 'package:learn_connect/presentation/screens/search/flash_card_search/flash_card_view_model.dart';

class FlashCardSearchScreen extends StatefulWidget{
  const FlashCardSearchScreen({super.key});

  @override
  State createState() => _FlashCardSearchState();
}

class _FlashCardSearchState extends State<FlashCardSearchScreen> {
  final FlashCardViewModel flashCardViewModel = FlashCardViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flashCardViewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
          title: Text(
            "FLASHCARD",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ListenableBuilder(listenable: flashCardViewModel, builder: (context, child){
            return
              Column(
                children: <Widget>[
                  SearchBox(),
                  SizedBox(height: 20),
                  Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.4,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: flashCardViewModel.flash_cards.length,
                        itemBuilder: (context, index){
                          final flashcard =   flashCardViewModel.flash_cards[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.pink[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  flashcard.flash_card_type,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                  )
                ],
              );
          }),

        ),
      ),
    );
  }
}
