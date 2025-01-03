class PostJobModel {
  PostJobModel({
    required this.type,
    required this.jobs,
  });

  final String? type;
  final List<Job> jobs;

  factory PostJobModel.fromJson(Map<String, dynamic> json) {
    return PostJobModel(
      type: json["type"],
      jobs: json["jobs"] == null
          ? []
          : List<Job>.from(json["jobs"]!.map((x) => Job.fromJson(x))),
    );
  }
}

class Job {
  Job({
    required this.companyName,
    required this.companyId,
    required this.placeHolderImg,
    required this.jobTitle,
    required this.jobLocation,
    required this.createdAt,
  });

  final String? companyName;
  final String? companyId;
  final String? placeHolderImg;
  final String? jobTitle;
  final String? jobLocation;
  final String? createdAt;

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      companyName: json["company_name"],
      companyId: json["company_id"],
      placeHolderImg: json["place_holder_img"],
      jobTitle: json["job_title"],
      jobLocation: json["job_location"],
      createdAt: json["created_at"],
    );
  }
}
