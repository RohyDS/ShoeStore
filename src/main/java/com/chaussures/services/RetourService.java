package com.chaussures.services;

import com.chaussures.models.CommandesDetails;
import com.chaussures.models.Retour;
import com.chaussures.models.Stock;
import com.chaussures.models.TypeMvtStock;
import com.chaussures.repositories.CommandesDetailsRepository;
import com.chaussures.repositories.RetourRepository;
import com.chaussures.repositories.TypeMvtStockRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class RetourService {

    @Autowired
    private RetourRepository retourRepository;

    @Autowired
    private CommandesDetailsRepository cdRepository;

    @Autowired
    private StockService stockService;

    @Autowired
    private TypeMvtStockRepository typeMvtRepository;

    @Transactional
    public Retour effectuerRetour(Integer idCd, Integer quantite) {
        CommandesDetails cd = cdRepository.findById(idCd)
                .orElseThrow(() -> new RuntimeException("Ligne de commande non trouvée"));

        if (quantite > cd.getQuantite()) {
            throw new RuntimeException("La quantité retournée ne peut pas dépasser la quantité achetée");
        }

        // Calculer le montant à rembourser au prorata du prix payé (déjà après remise dans la DB)
        BigDecimal prixUnitairePaye = cd.getPrix();
        BigDecimal montantRembourse = prixUnitairePaye.multiply(new BigDecimal(quantite));

        // 1. Créer le retour
        Retour retour = new Retour();
        retour.setCommandeDetail(cd);
        retour.setQuantite(quantite);
        retour.setMontantRembourse(montantRembourse);
        retour.setDateRetour(LocalDateTime.now());
        Retour saved = retourRepository.save(retour);

        // 2. Réintégrer en stock
        TypeMvtStock typeEntree = typeMvtRepository.findAll().stream()
                .filter(t -> t.getNom().equalsIgnoreCase("Entrée"))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Type mouvement Entrée non trouvé"));

        Stock stock = new Stock();
        stock.setChaussuresCouleurPointure(cd.getChaussuresCouleurPointure());
        stock.setTypeMvtStock(typeEntree);
        stock.setQuantite(quantite);
        stock.setDateMvt(LocalDateTime.now());
        stockService.save(stock);

        return saved;
    }

    public List<Retour> findAll() {
        return retourRepository.findAll();
    }

    public BigDecimal getTotalRetours() {
        BigDecimal total = retourRepository.getTotalRetours();
        return total != null ? total : BigDecimal.ZERO;
    }
}
