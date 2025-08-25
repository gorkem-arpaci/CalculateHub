//
//  CollegeFunctionsVM.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 23.08.2025.
//

import Foundation

@MainActor
class NewtonRaphsonViewModel: ObservableObject {
    @Published var x: String = ""
    
    private let repository = FormulaRepository()
    
    func calculateNewtonRaphson(x_0: String, func_input: String) async {
        let request = NewtonRapshonRequestDTO(x_0: x_0, func_input: func_input)
        
        do {
            let dto: NewtonRaphsonResponseDTO = try await repository.calculate(formula: .newtonRaphson, requestBody: request)
            
            self.x = dto.toDomain().result
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func calculateGradientDescent(x_0: String, func_input: String, alpha: String) async {
        let request = GradientDescentRequestDTO(x_0: x_0, func_input: func_input, alpha: alpha)
        
        do {
            let dto: GradientDescentResponseDTO = try await repository.calculate(formula: .gradientDescent, requestBody: request)
            
            self.x = dto.toDomain().result
            
        } catch {
            print(error.localizedDescription)
        }
    }

}
