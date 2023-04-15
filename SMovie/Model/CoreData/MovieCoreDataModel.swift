
import Foundation
import CoreData
import UIKit

final class MovieCoreDataModel {
    
    static let shared = MovieCoreDataModel()
    private let favVC = FavouriteViewController()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveMovie(name: String, date: String, time: String) -> MoviesCR {
        
        let entity = NSEntityDescription.entity(forEntityName: "MoviesCR", in: context)!
        let movie = NSManagedObject(entity: entity, insertInto: context) as! MoviesCR
        
        movie.name = name
        movie.time = time
        movie.date = date
        
        do {
            try context.save()
            favVC.moviesArray.append(movie)
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
