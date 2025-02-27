//
//  ViewController.swift
//  MapApp
//
//  Created by Furkan buğra karcı on 30.07.2024.
//

import UIKit
import MapKit
import CoreLocation
import CoreData
class ViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    
    
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager=CLLocationManager()
    var chosenLatitude=Double()
    var chosenLongitude=Double()

    
    var selectedTitle=""
    var selectedTitleId:UUID?
    var annotationTitle=""
    var annotatoinSubtitle=""
    var annotationLongitude=Double()
    var annotationLatitute=Double()

    override func viewDidLoad() {
        super.viewDidLoad()
        //konum alma ve mapte konumu gösterme
        mapView.delegate=self
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        //bura kadar
        
        
        
        //pin eklemek için(gestureRecognizer ile ekranla kullanıcı etkileşime geçtiğinde )
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 1
        mapView.addGestureRecognizer(gestureRecognizer)
        
        
        if selectedTitle != ""{
            let appDelegate=UIApplication.shared.delegate as! AppDelegate
            let context=appDelegate.persistentContainer.viewContext
            let idString=selectedTitleId!.uuidString
            let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            
            fetchRequest.predicate=NSPredicate(format: "id=%@",idString)
            fetchRequest.returnsObjectsAsFaults=false
            
            do{
                let results=try context.fetch(fetchRequest)
                if results.count>0{
                    for result in results as! [NSManagedObject]{
                        
                        
                        if let title=result.value(forKey: "title") as? String{
                            self.annotationTitle=title
                            if let subtitle=result.value(forKey: "subtitle") as? String{
                                self.annotatoinSubtitle=subtitle
                                if let latitute=result.value(forKey: "latitute") as?    Double{
                                    self.annotationLatitute=latitute
                                    if let longitude=result.value(forKey: "longitude") as? Double{
                                        self .annotationLongitude=longitude
                                        
                                        let annotation=MKPointAnnotation()
                                        annotation.title=annotationTitle
                                        annotation.subtitle=annotatoinSubtitle
                                        let coordinate=CLLocationCoordinate2D(latitude: annotationLatitute, longitude: annotationLongitude)
                                        annotation.coordinate=coordinate
                                        
                                        mapView.addAnnotation(annotation)
                                        nameText.text=annotationTitle
                                        commentText.text=annotatoinSubtitle
                                        locationManager.stopUpdatingLocation()
                                        
                                        let span=MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                                        let region=MKCoordinateRegion(center: coordinate, span: span)
                                        mapView.setRegion(region, animated: true)
                                    }
                                }
                            }
                        }
                        
                        
                        
                        
                    }
                }
            }catch{
                print("error")
            }
            
            
        }
        else{
            
        }
        
    }
    @objc func chooseLocation(gestureRecognizer:UILongPressGestureRecognizer){
        
        if gestureRecognizer.state == .began{
            let  touchedPoint=gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates=self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            chosenLatitude=touchedCoordinates.latitude
            chosenLongitude=touchedCoordinates.longitude
            let annotation = MKPointAnnotation()
            annotation.coordinate=touchedCoordinates
            annotation.title = nameText.text
            annotation.subtitle = commentText.text
            self.mapView.addAnnotation(annotation)
            //pin bura kadar
        }
        
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if selectedTitle == ""{
            //konum alma ve mapte konumu gösterme
            let location=CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            let span=MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true) }
        else{
            
        }
    }
    
    //mapte pini özelleştirme ve yol tarifi
    func mapView(_ mapView: MKMapView, viewFor annotation:MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation{
            return nil
        }
        let reuseID="myAnnotation"
        
        var pinView=mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKMarkerAnnotationView
        
        if pinView==nil{
            pinView=MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView?.canShowCallout=true
            pinView?.tintColor=UIColor.black
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView=button
        }else {
            pinView?.annotation=annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
       
        
        
        if selectedTitle != ""{
            var requestLocation=CLLocation(latitude: annotationLatitute, longitude: annotationLongitude)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
                
                if placemarks!.count > 0{
                    let newPlaceMark=MKPlacemark(placemark: placemarks![0])
                    let item=MKMapItem(placemark: newPlaceMark)
                    item.name=self.annotationTitle
                    let launchOptions=[MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                    item.openInMaps(launchOptions: launchOptions)
                    
                }
            }
        }
    }
    //bura kadar
    
    @IBAction func saveButton(_ sender: Any) {
        
        //database e kaydetmek için yapılması gereken sabit işler
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        // databasein ismi-------------------------------------------------->
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        //kullanıcıdan alınan valueları databesdeki kolonlara eşitleme
        newPlace.setValue(nameText.text, forKey: "title")
        newPlace.setValue(commentText.text, forKey: "subtitle")
        newPlace.setValue(chosenLatitude, forKey: "latitute")
        newPlace.setValue(chosenLongitude, forKey: "longitude")
        newPlace.setValue(UUID(), forKey: "id")
        //oluşturulan contexti save etme
        do{
            try context.save()
            print("success")
        }catch{
            print("failed")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newPlace"), object:nil)
        navigationController?.popViewController(animated: true)
        }
        }
    




