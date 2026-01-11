<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Panier - Chaussures</title>
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
                <div class="flex items-center">
                    <a href="/clientAffichage/accueil" class="flex items-center gap-2 group">
                        <div class="bg-indigo-600 p-2 rounded-lg group-hover:bg-indigo-700 transition-colors">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                            </svg>
                        </div>
                        <span class="text-xl font-bold text-gray-900 tracking-tight">Chaussures</span>
                    </a>
                </div>
                <div class="flex items-center gap-4">
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
            <h1 class="text-3xl font-extrabold text-gray-900">Mon Panier</h1>
        </div>

        <c:choose>
            <c:when test="${empty panier}">
                <div class="bg-white rounded-2xl shadow-sm border border-gray-200 p-12 text-center">
                    <div class="w-20 h-20 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-6">
                        <svg class="w-10 h-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                        </svg>
                    </div>
                    <h2 class="text-xl font-bold text-gray-900 mb-2">Votre panier est vide</h2>
                    <p class="text-gray-500 mb-8">Il semble que vous n'ayez pas encore ajouté d'articles.</p>
                    <a href="/clientAffichage/accueil" class="inline-flex items-center justify-center px-6 py-3 border border-transparent text-base font-medium rounded-xl text-white bg-indigo-600 hover:bg-indigo-700 transition-all">
                        Continuer mes achats
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- Liste des articles -->
                    <div class="lg:col-span-2 space-y-4">
                        <c:forEach items="${panier}" var="item">
                            <div class="bg-white rounded-2xl shadow-sm border border-gray-200 p-6 flex flex-col sm:flex-row gap-6 hover:shadow-md transition-shadow">
                                <div class="w-24 h-24 bg-gray-50 rounded-xl flex items-center justify-center flex-shrink-0">
                                    <svg class="w-12 h-12 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                    </svg>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <div class="flex justify-between items-start mb-2">
                                        <div>
                                            <h3 class="text-lg font-bold text-gray-900 truncate">${item.nom}</h3>
                                            <div class="flex flex-wrap gap-2 mt-1">
                                                <span class="px-2 py-0.5 rounded-full bg-indigo-50 text-indigo-700 text-xs font-semibold uppercase tracking-wider">${item.categorie}</span>
                                                <span class="px-2 py-0.5 rounded-full bg-purple-50 text-purple-700 text-xs font-semibold uppercase tracking-wider">${item.genre}</span>
                                            </div>
                                        </div>
                                        <a href="/clientAffichage/panier/supprimer/${item.varianteId}" class="text-gray-400 hover:text-red-600 transition-colors p-1">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                            </svg>
                                        </a>
                                    </div>
                                    <div class="flex flex-wrap gap-x-4 gap-y-1 text-sm text-gray-500 mb-4">
                                        <p>Couleur: <span class="text-gray-900 font-medium">${item.couleur}</span></p>
                                        <p>Pointure: <span class="text-gray-900 font-medium">${item.pointure}</span></p>
                                    </div>
                                    <div class="flex justify-between items-end">
                                        <div class="text-sm">
                                            <span class="text-gray-500">Prix:</span>
                                            <span class="text-gray-900 font-bold ml-1">
                                                <fmt:formatNumber value="${item.prix}" type="currency" currencySymbol="$" />
                                            </span>
                                            <span class="text-gray-400 mx-2">×</span>
                                            <span class="text-gray-900 font-bold">${item.quantite}</span>
                                        </div>
                                        <div class="text-indigo-600 font-extrabold text-lg">
                                            <fmt:formatNumber value="${item.total}" type="currency" currencySymbol="$" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Résumé de la commande -->
                    <div class="lg:col-span-1">
                        <div class="bg-white rounded-2xl shadow-sm border border-gray-200 p-6 sticky top-24">
                            <h2 class="text-xl font-bold text-gray-900 mb-6 border-b border-gray-100 pb-4">Résumé</h2>
                            <div class="space-y-4 mb-6">
                                <div class="flex justify-between text-gray-600">
                                    <span>Sous-total</span>
                                    <span class="font-medium text-gray-900">
                                        <fmt:formatNumber value="${total}" type="currency" currencySymbol="$" />
                                    </span>
                                </div>
                                <div class="flex justify-between text-gray-600">
                                    <span>Livraison</span>
                                    <span class="font-medium text-green-600">Gratuite</span>
                                </div>
                                <div class="border-t border-gray-100 pt-4 flex justify-between">
                                    <span class="text-lg font-bold text-gray-900">Total</span>
                                    <span class="text-2xl font-black text-indigo-600">
                                        <fmt:formatNumber value="${total}" type="currency" currencySymbol="$" />
                                    </span>
                                </div>
                            </div>
                            <form action="/clientAffichage/panier/valider" method="post">
                                <button type="submit" class="w-full bg-indigo-600 text-white font-bold py-4 rounded-xl hover:bg-indigo-700 shadow-lg shadow-indigo-200 transition-all transform hover:-translate-y-0.5 active:translate-y-0">
                                    Valider la commande
                                </button>
                            </form>
                            <p class="text-center text-xs text-gray-400 mt-4">
                                En validant, vous acceptez nos conditions générales de vente.
                            </p>
                        </div>
                    </div>
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
