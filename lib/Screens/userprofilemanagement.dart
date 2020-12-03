import 'package:adventure_eye/database/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

bool has_data= false;
String getUserID()  {
//  FirebaseUser firebaseUser = await auth.currentUser();
// return  firebaseUser.uid;
// firebase_user and auth are global veriables that are initialized at emailSignIn
print(firebase_user.uid);
return firebase_user.uid;

}
 Future<DocumentSnapshot>   getUserDoc() async {
String user_ID = await getUserID().toString();
 DocumentSnapshot user_doc = await Firestore.instance.collection('users').document(user_ID).get();
 return user_doc;
}


class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  String user_name = " ";
  String user_email = "";
  String user_phone_no = "";
  String user_country = "Pakistan";
  String user_CNIC = "1321546498465";
  String user_gender = '';
  int user_age = 21;
  String user_location = "Pakistan";
  int user_total_trips = 0;
  String user_club = "not registered";
  String user_password='';
 // String user_name = "EM Ikram";
  DocumentSnapshot user_data;

 Widget getButton(){
   return IconButton(
        onPressed: (){

    });
  }

@override
  Future<void> initState()  {
    // TODO: implement initState
    super.initState();

    getUserDoc().then((value) {
      user_data = value;
      user_data!=null?  setState(() {
        has_data = true;
         user_name = user_data['name'];
         print(user_data['name']);
         user_email = user_data['email'];
         user_CNIC=user_data['cnic'];
         user_phone_no=user_data['phone'];
         user_age =user_data['age'];
         user_gender=user_data['gender'];

      }): has_data= false;
      print("getUserData Method called");
      print(user_data['name']);





    }
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: has_data==false ? Center(
        child: CircularProgressIndicator(backgroundColor: Colors.transparent,

        ),
      ):
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
              ),
              height: MediaQuery. of(context). size. width-150,
              width: MediaQuery. of(context). size. width,
             // color: Colors.greenAccent,
              child: Column(mainAxisAlignment: MainAxisAlignment.end,
                children: [


                  Stack(alignment: Alignment.bottomRight,
                    children: [

                      CircleAvatar(

                      backgroundColor: Colors.white70,
                      radius: 60,
                      child:  Text(
                        user_name[0],
                        style: TextStyle(fontSize: 50.0),
                      ),

                    ),
//todo image upload button enable
//                      CircleAvatar(
//                        radius: 20,
//                          child: Icon(
//                            Icons.camera_alt,
//                            color: Colors.black54,
//                            size: 20,)
//                      ),
                    ],
                  ),
                  Text("$user_name",style: TextStyle(
                    fontSize: 25,

                  ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Container(
                  height: 55,
                  width: 5,
                  color: Colors.green,
                ),
                Container(

                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomRight: Radius.circular(30))
                  ),

                  height: 50,
                  width: 120,
                  child: Center(child: Text("Name",style: TextStyle(
                    fontSize: 16,
                  ),
                  )
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                readOnly: true,
                  decoration: InputDecoration(
                      hintText:"    $user_name",
                   //   suffixIcon: getButton(),
                  )

              ),
            ),


            Row(
              children: [ Container(
                height: 55,
                width: 5,
                color: Colors.green,
              ),
                Container(

                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomRight: Radius.circular(30))
                  ),

                  height: 50,
                  width: 120,
                  child: Center(child: Text("Email",style: TextStyle(
                    fontSize: 16,
                  ),
                  )
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText:"    $user_email",
//                      suffixIcon: IconButton(
//                        icon: Icon(Icons.email),
//
//                      )
                  )

              ),
            ),


            Row(
              children: [ Container(
                height: 55,
                width: 5,
                color: Colors.green,
              ),
                Container(

                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomRight: Radius.circular(30))
                  ),

                  height: 50,
                  width: 120,
                  child: Center(child: Text("CNIC",style: TextStyle(
                    fontSize: 16,
                  ),
                  )
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText:"    $user_CNIC",

//                      suffixIcon: IconButton(
//                        icon: Icon(Icons.edit),
//
//                      )
                  )

              ),
            ),

            Row(
              children: [ Container(
                height: 55,
                width: 5,
                color: Colors.green,
              ),
                Container(

                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomRight: Radius.circular(30))
                  ),

                  height: 50,
                  width: 120,
                  child: Center(child: Text("Phone",style: TextStyle(
                    fontSize: 16,
                  ),
                  )
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText:"    $user_phone_no",
//                      suffixIcon: IconButton(
//                        icon: Icon(Icons.phone_android),
//
//                      )
                  )

              ),
            ),

            Row(
              children: [ Container(
                height: 55,
                width: 5,
                color: Colors.green,
              ),
                Container(

                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomRight: Radius.circular(30))
                  ),

                  height: 50,
                  width: 120,
                  child: Center(child: Text("Gender",style: TextStyle(
                    fontSize: 16,
                  ),
                  )
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText:"    $user_gender",
//                      suffixIcon: IconButton(
//                        icon: Icon(Icons.person),
//
//                      )
                  )

              ),
            ),
////todo display age , uncomment the following lines
//            Row(
//              children: [ Container(
//                height: 55,
//                width: 5,
//                color: Colors.green,
//              ),

//                Container(
//
//                  decoration: BoxDecoration(
//                      color: Colors.greenAccent,
//                      borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomRight: Radius.circular(30))
//                  ),
//
//                  height: 50,
//                  width: 120,
//                  child: Center(child: Text("Age",style: TextStyle(
//                    fontSize: 16,
//                  ),
//                  )
//                  ),
//                ),
//              ],
//            ),
//            Padding(
//              padding: const EdgeInsets.all(12.0),
//              child: TextFormField(
//                  readOnly: true,
//
//                  decoration: InputDecoration(
//
//                      hintText:"    $user_age",
////                      suffixIcon: IconButton(
////                        icon: Icon(Icons.location_on),
////
////                      )
//                  )
//
//              ),
//            ),
            Row(
              children: [ Container(
                height: 55,
                width: 5,
                color: Colors.green,
              ),
                Container(

                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomRight: Radius.circular(30))
                  ),

                  height: 50,
                  width: 120,
                  child: Center(child: Text("Country",style: TextStyle(
                    fontSize: 16,
                  ),
                  )
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText:"    $user_country",
//                      suffixIcon: IconButton(
//                        icon: Icon(Icons.flag),
//
//                      )
                  )

              ),
            ),

            Row(
              children: [ Container(
                height: 55,
                width: 5,
                color: Colors.green,
              ),
                Container(

                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomRight: Radius.circular(30))
                  ),

                  height: 50,
                  width: 120,
                  child: Center(child: Text("Location",style: TextStyle(
                    fontSize: 16,
                  ),
                  )
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(

                      hintText:"    $user_location",
//                      suffixIcon: IconButton(
//                        icon: Icon(Icons.location_on),
//
//                      )
                  )

              ),
            ),



//            Row(
//              children: [ Container(
//                height: 55,
//                width: 5,
//                color: Colors.green,
//              ),
//                Container(
//
//                  decoration: BoxDecoration(
//                      color: Colors.greenAccent,
//                      borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomRight: Radius.circular(30))
//                  ),
//
//                  height: 50,
//                  width: 120,
//                  child: Center(child: Text("Password",style: TextStyle(
//                    fontSize: 16,
//                  ),
//                  )
//                  ),
//                ),
//              ],
//            ),
//            Padding(
//              padding: const EdgeInsets.all(12.0),
//              child: TextFormField(
//                  decoration: InputDecoration(
//                      hintText:"    $user_password",
//                      suffixIcon: IconButton(
//                        icon: Icon(Icons.lock_outline),
//
//                      )
//                  )
//
//              ),
//            ),



          ],
        ),
      ),
    );
  }
}
