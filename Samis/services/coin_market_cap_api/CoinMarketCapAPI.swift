//
//  CoinMarketCapAPI.swift
//  Samis
//
//  Created by Samuel Ribeiro de Freitas on 10/04/24.
//

import Foundation

struct CMC {
    
    func test() {
        let baseURL = "https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest"
        
        // Parâmetros da requisição
        let slug = "bitcoin"
        let convertID = "2781" // ID para USD, por exemplo
        let url = "\(baseURL)?slug=\(slug)&convert_id=\(convertID)"
        
        // Cria uma sessão URLSession
        let session = URLSession.shared
        
        let group = DispatchGroup()
        
        // Entra no grupo
        group.enter()
        
        // Cria uma tarefa de requisição
        var request = URLRequest(url: URL(string: url)!)
        
        request.addValue("9cc2c8a4-0ed1-4bc4-88da-bd8b4c376620", forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        
        print("ALGUMA COISA")
        
        let task = session.dataTask(with: request) { data, response, error in
            
            print("TASK INICIO")
            // Verifica se há erros
            if let error = error {
                
                print("Erro na requisição: \(error)")
                return
            }
            
            // Verifica se há dados de resposta
            guard let data = data else {
                
                print("GUARD LET")
                
                print("Não foram recebidos dados na resposta.")
                return
            }
            
            print(String(data: data, encoding: .utf8) ?? "Data inválida")
            
            // Converte os dados em formato JSON
            do {
                print("DO")
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let data = json["data"] as? [String: Any],
                           let bitcoinData = data["1"] as? [String: Any],
                           let name = bitcoinData["name"] as? String,
                           let symbol = bitcoinData["symbol"] as? String,
                           let quote = bitcoinData["quote"] as? [String: Any],
                           let usdQuote = quote["2781"] as? [String: Any],
                           let price = usdQuote["price"] as? Double {
                            print("Name: \(name)")
                            print("Symbol: \(symbol)")
                            print("Price: \(price)")
                            // Continue acessando outras propriedades conforme necessário
                        }
                    }
                
            } catch {
                print("CATCH")
                print("Erro ao converter os dados em JSON: \(error)")
            }
            
            // Deixa o grupo após a conclusão da tarefa
            group.leave()
        }
        
        print("ALGUMA COISA 2")
        
        task.resume()
        
        // Espera até que a tarefa seja concluída
        group.wait()
    }

    
}
