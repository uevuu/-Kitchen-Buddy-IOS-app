import Moya

protocol NetworkServiceProtocol {
    func sendRequest<T: Decodable>(target: RecipesAPITarget, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    var provider = MoyaProvider<RecipesAPITarget>()
        
    func sendRequest<T: Decodable>(
        target: RecipesAPITarget,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let result = try JSONDecoder().decode(T.self, from: moyaResponse.data)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
