import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var services = [Service]()
    
    func parse() {
            let urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let data = data else { return }
                do {
                    let jsonData = try JSONDecoder().decode(Response.self, from: data)
                    let body = jsonData.body
                    self.services = body.services
                } catch {
                    print(error)
                }
            }.resume()
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellService", for: indexPath)
        cell.textLabel?.text = services[indexPath.row].name
        cell.detailTextLabel?.text = services[indexPath.row].description
        cell.imageView?.image = UIImage(data: try! Data(contentsOf: URL(string: services[indexPath.row].icon_url)!))
        cell.imageView?.contentMode = .scaleToFill
        
        cell.accessoryType = .disclosureIndicator
            cell.tintColor = .gray
        let image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
            if let width = image?.size.width, let height = image?.size.height {
                let disclosureImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
                disclosureImageView.image = image
                cell.accessoryView = disclosureImageView
            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        parse()
        tableView.rowHeight = 80
    }
}

