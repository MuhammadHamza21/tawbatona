import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tawbatona/app/data/model/persons_model.dart';
import 'package:tawbatona/app/domain/usecases/update_person.dart';
import 'package:tawbatona/core/constants/api_constants.dart';
import 'package:tawbatona/core/constants/app_constants.dart';
import 'package:tawbatona/core/error/exceptions.dart';

abstract class BaseAppRemoteDatasource {
  Future<List<PersonsModel>> getPersons();
  Future<void> updatePerson(UpdatingPersonParams params);
}

class AppRemoteDatasource extends BaseAppRemoteDatasource {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  @override
  Future<List<PersonsModel>> getPersons() async {
    try {
      var response =
          await _firebaseFirestore.collection(ApiConstants.persons).get();
      if (response.docs.isNotEmpty) {
        return List<PersonsModel>.from(
          (response.docs as List).map(
            (e) => PersonsModel.fromSnapshot(e),
          ),
        );
      } else {
        return [];
      }
    } on FirebaseException catch (_) {
      throw ServerException(message: AppConstants.serverErrorMessage);
    }
  }

  @override
  Future<void> updatePerson(UpdatingPersonParams params) async {
    // TODO: implement updatePerson
    throw UnimplementedError();
  }
}
