//
//  ResponseLoggerMiddleware.swift
//  
//
//  Created by Jari Kalinainen on 05.12.21.
//

import Logging
import Vapor

/// Emits a log message containing the request method and path to a `Request`'s logger.
/// The log level of the message is configurable.
public final class ResponseLoggingMiddleware: AsyncMiddleware {
    public let logLevel: Logger.Level
    
    public init(logLevel: Logger.Level = .info) {
        self.logLevel = logLevel
    }
    
    public func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        request.headers.add(name: .init("test"), value: "123456")
        let response = try await next.respond(to: request)
        request.logger.log(level: self.logLevel, "\(response.description)")
        return response
    }
}
