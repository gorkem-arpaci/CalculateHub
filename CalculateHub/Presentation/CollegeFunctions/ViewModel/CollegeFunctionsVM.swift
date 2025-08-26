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
            let dto: IterationResponseDTO = try await repository.calculate(
                formula: .newtonRaphson,
                requestBody: request
            )

            self.x = dto.toDomain().result
        } catch {
            print(error.localizedDescription)
        }

    }

    func calculateGradientDescent(
        x_0: String,
        func_input: String,
        alpha: String
    ) async {
        let request = GradientDescentRequestDTO(
            x_0: x_0,
            func_input: func_input,
            alpha: alpha
        )

        do {
            let dto: IterationResponseDTO =
                try await repository.calculate(
                    formula: .gradientDescent,
                    requestBody: request
                )

            self.x = dto.toDomain().result

        } catch {
            print(error.localizedDescription)
        }
    }

    func calculateSafeGuarded(x_0: String, func_input: String)
        async
    {
        let request = SafeGuardedRequestDTO(x_0: x_0, func_input: func_input)

        do {
            let dto: IterationResponseDTO = try await repository.calculate(
                formula: .gradientDescent,
                requestBody: request
            )

            self.x = dto.toDomain().result

        } catch {
            print(error.localizedDescription)
        }
    }
    
    func calculateConjugate(func_input: String, nums: String) async {
        let request = ConjugateRequestDTO(func_input: func_input, nums: nums)
        
        do {
            let dto: IterationResponseDTO = try await repository.calculate(formula: .conjugate, requestBody: request)
            
            self.x = dto.toDomain().result
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func calculateSecant(x_0: String, x_1: String, func_input: String) async {
        let request = SecantRequestDTO(x_0: x_0, x_1: x_1, func_input: func_input)
        
        do {
            let dto: IterationResponseDTO = try await repository.calculate(formula: .secant, requestBody: request)
            
            self.x = dto.toDomain().result
        } catch {
            print(error.localizedDescription)
        }
    }

    func calculateBisection(a: String, b: String, func_input: String) async {
        let request = BisectionRequestDTO(a: a, b: b, func_input: func_input)
        
        do {
            let dto: IterationResponseDTO = try await repository.calculate(formula: .bisection, requestBody: request)
            
            
            self.x = dto.toDomain().result
            
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
}
