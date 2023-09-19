import 'package:portfolio/core/constants/string_constants.dart';
import 'package:portfolio/feature/emulator/data/work_details_banner_model.dart';

class WorkDetailsBannerRepository {
  WorkDetailsBannerRepository._privateConstructor();

  static final WorkDetailsBannerRepository instance =
      WorkDetailsBannerRepository._privateConstructor();

  List<WorkDetailsBanner> getNowfloatsBanner() {
    return [
      WorkDetailsBanner(
          StringConstants.migration, StringConstants.migrationDesc),
      WorkDetailsBanner(StringConstants.systemArchitecture,
          StringConstants.systemArchitectureDesc),
      WorkDetailsBanner(StringConstants.firebase, StringConstants.firebaseDesc),
      WorkDetailsBanner(
          StringConstants.localDatabase, StringConstants.localDatabaseDesc),
      WorkDetailsBanner(
          StringConstants.deployment, StringConstants.deploymentDesc),
      WorkDetailsBanner(StringConstants.maps, StringConstants.mapsDesc),
      WorkDetailsBanner(StringConstants.modifyingDependencies,
          StringConstants.modifyingDependenciesDesc),
      WorkDetailsBanner(
          StringConstants.majorModules, StringConstants.majorModulesDesc),
    ];
  }

  List<WorkDetailsBanner> getFraazoBanner() {
    return [
      WorkDetailsBanner(StringConstants.summary, StringConstants.summaryDesc),
      WorkDetailsBanner(StringConstants.rest, StringConstants.restDesc),
      WorkDetailsBanner(
          StringConstants.firebase, StringConstants.firebaseFraazoDesc),
      WorkDetailsBanner(
          StringConstants.devTesting, StringConstants.devTestingDesc),
      WorkDetailsBanner(
          StringConstants.majorModules, StringConstants.majorModulesFraazoDesc),
    ];
  }
}
