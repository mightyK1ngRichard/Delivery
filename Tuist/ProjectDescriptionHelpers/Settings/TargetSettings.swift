import ProjectDescription

public enum TargetSettings {

    public static let mainBundleId = "com.mightykingrichard.DeliveryApp"
    public static let destinations: Destinations = [.iPhone]
    public static let deploymentTargets: DeploymentTargets = .iOS("16.0")
    public static let deploymentTestingTargets: DeploymentTargets = .iOS("18.0")
    public static let swiftVersion: String = "6.0"
}
