
import CoreData
import UIKit

final class MovieCoreDataManager {
    
    static let shared = MovieCoreDataManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func saveRecipe(image: UIImage, name: String, time: String, date: String) -> Movie {
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)!
        let movie = NSManagedObject(entity: entity, insertInto: context) as! Movie
        
        movie.date = date
        movie.name = name
        movie.time = time
        movie.image = image.pngData()
        
        do {
            try context.save()
            return movie
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            fatalError("Failed to save recipe")
        }
    }
    
    func getAllRecipes() -> [Movie] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        
        do {
            let result = try context.fetch(request)
            return result as! [Movie]
        } catch {
            print("Error getting recipes: \(error.localizedDescription)")
            return []
        }
    }
}
