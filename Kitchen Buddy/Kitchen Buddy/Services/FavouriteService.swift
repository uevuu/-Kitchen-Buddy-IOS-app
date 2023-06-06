//
//  FavouriteService.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 04.06.2023.
//

import CoreData

final class FavouriteService {
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Kitchen_Buddy")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    private lazy var context = persistentContainer.viewContext
    
    private var recipes: [Recipe] = []
    
    func getRecipes() -> [Recipe] {
        let fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        do {
            let savedRecipes = try context.fetch(fetchRequest)
            return savedRecipes.map { savedRecipe in
                convertToRecipe(savedRecipe)
            }
        } catch {
            print("Failed to fetch recipes: \(error)")
            return []
        }
    }
    
    func saveRecipe(_ recipe: Recipe) {
        guard !recipeIsAdded(recipe) else {
            return
        }
        
        let savedRecipe = SavedRecipe(context: context)
        savedRecipe.id = Int64(recipe.id)
        savedRecipe.title = recipe.title
        savedRecipe.image = recipe.image
        savedRecipe.vegetarian = recipe.vegetarian
        savedRecipe.vegan = recipe.vegan
        savedRecipe.veryPopular = recipe.veryPopular
        savedRecipe.cheap = recipe.cheap
        savedRecipe.veryHealthy = recipe.veryHealthy
        savedRecipe.pricePerServing = recipe.pricePerServing
        savedRecipe.servings = Int64(recipe.servings)
        savedRecipe.readyInMinutes = Int64(recipe.readyInMinutes)
        
        recipe.analyzedInstructions.forEach { analyzedInstruction in
            let savedAnalyzedInstruction = SavedAnalyzedInstruction(context: context)
            savedAnalyzedInstruction.addToSteps(convertToSavedSteps(analyzedInstruction.steps))
            savedRecipe.addToAnalyzedInstructions(savedAnalyzedInstruction)
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save recipe: \(error)")
        }
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        let fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", recipe.id)
        do {
            let savedRecipes = try context.fetch(fetchRequest)
            if let savedRecipe = savedRecipes.first {
                context.delete(savedRecipe)
                try context.save()
            }
        } catch {
            print("Failed to delete recipe: \(error)")
        }
    }
    
    func recipeIsAdded(_ recipe: Recipe) -> Bool {
        let fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", recipe.id)
        do {
            let savedRecipes = try context.fetch(fetchRequest)
            return savedRecipes.first != nil
        } catch {
            print("Failed to check if recipe is added: \(error)")
            return false
        }
    }
    
    private func convertToSavedSteps(_ steps: [Step]) -> NSSet {
        let savedSteps = NSMutableSet()
        steps.forEach { step in
            let savedStep = SavedStep(context: context)
            savedStep.number = Int64(step.number)
            savedStep.step = step.step
            savedStep.addToIngredients(convertToSavedIngredients(step.ingredients))
            savedSteps.add(savedStep)
        }
        return savedSteps
    }
    
    private func convertToSavedIngredients(_ ingredients: [Ingredient]) -> NSSet {
        let savedIngredients = NSMutableSet()
        ingredients.forEach { ingredient in
            let savedIngredient = SavedIngredient(context: context)
            savedIngredient.id = Int64(ingredient.id)
            savedIngredient.name = ingredient.name
            savedIngredient.image = ingredient.image
            savedIngredient.amout = ingredient.amout ?? 0
            savedIngredient.unit = ingredient.unit
            savedIngredients.add(savedIngredient)
        }
        return savedIngredients
    }
    
    private func convertToRecipe(_ savedRecipe: SavedRecipe) -> Recipe {
        var steps: [Step] = []
        savedRecipe.analyzedInstructions?.forEach { analyzedInstruction in
            guard let savedAnalyzedInstruction = analyzedInstruction as? SavedAnalyzedInstruction else {
                fatalError("error to get savedAnalyzedInstruction from core data")
            }
            savedAnalyzedInstruction.steps?.forEach { step in
                guard let savedStep = step as? SavedStep else {
                    fatalError("error to get ingredients from core data")
                }
                let ingredients = savedStep.ingredients?.flatMap { ingredient -> [Ingredient] in
                    guard let savedIngredient = ingredient as? SavedIngredient else {
                        fatalError("error to get ingredients from core data")
                    }
                    return [
                        Ingredient(
                            id: Int(savedIngredient.id),
                            name: savedIngredient.name ?? "",
                            image: savedIngredient.image ?? "",
                            amout: savedIngredient.amout,
                            unit: savedIngredient.unit
                        )
                    ]
                }
                steps.append(Step(
                    number: Int(savedStep.number),
                    step: savedStep.step ?? "",
                    ingredients: ingredients ?? [])
                )
                steps.sort { $0.number < $1.number }
            }
        }
        
        return Recipe(
            vegetarian: savedRecipe.vegetarian,
            vegan: savedRecipe.vegan,
            veryPopular: savedRecipe.veryPopular,
            cheap: savedRecipe.cheap,
            veryHealthy: savedRecipe.veryHealthy,
            pricePerServing: savedRecipe.pricePerServing,
            servings: Int(savedRecipe.servings),
            readyInMinutes: Int(savedRecipe.readyInMinutes),
            image: savedRecipe.image,
            title: savedRecipe.title ?? "",
            summary: "",
            analyzedInstructions: [AnalyzedInstruction(steps: steps)],
            id: Int(savedRecipe.id)
        )
    }
}
