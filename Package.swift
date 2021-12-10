// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "VaporApp",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/awslabs/aws-sdk-swift", from: "0.1.0"),
        .package(url: "https://github.com/swift-server/swift-backtrace.git", from: "1.3.1"),
        .package(url: "https://github.com/vapor-community/vapor-aws-lambda-runtime", from: "0.6.0")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "AWSDynamoDB", package: "aws-sdk-swift"),
                .product(name: "Backtrace", package: "swift-backtrace"),
                .product(name: "VaporAWSLambdaRuntime", package: "vapor-aws-lambda-runtime")
            ],
            swiftSettings: [
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ],
            linkerSettings: [
                .unsafeFlags(["-v"], .when(configuration: .release))
//                .linkedLibrary("icui18n"),
//                .linkedLibrary("icuuc"),
//                .linkedLibrary("icudata"),
//                .linkedLibrary("z"),
//                .linkedLibrary("lzma")
            ]
        ),
        .executableTarget(
            name: "Run",
            dependencies: [
                .target(name: "App")
            ]
        ),
        .testTarget(
            name: "AppTests",
            dependencies: [
                .target(name: "App"),
                .product(name: "XCTVapor", package: "vapor"),
            ]
        )
    ]
)
