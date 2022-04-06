class AboutusModel{
bool status;
AboutUs aboutUs;
AboutusModel({required this.status,required this.aboutUs});

factory AboutusModel.fromJson(Map<String,dynamic> data){
  return AboutusModel(status: data['status'], aboutUs: AboutUs.fromJson(data['about_us']));
}

}

class AboutUs{
  int id;
  String description;
  String app_version;
  String? created_at;
  String? updated_at;

  AboutUs({required this.id,required this.description,required this.app_version,
   this.created_at,  this.updated_at});

  factory AboutUs.fromJson(Map<String, dynamic> data){
    return AboutUs(id: data['id'], description: data['description'], app_version: data['app_version'],created_at: data['created_at'],
    updated_at: data['updated_at']);
  }
}