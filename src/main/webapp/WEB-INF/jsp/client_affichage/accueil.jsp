<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Boutique Shoes</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['Inter', 'sans-serif'] },
                    colors: {
                        brand: {
                            50: '#f0f9ff',
                            500: '#0ea5e9',
                            600: '#0284c7',
                            700: '#0369a1'
                        }
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gray-50 min-h-screen">
    <!-- Navbar -->
    <nav class="bg-white border-b border-gray-200 sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16 items-center">
                <div class="flex items-center gap-8">
                    <a href="/clientAffichage/accueil" class="flex items-center gap-2 group">
                        <div class="bg-brand-600 p-2 rounded-lg group-hover:bg-brand-700 transition-colors">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                            </svg>
                        </div>
                        <span class="text-xl font-bold text-gray-900 tracking-tight">Chaussures</span>
                    </a>
                    <div class="hidden md:flex items-center gap-4">
                        <a href="/clientAffichage/accueil" class="text-sm font-bold text-brand-600 transition-colors">Boutique</a>
                        <a href="/clientAffichage/commandes" class="text-sm font-medium text-gray-500 hover:text-brand-600 transition-colors">Mes Commandes</a>
                    </div>
                </div>
                
                <div class="flex items-center gap-6">
                    <div class="hidden md:flex items-center gap-2 text-sm">
                        <span class="text-gray-500">Bienvenue,</span>
                        <span class="font-bold text-gray-900">${client.nom}</span>
                    </div>

                    <!-- Panier Icon -->
                    <a href="/clientAffichage/panier" class="relative group p-2 rounded-xl hover:bg-gray-100 transition-all">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6 text-gray-600 group-hover:text-brand-600">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 10.5V6a3.75 3.75 0 10-7.5 0v4.5m11.356-1.993l1.263 12c.07.665-.45 1.243-1.119 1.243H4.25a1.125 1.125 0 01-1.12-1.243l1.264-12A1.125 1.125 0 015.513 7.5h12.974c.576 0 1.059.435 1.119 1.007zM8.625 10.5a.375.375 0 11-.75 0 .375.375 0 01.75 0zm7.5 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
                        </svg>
                        <c:if test="${panierCount > 0}">
                            <span class="absolute -top-1 -right-1 bg-red-500 text-white text-[10px] font-bold w-5 h-5 flex items-center justify-center rounded-full border-2 border-white">
                                ${panierCount}
                            </span>
                        </c:if>
                    </a>

                    <a href="/clientAffichage/logout" class="text-sm font-medium text-red-600 hover:text-red-700">Déconnexion</a>
                </div>
            </div>
        </div>
    </nav>

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Barre de recherche et filtres -->
        <div class="bg-white rounded-2xl shadow-sm border border-gray-200 p-6 mb-8">
            <form action="/clientAffichage/accueil" method="GET" class="space-y-6">
                <!-- Recherche -->
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 text-gray-400">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z" />
                        </svg>
                    </div>
                    <input type="text" name="nom" value="${nom}" placeholder="Rechercher un modèle de chaussure..." 
                           class="w-full pl-12 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all">
                </div>

                <!-- Filtres -->
                <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div>
                        <label class="block text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">Catégorie</label>
                        <select name="categorieId" class="w-full px-3 py-2 bg-gray-50 border border-gray-200 rounded-lg outline-none focus:ring-2 focus:ring-brand-500">
                            <option value="">Toutes les catégories</option>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.id}" ${categorieId == cat.id ? 'selected' : ''}>${cat.nom}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label class="block text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">Genre</label>
                        <select name="genreId" class="w-full px-3 py-2 bg-gray-50 border border-gray-200 rounded-lg outline-none focus:ring-2 focus:ring-brand-500">
                            <option value="">Tous les genres</option>
                            <c:forEach items="${genres}" var="g">
                                <option value="${g.id}" ${genreId == g.id ? 'selected' : ''}>${g.nom}</option>
                            </c:forEach>
                            <option value="-1" ${genreId == -1 ? 'selected' : ''}>Mixte (M + F)</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">Couleur</label>
                        <select name="couleurId" class="w-full px-3 py-2 bg-gray-50 border border-gray-200 rounded-lg outline-none focus:ring-2 focus:ring-brand-500">
                            <option value="">Toutes les couleurs</option>
                            <c:forEach items="${couleurs}" var="c">
                                <option value="${c.id}" ${couleurId == c.id ? 'selected' : ''}>${c.nom}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label class="block text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">Pointure</label>
                        <select name="pointureId" class="w-full px-3 py-2 bg-gray-50 border border-gray-200 rounded-lg outline-none focus:ring-2 focus:ring-brand-500">
                            <option value="">Toutes les pointures</option>
                            <c:forEach items="${pointures}" var="p">
                                <option value="${p.id}" ${pointureId == p.id ? 'selected' : ''}>${p.nom}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="flex justify-end gap-3">
                    <a href="/clientAffichage/accueil" class="px-6 py-2 text-sm font-medium text-gray-500 hover:text-gray-700">Réinitialiser</a>
                    <button type="submit" class="bg-gray-900 text-white px-8 py-2 rounded-xl text-sm font-bold hover:bg-gray-800 transition-colors shadow-lg shadow-gray-200">
                        Appliquer les filtres
                    </button>
                </div>
            </form>
        </div>

        <!-- Messages de succès/erreur -->
        <c:if test="${param.success != null}">
            <div class="mb-8 p-4 bg-green-50 border border-green-100 text-green-700 text-sm rounded-xl flex items-center gap-3">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                Commande enregistrée avec succès !
            </div>
        </c:if>

        <c:if test="${param.added != null}">
            <div class="mb-8 p-4 bg-indigo-50 border border-indigo-100 text-indigo-700 text-sm rounded-xl flex items-center justify-between">
                <div class="flex items-center gap-3">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 10.5V6a3.75 3.75 0 10-7.5 0v4.5m11.356-1.993l1.263 12c.07.665-.45 1.243-1.119 1.243H4.25a1.125 1.125 0 01-1.12-1.243l1.264-12A1.125 1.125 0 015.513 7.5h12.974c.576 0 1.059.435 1.119 1.007zM8.625 10.5a.375.375 0 11-.75 0 .375.375 0 01.75 0zm7.5 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
                    </svg>
                    Produit ajouté au panier !
                </div>
                <a href="/clientAffichage/panier" class="font-bold underline">Voir le panier</a>
            </div>
        </c:if>

        <c:if test="${param.error != null}">
            <div class="mb-8 p-4 bg-red-50 border border-red-100 text-red-700 text-sm rounded-xl flex items-center gap-3">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z" />
                </svg>
                <c:choose>
                    <c:when test="${param.error == 'stock'}">
                        Stock insuffisant ! Quantité disponible : <span class="font-bold">${param.available}</span>
                    </c:when>
                    <c:otherwise>
                        Une erreur est survenue lors de l'ajout au panier.
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <!-- Grille de produits -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            <c:forEach items="${variantes}" var="v">
                <div class="bg-white rounded-2xl border border-gray-200 overflow-hidden hover:shadow-xl hover:-translate-y-1 transition-all duration-300 flex flex-col">
                    <div class="aspect-square bg-gray-100 relative group">
                        <div class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity bg-black/5">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-12 h-12 text-white/50">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 15.75l5.159-5.159a2.25 2.25 0 013.182 0l5.159 5.159m-1.5-1.5l1.409-1.409a2.25 2.25 0 013.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 001.5-1.5V6a1.5 1.5 0 00-1.5-1.5H3.75A1.5 1.5 0 002.25 6v12a1.5 1.5 0 001.5 1.5zm10.5-11.25h.008v.008h-.008V8.25zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
                            </svg>
                        </div>
                        <div class="absolute top-4 left-4">
                            <span class="bg-white/90 backdrop-blur px-2 py-1 rounded-lg text-[10px] font-bold uppercase tracking-widest text-gray-500 shadow-sm border border-gray-100">
                                ${v.chaussureGenre.chaussure.marque.nom}
                            </span>
                        </div>
                    </div>
                    
                    <div class="p-5 flex-1 flex flex-col">
                        <div class="mb-4">
                            <h3 class="font-bold text-gray-900 text-lg mb-1">${v.chaussureGenre.chaussure.nom}</h3>
                            <div class="flex items-center gap-2 flex-wrap">
                                <span class="px-2 py-0.5 bg-brand-50 text-brand-700 rounded text-xs font-semibold">${v.chaussureGenre.categories.nom}</span>
                                <span class="px-2 py-0.5 bg-gray-100 rounded text-xs font-medium text-gray-600">${v.chaussureGenre.genre.nom}</span>
                                <span class="px-2 py-0.5 bg-gray-100 rounded text-xs font-medium text-gray-600">${v.couleur.nom}</span>
                                <span class="px-2 py-0.5 bg-gray-100 rounded text-xs font-medium text-gray-600">T${v.pointure.nom}</span>
                            </div>
                        </div>

                        <div class="mt-auto pt-4 border-t border-gray-100 flex items-center justify-between gap-4">
                            <div class="flex flex-col">
                                <div class="text-2xl font-black text-brand-600">
                                    <fmt:formatNumber value="${v.prixEffectif}" pattern="#,##0.00" /> Ar
                                </div>
                                <div class="text-xs font-medium ${stocks[v.id] > 0 ? 'text-green-600' : 'text-red-600'}">
                                    Stock: ${stocks[v.id]} disponible
                                </div>
                            </div>
                            
                            <form action="/clientAffichage/panier/ajouter" method="POST" class="flex items-center gap-2">
                                <input type="hidden" name="varianteId" value="${v.id}">
                                <div class="flex flex-col items-center">
                                    <input type="number" name="quantite" value="1" min="1" 
                                           class="w-16 px-2 py-1 bg-gray-50 border border-gray-200 rounded-lg text-sm text-center focus:ring-2 focus:ring-brand-500 outline-none">
                                </div>
                                <button type="submit" class="bg-brand-600 hover:bg-brand-700 text-white p-2.5 rounded-xl shadow-lg shadow-brand-500/20 transition-all transform active:scale-90" title="Ajouter au panier">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-5 h-5">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 3h1.386c.51 0 .955.343 1.087.835l.383 1.437M7.5 14.25a3 3 0 00-3 3h15.75m-12.75-3h11.218c1.121-2.3 2.1-4.684 2.924-7.138a60.114 60.114 0 00-16.536-1.84M7.5 14.25L5.106 5.272M6 20.25a.75.75 0 11-1.5 0 .75.75 0 011.5 0zm12.75 0a.75.75 0 11-1.5 0 .75.75 0 011.5 0z" />
                                    </svg>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <div class="mt-12 flex items-center justify-between border-t border-gray-200 pt-6">
                <div class="text-sm text-gray-500">
                    Affichage de <span class="font-bold text-gray-900">${variantes.size()}</span> sur <span class="font-bold text-gray-900">${totalItems}</span> produits
                </div>
                <div class="flex gap-2">
                    <c:if test="${currentPage > 0}">
                        <a href="?page=${currentPage - 1}&size=12&nom=${nom}&categorieId=${categorieId}&genreId=${genreId}&couleurId=${couleurId}&pointureId=${pointureId}" 
                           class="px-4 py-2 bg-white border border-gray-200 rounded-xl text-sm font-bold text-gray-600 hover:bg-gray-50 transition-colors shadow-sm">
                            Précédent
                        </a>
                    </c:if>
                    <c:if test="${currentPage < totalPages - 1}">
                        <a href="?page=${currentPage + 1}&size=12&nom=${nom}&categorieId=${categorieId}&genreId=${genreId}&couleurId=${couleurId}&pointureId=${pointureId}" 
                           class="px-4 py-2 bg-white border border-gray-200 rounded-xl text-sm font-bold text-gray-600 hover:bg-gray-50 transition-colors shadow-sm">
                            Suivant
                        </a>
                    </c:if>
                </div>
            </div>
        </c:if>
    </main>

    <footer class="bg-white border-t border-gray-200 py-12 mt-20">
        <div class="max-w-7xl mx-auto px-4 text-center">
            <p class="text-gray-400 text-sm font-medium">© 2026 Shoes Boutique. Tous droits réservés.</p>
        </div>
    </footer>
</body>
</html>
