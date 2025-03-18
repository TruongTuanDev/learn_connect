import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:learn_connect/presentation/screens/conversation/call/call_item.dart';

import 'call_provider.dart';

class CallListScreen extends ConsumerWidget {
  const CallListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callsAsyn = ref.watch(callProvider);
    final DateFormat  formattedDate = DateFormat('dd-MM-yyyy');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
          title: Text(
            "Tin nhắn",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          titleSpacing: 0.0,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Add your search action here
                  print('Search button pressed');
                },
              ),
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {},
                      child: const Text("Nhắn"),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.indigo.shade100,
                        ),
                        foregroundColor: WidgetStateProperty.all(Colors.black),
                        minimumSize: WidgetStateProperty.all(
                          Size(double.infinity, 50),
                        ),
                        textStyle: WidgetStateProperty.all(
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {},
                      child: const Text("Gọi"),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.green),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        minimumSize: WidgetStateProperty.all(
                          Size(double.infinity, 50),
                        ),
                        textStyle: WidgetStateProperty.all(
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: callsAsyn.when(
                  data:
                      (call) => ListView.builder(
                        itemCount: call.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return CallItem(
                            name: call[index].name,
                            callStatus: call[index].callStatus,
                            time: formattedDate.format(call[index].time),
                            avatarUrl: call[index].avatarUrl,
                          );
                        },
                      ),
                  loading: () => Center(child: CircularProgressIndicator()),
                  // Phải đặt trong hàm `() =>`
                  error:
                      (error, stackTrace) => Center(
                        child: Text("Lỗi: $error"),
                      ), // Thêm return Widget
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
