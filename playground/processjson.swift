import Foundation

let jsonStr: String = "{\"version\": \"1.0.1\", \"data\":{\"url\":\"http://www.google.com\", \"user\":\"admin\", \"password\":\"none\"}}"

print("Hello World")

print(jsonStr)

let jsonData = jsonStr.data(using: String.Encoding.ascii)

do {
    let json = try JSONSerialization.jsonObject(with: jsonData!, options: [])
}catch {
    print("exception caught")
    print("Unexpected error: \(error).")

}

print("data=" , jsonData!  , "\n" )

struct CredentialZ: Codable {
    var url: String
    var user: String
    var password: String
}

struct ResponseZ: Codable {
  var version: String
  var data: CredentialZ
}

let decoder = JSONDecoder()
do {
    let responseZ = try decoder.decode(ResponseZ.self, from: jsonData!)

    print("response version = \(responseZ.version)")
    print("credential url = \(responseZ.data.url)")

} catch {
    print("error trying to convert data to JSON")
    print(error)
}
