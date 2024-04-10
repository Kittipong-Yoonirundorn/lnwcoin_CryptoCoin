import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/model/user_model.dart';
import 'package:cryptocurrency_flutter/services/base_service.dart';
import 'package:cryptocurrency_flutter/services/keys.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';

class UserService extends BaseService<UserModel> {
  UserService() {
    ref = fireStore.collection(collections.user).withConverter<UserModel>(
          fromFirestore: (snapshot, options) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  Future<UserModel> userByEmail(String? email) async {
    return ref!.limit(1).where(userKeys.email, isEqualTo: email).get().then((value) => value.docs.first.data());
  }

  Future<QuerySnapshot> userExist({String? uid}) async {
    return await ref!.limit(1).where(userKeys.uid, isEqualTo: uid).get();
  }

  Stream<UserModel> getSettings() {
    return ref!.limit(1).where(userKeys.uid, isEqualTo: appStore.uid).snapshots().map((event) => event.docs.first.data());
  }

  Future<UserModel> getUser({String? email}) {
    return ref!.where(userKeys.email, isEqualTo: email).limit(1).get().then(
      (value) {
        if (value.docs.length == 1) {
          if (value.docs.first.data().userRole == "admin") {
            throw accessDenied;
          } else {
            return value.docs.first.data();
          }
        } else {
          throw userNotFound;
        }
      },
    );
  }
}
