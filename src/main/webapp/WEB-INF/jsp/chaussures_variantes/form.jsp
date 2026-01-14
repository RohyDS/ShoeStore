<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <jsp:include page="../common/sidebar.jsp" />

    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <jsp:include page="../common/navbar.jsp" />

        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-2xl">
                <div class="mb-8">
                    <h1 class="text-2xl font-bold text-gray-900 mb-2">${variante.id == null ? 'Nouvelle' : 'Modifier'} Variante</h1>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-8">
                    <form:form action="/chaussures-variantes/enregistrer" method="POST" modelAttribute="variante" class="space-y-6">
                        <form:hidden path="id" />
                        
                        <div>
                            <label for="chaussureGenre.id" class="block text-sm font-semibold text-gray-700 mb-2">Modèle de Chaussure, Catégorie & Genre</label>
                            <form:select path="chaussureGenre.id" class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all">
                                <form:option value="" label="-- Sélectionner --" />
                                <c:forEach items="${chaussuresGenres}" var="cg">
                                    <form:option value="${cg.id}" label="${cg.chaussure.nom} - ${cg.categories.nom} (${cg.genre.nom})" />
                                </c:forEach>
                            </form:select>
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label for="couleur.id" class="block text-sm font-semibold text-gray-700 mb-2">Couleur</label>
                                <form:select path="couleur.id" class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all">
                                    <form:option value="" label="-- Sélectionner --" />
                                    <form:options items="${couleurs}" itemValue="id" itemLabel="nom" />
                                </form:select>
                            </div>
                            <div>
                                <label for="pointure.id" class="block text-sm font-semibold text-gray-700 mb-2">Pointure</label>
                                <form:select path="pointure.id" class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all">
                                    <form:option value="" label="-- Sélectionner --" />
                                    <form:options items="${pointures}" itemValue="id" itemLabel="nom" />
                                </form:select>
                            </div>
                        </div>

                        <div>
                            <label for="prix" class="block text-sm font-semibold text-gray-700 mb-2">Prix spécifique (Ar)</label>
                            <form:input path="prix" id="prix"
                                class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all" 
                                placeholder="Laissez vide pour utiliser le prix par défaut" />
                            <form:errors path="prix" class="text-red-500 text-xs mt-1" />
                            <p class="mt-1 text-xs text-gray-500">Si vide, le prix de l'association Chaussure/Genre sera utilisé.</p>
                        </div>

                        <div class="flex items-center justify-end gap-3 pt-4">
                            <a href="/chaussures-variantes" class="px-6 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50 transition-colors shadow-sm">
                                Annuler
                            </a>
                            <button type="submit" class="px-6 py-2 text-sm font-medium text-white bg-brand-600 rounded-md hover:bg-brand-700 transition-colors shadow-sm ring-1 ring-brand-500">
                                Enregistrer
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
