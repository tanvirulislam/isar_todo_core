// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class RoutineModel {
//   int? id;
//   String? name;
//   RoutineModel({
//     this.id,
//     this.name,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//     };
//   }

//   factory RoutineModel.fromMap(Map<String, dynamic> map) {
//     return RoutineModel(
//       id: map['id'] != null ? map['id'] as int : null,
//       name: map['name'] != null ? map['name'] as String : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory RoutineModel.fromJson(String source) =>
//       RoutineModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }
