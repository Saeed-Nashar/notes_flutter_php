import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

  class CRUD{
    //class createRedUpdateDelete

     getResponse(String url) async{
       try{
          var response= await http.get(Uri.parse(url));
          if( response.statusCode==200){
            var responseBody= jsonDecode(response.body);
            return responseBody;
          }else{
           print("error${response.body}");
          }
       }catch(e){
         print("catch${e}");
       }
     }
     postResponse(String url,Map data) async{
       try{
         var response= await http.post(Uri.parse(url),body: data,);
         if( response.statusCode==200){
           var responseBody= jsonDecode(response.body);
           return responseBody;
         }else{
           print("error${response.body}");
         }
       }catch(e){
         print("catch${e}");
       }
     }

     postRequestWithFile(String url,Map data,File file)async{
       var request = http.MultipartRequest("POST",Uri.parse(url));
       var length= await file.length();
       var stram = await http.ByteStream(file.openRead());
       var multiPartFile=http.MultipartFile('file',stram,length,filename:basename(file.path));
       request.files.add(multiPartFile);
       data.forEach((key, value) {
         request.fields[key]=value;
       });
       var myRequest= await request.send();
       var response= await http.Response.fromStream(myRequest);
       if(myRequest.statusCode==200){
         return jsonDecode(response.body);
       }else{
         print(" we have error in class CURD POSTRequestWithFile");
       }
     }
}