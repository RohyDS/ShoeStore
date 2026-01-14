<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <jsp:include page="../common/sidebar.jsp" />

    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <jsp:include page="../common/navbar.jsp" />

        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-7xl">
                <div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900 mb-2">Variantes de Chaussures</h1>
                    </div>
                    <a href="/chaussures-variantes/nouveau" class="bg-brand-600 text-white px-4 py-2 rounded-md hover:bg-brand-700 shadow-sm transition-colors text-sm font-medium flex items-center gap-2">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                        </svg>
                        Ajouter une variante
                    </a>
                </div>

                <!-- Filtres -->
                <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-200 mb-8">
                    <form action="/chaussures-variantes" method="GET" class="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-6 gap-4 items-end">
                        <div>
                            <label class="block text-xs font-semibold text-gray-500 uppercase mb-1">Modèle</label>
                            <input type="text" name="nom" value="${nom}" placeholder="Nom..." class="w-full px-3 py-2 text-sm border border-gray-300 rounded-md focus:ring-brand-500 focus:border-brand-500">
                        </div>
                        <div>
                            <label class="block text-xs font-semibold text-gray-500 uppercase mb-1">Catégorie</label>
                            <select name="categorieId" class="w-full px-3 py-2 text-sm border border-gray-300 rounded-md focus:ring-brand-500 focus:border-brand-500">
                                <option value="">Toutes</option>
                                <c:forEach items="${categories}" var="cat">
                                    <option value="${cat.id}" ${categorieId == cat.id ? 'selected' : ''}>${cat.nom}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label class="block text-xs font-semibold text-gray-500 uppercase mb-1">Genre</label>
                            <select name="genreId" class="w-full px-3 py-2 text-sm border border-gray-300 rounded-md focus:ring-brand-500 focus:border-brand-500">
                                <option value="">Tous</option>
                                <c:forEach items="${genres}" var="g">
                                    <option value="${g.id}" ${genreId == g.id ? 'selected' : ''}>${g.nom}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label class="block text-xs font-semibold text-gray-500 uppercase mb-1">Couleur</label>
                            <select name="couleurId" class="w-full px-3 py-2 text-sm border border-gray-300 rounded-md focus:ring-brand-500 focus:border-brand-500">
                                <option value="">Toutes</option>
                                <c:forEach items="${couleurs}" var="c">
                                    <option value="${c.id}" ${couleurId == c.id ? 'selected' : ''}>${c.nom}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label class="block text-xs font-semibold text-gray-500 uppercase mb-1">Pointure</label>
                            <select name="pointureId" class="w-full px-3 py-2 text-sm border border-gray-300 rounded-md focus:ring-brand-500 focus:border-brand-500">
                                <option value="">Toutes</option>
                                <c:forEach items="${pointures}" var="p">
                                    <option value="${p.id}" ${pointureId == p.id ? 'selected' : ''}>${p.nom}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="flex gap-2">
                            <button type="submit" class="flex-1 bg-gray-900 text-white px-4 py-2 rounded-md hover:bg-gray-800 text-sm font-medium transition-colors">Filtrer</button>
                            <a href="/chaussures-variantes" class="bg-gray-100 text-gray-600 px-4 py-2 rounded-md hover:bg-gray-200 text-sm font-medium transition-colors">RAZ</a>
                        </div>
                    </form>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="min-w-full text-left text-sm whitespace-nowrap">
                            <thead class="bg-gray-50 text-gray-900 font-semibold border-b border-gray-200">
                                <tr>
                                    <th class="px-6 py-3">ID</th>
                                    <th class="px-6 py-3">Modèle</th>
                                    <th class="px-6 py-3">Marque</th>
                                    <th class="px-6 py-3">Couleur</th>
                                    <th class="px-6 py-3">Pointure</th>
                                    <th class="px-6 py-3">Prix</th>
                                    <th class="px-6 py-3">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:forEach items="${variantes}" var="v">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-3 text-gray-500">#${v.id}</td>
                                        <td class="px-6 py-3">
                                            <div class="font-medium text-gray-900">${v.chaussureGenre.chaussure.nom}</div>
                                            <div class="text-xs text-gray-400">${v.chaussureGenre.genre.nom} - ${v.chaussureGenre.categories.nom}</div>
                                        </td>
                                        <td class="px-6 py-3 text-gray-500">${v.chaussureGenre.chaussure.marque.nom}</td>
                                        <td class="px-6 py-3">
                                            <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-gray-100 text-gray-800">
                                                ${v.couleur.nom}
                                            </span>
                                        </td>
                                        <td class="px-6 py-3 text-gray-500">${v.pointure.nom}</td>
                                        <td class="px-6 py-3 font-medium text-brand-600">
                                            <c:choose>
                                                <c:when test="${v.prix != null}">
                                                    ${v.prix} Ar
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-gray-400 text-xs italic">Hérité:</span> ${v.prixEffectif} Ar
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-3">
                                            <div class="flex items-center gap-3">
                                                <a href="/chaussures-variantes/modifier/${v.id}" class="text-brand-600 hover:text-brand-700 font-medium">Modifier</a>
                                                <a href="/chaussures-variantes/supprimer/${v.id}" class="text-red-600 hover:text-red-700 font-medium" onclick="return confirm('Supprimer ?')">Supprimer</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="bg-gray-50 px-6 py-4 border-t border-gray-200 flex items-center justify-between">
                            <div class="text-sm text-gray-500">
                                Affichage de <span class="font-medium">${variantes.size()}</span> sur <span class="font-medium">${totalItems}</span> variantes
                            </div>
                            <div class="flex gap-2">
                                <c:if test="${currentPage > 0}">
                                    <a href="?page=${currentPage - 1}&size=10&nom=${nom}&categorieId=${categorieId}&genreId=${genreId}&couleurId=${couleurId}&pointureId=${pointureId}" class="px-3 py-1 bg-white border border-gray-300 rounded-md text-sm text-gray-600 hover:bg-gray-50 transition-colors">Précédent</a>
                                </c:if>
                                <c:if test="${currentPage < totalPages - 1}">
                                    <a href="?page=${currentPage + 1}&size=10&nom=${nom}&categorieId=${categorieId}&genreId=${genreId}&couleurId=${couleurId}&pointureId=${pointureId}" class="px-3 py-1 bg-white border border-gray-300 rounded-md text-sm text-gray-600 hover:bg-gray-50 transition-colors">Suivant</a>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
