import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.middleware.use(ResponseLoggingMiddleware(logLevel: .info))
    
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .all,
        allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
        allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin, HTTPHeaders.Name("x-loitsut-com")]
    )
    app.middleware.use(CORSMiddleware(configuration: corsConfiguration), at: .beginning)
    
    // register routes
    try routes(app)
}
