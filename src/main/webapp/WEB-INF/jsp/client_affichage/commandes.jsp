<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Commandes - Chaussures</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
    <!-- Navigation -->
    <nav class="bg-white border-b border-gray-200 sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center gap-8">
                    <a href="/clientAffichage/accueil" class="flex items-center gap-2 group">
                        <div class="bg-indigo-600 p-2 rounded-lg group-hover:bg-indigo-700 transition-colors">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                            </svg>
                        </div>
                        <span class="text-xl font-bold text-gray-900 tracking-tight">Chaussures</span>
                    </a>
                    <div class="hidden md:flex items-center gap-4">
                        <a href="/clientAffichage/accueil" class="text-sm font-medium text-gray-500 hover:text-indigo-600 transition-colors">Boutique</a>
                        <a href="/clientAffichage/commandes" class="text-sm font-bold text-indigo-600 transition-colors">Mes Commandes</a>
                    </div>
                </div>
                <div class="flex items-center gap-4">
                    <a href="/clientAffichage/panier" class="relative group p-2 rounded-xl hover:bg-gray-100 transition-all">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6 text-gray-600 group-hover:text-indigo-600">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 10.5V6a3.75 3.75 0 10-7.5 0v4.5m11.356-1.993l1.263 12c.07.665-.45 1.243-1.119 1.243H4.25a1.125 1.125 0 01-1.12-1.243l1.264-12A1.125 1.125 0 015.513 7.5h12.974c.576 0 1.059.435 1.119 1.007zM8.625 10.5a.375.375 0 11-.75 0 .375.375 0 01.75 0zm7.5 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
                        </svg>
                        <c:if test="${panierCount > 0}">
                            <span class="absolute -top-1 -right-1 bg-red-500 text-white text-[10px] font-bold w-5 h-5 flex items-center justify-center rounded-full border-2 border-white">
                                ${panierCount}
                            </span>
                        </c:if>
                    </a>
                    <div class="h-8 w-px bg-gray-200 mx-2"></div>
                    <span class="text-sm text-gray-600 font-medium">Bonjour, ${client.nom}</span>
                    <a href="/clientAffichage/logout" class="text-sm text-red-600 hover:text-red-700 font-semibold px-3 py-1.5 rounded-md hover:bg-red-50 transition-all">Déconnexion</a>
                </div>
            </div>
        </div>
    </nav>

    <main class="max-w-5xl mx-auto px-4 py-12">
        <div class="flex items-center gap-4 mb-8">
            <a href="/clientAffichage/accueil" class="text-gray-500 hover:text-indigo-600 transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                </svg>
            </a>
            <h1 class="text-3xl font-extrabold text-gray-900">Historique des commandes</h1>
        </div>

        <c:if test="${param.returned == 'true'}">
            <div class="mb-6 p-4 bg-green-50 border border-green-200 text-green-700 rounded-xl flex items-center gap-3">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                <span class="text-sm font-medium">L'article a été retourné avec succès. Le montant a été déduit du CA.</span>
            </div>
        </c:if>

        <c:if test="${not empty param.error}">
            <div class="mb-6 p-4 bg-red-50 border border-red-200 text-red-700 rounded-xl flex items-center gap-3">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
                <span class="text-sm font-medium">Erreur : ${param.error}</span>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty commandes}">
                <div class="bg-white rounded-2xl shadow-sm border border-gray-200 p-12 text-center">
                    <div class="w-20 h-20 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-6">
                        <svg class="w-10 h-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                        </svg>
                    </div>
                    <h2 class="text-xl font-bold text-gray-900 mb-2">Aucune commande</h2>
                    <p class="text-gray-500 mb-8">Vous n'avez pas encore passé de commande.</p>
                    <a href="/clientAffichage/accueil" class="inline-flex items-center justify-center px-6 py-3 border border-transparent text-base font-medium rounded-xl text-white bg-indigo-600 hover:bg-indigo-700 transition-all">
                        Découvrir nos produits
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="space-y-6">
                    <c:forEach items="${commandes}" var="commande">
                        <div class="bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden">
                            <!-- En-tête de la commande -->
                            <div class="bg-gray-50 px-6 py-4 border-b border-gray-200 flex flex-wrap justify-between items-center gap-4">
                                <div class="flex gap-8">
                                    <div>
                                        <p class="text-xs text-gray-500 uppercase font-bold tracking-wider">Date</p>
                                        <p class="text-sm font-semibold text-gray-900">
                                            <fmt:parseDate value="${commande.dateCommande}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm" />
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-xs text-gray-500 uppercase font-bold tracking-wider">Commande N°</p>
                                        <p class="text-sm font-semibold text-gray-900">#CMD-${commande.id}</p>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <p class="text-xs text-gray-500 uppercase font-bold tracking-wider">Total (avec livraison)</p>
                                    <c:set var="totalCommande" value="0" />
                                    <c:set var="totalFrais" value="0" />
                                    <c:set var="totalRembourse" value="0" />
                                    <c:forEach items="${commande.details}" var="d">
                                        <c:set var="totalCommande" value="${totalCommande + (d.prix * d.quantite)}" />
                                        <c:if test="${d.lieu != null}">
                                            <c:set var="totalFrais" value="${totalFrais + fraisMap[d.lieu.id]}" />
                                        </c:if>
                                        <c:forEach items="${d.retours}" var="r">
                                            <c:set var="totalRembourse" value="${totalRembourse + r.montantRembourse}" />
                                        </c:forEach>
                                    </c:forEach>
                                    
                                    <div class="flex flex-col items-end">
                                        <p class="text-lg font-black text-indigo-600">
                                            <fmt:formatNumber value="${totalCommande + totalFrais}" pattern="#,##0.00" /> Ar
                                        </p>
                                        <c:if test="${totalRembourse > 0}">
                                            <p class="text-sm font-bold text-red-600 mt-1">
                                                - <fmt:formatNumber value="${totalRembourse}" pattern="#,##0.00" /> Ar (Remboursé)
                                            </p>
                                            <div class="h-px w-24 bg-gray-200 my-1"></div>
                                            <p class="text-sm font-black text-gray-900">
                                                Net: <fmt:formatNumber value="${totalCommande + totalFrais - totalRembourse}" pattern="#,##0.00" /> Ar
                                            </p>
                                        </c:if>
                                    </div>
                                    
                                    <c:if test="${totalFrais > 0}">
                                        <p class="text-[10px] text-gray-400">Inclut <fmt:formatNumber value="${totalFrais}" pattern="#,##0.00" /> Ar de frais totaux</p>
                                    </c:if>
                                </div>
                            </div>

                            <!-- Détails de la commande -->
                            <div class="p-6">
                                <ul class="divide-y divide-gray-100">
                                    <c:forEach items="${commande.details}" var="detail">
                                        <li class="py-4 flex gap-6">
                                            <div class="w-16 h-16 bg-gray-50 rounded-lg flex items-center justify-center flex-shrink-0">
                                                <svg class="w-8 h-8 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                                </svg>
                                            </div>
                                            <div class="flex-1 min-w-0">
                                                <div class="flex justify-between items-start">
                                                    <div>
                                                        <h4 class="text-sm font-bold text-gray-900">
                                                            ${detail.chaussuresCouleurPointure.chaussureGenre.chaussure.nom}
                                                        </h4>
                                                        <div class="flex gap-2 mt-1">
                                                            <span class="text-xs text-gray-500">${detail.chaussuresCouleurPointure.couleur.nom}</span>
                                                            <span class="text-xs text-gray-300">|</span>
                                                            <span class="text-xs text-gray-500">Pointure: ${detail.chaussuresCouleurPointure.pointure.nom}</span>
                                                        </div>
                                                        <c:if test="${detail.lieu != null}">
                                                            <div class="mt-2 flex items-center gap-2">
                                                                <span class="px-2 py-0.5 bg-blue-50 text-blue-700 text-[10px] font-bold rounded uppercase">Livraison: ${detail.lieu.nom}</span>
                                                                <span class="text-[10px] text-gray-400">+ <fmt:formatNumber value="${fraisMap[detail.lieu.id]}" pattern="#,##0.00" /> Ar</span>
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                    <div class="text-right space-y-1">
                                                        <div class="text-sm">
                                                            <span class="text-gray-500">Sous-total:</span>
                                                            <span class="font-bold text-gray-900">
                                                                <fmt:formatNumber value="${detail.prix * detail.quantite}" pattern="#,##0.00" /> Ar
                                                            </span>
                                                        </div>
                                                        <c:if test="${detail.lieu != null}">
                                                            <div class="text-sm">
                                                                <span class="text-gray-500">Frais:</span>
                                                                <span class="font-bold text-blue-600">
                                                                    + <fmt:formatNumber value="${fraisMap[detail.lieu.id]}" pattern="#,##0.00" /> Ar
                                                                </span>
                                                            </div>
                                                        </c:if>
                                                        <div class="text-sm border-t border-gray-50 pt-1">
                                                            <span class="text-gray-500">Total:</span>
                                                            <c:set var="fraisLigne" value="${detail.lieu != null ? fraisMap[detail.lieu.id] : 0}" />
                                                            <span class="font-black text-indigo-600">
                                                                <fmt:formatNumber value="${(detail.prix * detail.quantite) + fraisLigne}" pattern="#,##0.00" /> Ar
                                                            </span>
                                                        </div>
                                                        
                                                        <c:set var="totalRembourseLigne" value="0" />
                                                        <c:forEach items="${detail.retours}" var="r">
                                                            <c:set var="totalRembourseLigne" value="${totalRembourseLigne + r.montantRembourse}" />
                                                        </c:forEach>
                                                        
                                                        <c:if test="${totalRembourseLigne > 0}">
                                                            <div class="text-sm font-bold text-gray-900 mt-1">
                                                                <span class="text-gray-500 text-xs">Net:</span>
                                                                <fmt:formatNumber value="${(detail.prix * detail.quantite) + fraisLigne - totalRembourseLigne}" pattern="#,##0.00" /> Ar
                                                            </div>
                                                        </c:if>
                                                        <p class="text-[10px] text-gray-400">${detail.quantite} x <fmt:formatNumber value="${detail.prix}" pattern="#,##0.00" /> Ar</p>
                                                        
                                                        <!-- Affichage des retours déjà effectués -->
                                                        <c:if test="${not empty detail.retours}">
                                                            <div class="mt-3 p-2 bg-red-50 rounded-lg border border-red-100">
                                                                <p class="text-[10px] font-bold text-red-600 uppercase mb-1">Articles retournés</p>
                                                                <c:forEach items="${detail.retours}" var="r">
                                                                    <div class="flex justify-between items-center text-[10px] text-red-500 italic mb-1 last:mb-0">
                                                                        <div class="flex flex-col">
                                                                            <span>
                                                                                <fmt:parseDate value="${r.dateRetour}" pattern="yyyy-MM-dd'T'HH:mm" var="rDate" type="both" />
                                                                                <fmt:formatDate value="${rDate}" pattern="dd/MM/yyyy HH:mm" />
                                                                            </span>
                                                                            <span class="font-bold">-${r.quantite} unité(s)</span>
                                                                            <c:if test="${not empty r.motif}">
                                                                                <span class="text-[9px] text-gray-400 mt-0.5">Motif: ${r.motif}</span>
                                                                            </c:if>
                                                                        </div>
                                                                        <span class="font-black text-xs">
                                                                            - <fmt:formatNumber value="${r.montantRembourse}" pattern="#,##0.00" /> Ar
                                                                        </span>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </c:if>

                                                        <!-- Formulaire de retour -->
                                                        <form action="/clientAffichage/commande/retourner" method="POST" class="mt-4 flex flex-col gap-2 items-end">
                                                            <input type="hidden" name="idCd" value="${detail.idCd}">
                                                            <div class="flex items-center gap-2">
                                                                <input type="text" name="motif" placeholder="Motif du retour..." 
                                                                       class="w-40 px-2 py-1 text-xs border border-gray-300 rounded-lg focus:ring-1 focus:ring-indigo-500 outline-none">
                                                                <input type="number" name="quantite" min="1" max="${detail.quantite}" value="1" 
                                                                       class="w-16 px-2 py-1 text-xs border border-gray-300 rounded-lg focus:ring-1 focus:ring-indigo-500 outline-none">
                                                                <button type="submit" 
                                                                        class="text-[10px] font-bold uppercase tracking-wider bg-red-50 text-red-600 px-3 py-1.5 rounded-lg hover:bg-red-600 hover:text-white transition-all">
                                                                    Retourner
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <footer class="bg-white border-t border-gray-200 mt-auto py-8">
        <div class="max-w-7xl mx-auto px-4 text-center text-gray-500 text-sm">
            &copy; 2026 Chaussures Inc. Tous droits réservés.
        </div>
    </footer>
</body>
</html>
