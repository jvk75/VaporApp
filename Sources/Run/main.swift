import App
import Vapor
import Backtrace
import VaporAWSLambdaRuntime

//Backtrace.install()
var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }
try configure(app)

#if DEBUG
app.servers.use(.http)
#else
app.servers.use(.http) //lambda)
#endif

try app.run()
