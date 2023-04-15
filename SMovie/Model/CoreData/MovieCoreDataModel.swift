
import Foundation
import CoreData
import UIKit

final class MovieCoreDataModel {
    
    static let shared = MovieCoreDataModel()
    private let favVC = FavouriteViewController()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveMovie(name: String, date: String, time: String, image: UIImage) -> MoviesCR {
        
        let entity = NSEntityDescription.entity(forEntityName: "MoviesCR", in: context)!
        let movie = NSManagedObject(entity: entity, insertInto: context) as! MoviesCR
        
        movie.name = name
        movie.time = time
        movie.date = date
        movie.image = image.pngData()
        
        do {
            try context.save()
            return movie
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            fatalError("Failed to save movie")
        }
    }
    
    func getAllMovies() -> [MoviesCR] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MoviesCR")
        
        do {
            let result = try context.fetch(request)
            return result as! [MoviesCR]
        } catch {
            print("Error getting movies: \(error.localizedDescription)")
            return []
        }
    }
}

final class PlayCoreDataModel {
    static let shared = PlayCoreDataModel()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveMovie(name: String, date: String, time: String, image: UIImage) -> PlayesCR {
        
        let entity = NSEntityDescription.entity(forEntityName: "PlayesCR", in: context)!
        let movie = NSManagedObject(entity: entity, insertInto: context) as! PlayesCR
        
        movie.name = name
        movie.time = time
        movie.date = date
        movie.image = image.pngData()
        
        do {
            try context.save()
            return movie
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            fatalError("Failed to save movie")
        }
    }
    
    func getAllMovies() -> [PlayesCR] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayesCR")
        
        do {
            let result = try context.fetch(request)
            return result as! [PlayesCR]
        } catch {
            print("Error getting movies: \(error.localizedDescription)")
            return []
        }
    }
}
