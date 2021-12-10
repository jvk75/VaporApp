import Vapor
import AWSClientRuntime

func routes(_ app: Application) throws {
    
   // app.on(.OPTIONS, "*") { r in
   //     return Response(status: .ok, body: .empty)
   // }
    
    app.get { req in
        return "It works!"
    }
    
    app.get("hello") { req in
        //let data = try JSONSerialization .data(withJSONObject: ["foo": "bar"], options: .prettyPrinted)
        //let rsp = Response(status: .ok, headers: ["Content-Type": "application/json"], body: .init(data: data))
        return ["foo": "bar"]
    }
    
    app.post("info") { req -> InfoResponse in
        print(req.headers)
        let data = try req.content.decode(InfoData.self)
        return InfoResponse(request: data)
    }
}

struct InfoResponse: Content {
    let request: InfoData
}

struct InfoData: Content {
    let name: String
}
