import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

@immutable
class Call{
  final String avatarUrl;
  final String name;
  final String callStatus;
  final DateTime time;

  const Call({required this.avatarUrl, required this.name, required this.callStatus, required this.time} );

  //json dont have datetime type, change it to string
  Map<String, dynamic> toJson() => {'avatarUrl' : avatarUrl, 'name': name,
  "callStatus":callStatus, "time":time.toIso8601String()};

  factory Call.fromJson(Map<String, dynamic> json){
    return switch(json) {
      {'avatarUrl' : String avatarUrl, 'name' : String name,
      'callStatus' : String callStatus, 'time' : String time} => Call(
        avatarUrl: avatarUrl,
        name: name,
        callStatus: callStatus,
        time :DateTime.parse(time)
      ),
    _ => throw const FormatException('Failed to load search history')
    };
  }
}

class CallModel{

  final List<Call> mockCallList = [
    Call(
      avatarUrl: "https://th.bing.com/th?id=OIP.pZKr_osGE7aj5N7AhBG"
          "iFAHaJi&w=220&h=283&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
      name: "Nguyễn Văn A",
      callStatus: "received_call",
      time: DateTime.now().subtract(Duration(minutes: 5)),
    ),
    Call(
      avatarUrl: "https://th.bing.com/th?id=OIP.pZKr_osGE7aj5N7AhBG"
          "iFAHaJi&w=220&h=283&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
      name: "Trần Thị B",
      callStatus: "received_call",
      time: DateTime.now().subtract(Duration(hours: 1)),
    ),
    Call(
      avatarUrl: "https://th.bing.com/th?id=OIP.pZKr_osGE7aj5N7AhBG"
          "iFAHaJi&w=220&h=283&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
      name: "Lê Văn C",
      callStatus: "called",
      time: DateTime.now().subtract(Duration(days: 1)),
    ),
    Call(
      avatarUrl: "https://th.bing.com/th?id=OIP.pZKr_osGE7aj5N7AhBG"
          "iFAHaJi&w=220&h=283&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
      name: "Phạm Thị D",
      callStatus: "missed_call",
      time: DateTime.now().subtract(Duration(minutes: 30)),
    ),
    Call(
      avatarUrl: "https://th.bing.com/th/id/OIP.0iqvqUM-_MntTZp4CMBaigHaEK?w=309&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
      name: "Hoàng Văn E",
      callStatus: "called",
      time: DateTime.now().subtract(Duration(days: 2)),
    ),
  ];
  final dio = Dio();

  Future<List<Call>> fetchCalls() async{
    /*final response = await dio.get("path");

    if(response.statusCode == 200){
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json)=> Call.fromJson(json)).toList();
    }else {
      throw Exception('Failed to load search history');
    }*/
    return List<Call>.from(mockCallList);
  }
}