import 'package:json_annotation/json_annotation.dart';

part 'portfolio_model.g.dart';

@JsonSerializable()
class PortfolioData {
  final LandingSection landing;
  final AboutSection about;
  final List<SocialLink> socialLinks;
  final List<Experience> experiences;

  PortfolioData({
    required this.landing,
    required this.about,
    required this.socialLinks,
    required this.experiences,
  });

  factory PortfolioData.fromJson(Map<String, dynamic> json) =>
      _$PortfolioDataFromJson(json);
  Map<String, dynamic> toJson() => _$PortfolioDataToJson(this);
}

@JsonSerializable()
class LandingSection {
  final String title;
  final String createdAt;
  final String projectTitle;
  final String projectDescription;
  final String startPrompt;
  final String creatorTitle;
  final String creatorName;

  LandingSection({
    required this.title,
    required this.createdAt,
    required this.projectTitle,
    required this.projectDescription,
    required this.startPrompt,
    required this.creatorTitle,
    required this.creatorName,
  });

  factory LandingSection.fromJson(Map<String, dynamic> json) =>
      _$LandingSectionFromJson(json);
  Map<String, dynamic> toJson() => _$LandingSectionToJson(this);
}

@JsonSerializable()
class AboutSection {
  final String tagline;
  final String descriptionTitle;
  final String description;
  final String skillsTitle;
  final List<SkillGroup> skillGroups;
  final List<String>? skills;
  final List<String>? otherSkills;
  final String experienceTitle;
  final String experienceSummary;
  final String profileImage;

  AboutSection({
    required this.tagline,
    required this.descriptionTitle,
    required this.description,
    required this.skillsTitle,
    required this.skillGroups,
    this.skills,
    this.otherSkills,
    required this.experienceTitle,
    required this.experienceSummary,
    required this.profileImage,
  });

  factory AboutSection.fromJson(Map<String, dynamic> json) =>
      _$AboutSectionFromJson(json);
  Map<String, dynamic> toJson() => _$AboutSectionToJson(this);
}

@JsonSerializable()
class SocialLink {
  final String platform;
  final String url;
  final String iconAsset;
  final String? hoverColorHex;

  SocialLink({
    required this.platform,
    required this.url,
    required this.iconAsset,
    this.hoverColorHex,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkFromJson(json);
  Map<String, dynamic> toJson() => _$SocialLinkToJson(this);
}

@JsonSerializable()
class Experience {
  final String companyName;
  final String siteUrl;
  final String role;
  final String location;
  final String duration;
  final String logoAsset;
  final String summary;
  final String appName;
  final String appDownloads;
  final String backgroundColorHex;
  final List<DetailBannerData> detailBannerData;

  Experience({
    required this.companyName,
    required this.siteUrl,
    required this.role,
    required this.location,
    required this.duration,
    required this.logoAsset,
    required this.summary,
    required this.appName,
    required this.appDownloads,
    required this.backgroundColorHex,
    required this.detailBannerData,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);
  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}

@JsonSerializable()
class DetailBannerData {
  final String title;
  final String subtitle;

  DetailBannerData({
    required this.title,
    required this.subtitle,
  });

  factory DetailBannerData.fromJson(Map<String, dynamic> json) =>
      _$DetailBannerDataFromJson(json);
  Map<String, dynamic> toJson() => _$DetailBannerDataToJson(this);
}

@JsonSerializable()
class SkillGroup {
  final String category;
  final List<String> skills;

  SkillGroup({
    required this.category,
    required this.skills,
  });

  factory SkillGroup.fromJson(Map<String, dynamic> json) =>
      _$SkillGroupFromJson(json);
  Map<String, dynamic> toJson() => _$SkillGroupToJson(this);
}
