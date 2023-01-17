import Compute
import Upstash

let router = Router()

router.get("/:key") { req, res in
    let secrets = try ConfigStore(name: "secrets")
    guard let upstashHostName = secrets.get("REDIS_HOST_NAME"),
          let upstashToken = secrets.get("REDIS_REST_TOKEN"),
          let key = req.pathParams.get("key") else {
        try await res.status(400).write("Bad request")
        return
    }
    
    let client = RedisClient(hostname: upstashHostName, token: upstashToken)
    do {
        let redirectPath: String = try await client.get(key)
        try await res.redirect(redirectPath, permanent: true)
    } catch {
        try await res.status(404).write("Could not find link for that key...")
    }
}

try await router.listen()
