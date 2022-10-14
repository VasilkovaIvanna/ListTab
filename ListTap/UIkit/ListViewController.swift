import UIKit

class ListViewController: UIViewController, ListViewProtocol {
    
    func update() {
        controlButton.setTitle(viewModel.model.isActiveTimer ? "Stop" : "Start", for: .normal)
        collectionView.reloadData()
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var controlButton: UIButton!
    
    var viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionView.delegate = self
        setupControlButton()
        setupCollectionView()
    }
    
    @IBAction func onTappedControlButton(_ sender: UIButton) {
        viewModel.manageTimer()
    }
    
    
    private func setupControlButton(){
        controlButton.layer.cornerRadius = 5
    }
    
    private func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView.collectionViewLayout = layout
    }
    
    private func uiColorForElement(elementColor: ElementColor) -> UIColor? {
        switch elementColor {
        case .blue:
            return .customBlue
        case .orange:
            return .customOrange
        }
    }
}


extension ListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.model.elementsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ListCollectionViewCell
        
        let element = viewModel.model.elementsList[indexPath.row]
        
        cell.backgroundColor = .clear
        cell.separatorView.isHidden = indexPath.row == viewModel.model.elementsList.count - 1 ? true : false
        cell.circleImage.tintColor = uiColorForElement(elementColor: element.color)
        cell.numberLabel.text = String(element.number)
        
        return cell
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.performRandomAction(index: indexPath.row)
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.collectionView.frame.width, height: 80)
    }
}
