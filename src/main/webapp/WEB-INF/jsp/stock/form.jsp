<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <!-- Sidebar -->
    <jsp:include page="../common/sidebar.jsp" />

    <!-- Main Content Wrapper -->
    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <!-- Top Navbar -->
        <jsp:include page="../common/navbar.jsp" />

        <!-- Main Page Content -->
        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-2xl">
                
                <!-- Page Header -->
                <div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                         <h1 class="text-2xl font-bold text-gray-900 mb-2">Nouveau Mouvement de Stock</h1>
                        <nav class="flex" aria-label="Breadcrumb">
                            <ol class="inline-flex items-center space-x-1 md:space-x-2">
                                <li class="inline-flex items-center">
                                    <a href="/stock" class="inline-flex items-center text-sm font-medium text-gray-500 hover:text-brand-600">
                                        <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                            <path d="M7 3a1 1 0 000 2h6a1 1 0 100-2H7zM4 7a1 1 0 011-1h10a1 1 0 110 2H5a1 1 0 01-1-1zM2 11a2 2 0 012-2h12a2 2 0 012 2v4a2 2 0 01-2 2H4a2 2 0 01-2-2v-4z" />
                                        </svg>
                                        Gestion Stock
                                    </a>
                                </li>
                                <li>
                                    <div class="flex items-center">
                                        <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                        <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">Nouveau</span>
                                    </div>
                                </li>
                            </ol>
                        </nav>
                    </div>
                </div>

                <!-- Form Card -->
                <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-8">
                    <form:form action="/stock/enregistrer" method="POST" modelAttribute="stock" class="space-y-6">
                        
                        <!-- Variantes de Chaussures -->
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Variante de Chaussure (Modèle, Catégorie, Genre, Couleur, Pointure)</label>
                            <form:select path="chaussuresCouleurPointure.id" class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all">
                                <form:option value="" label="-- Sélectionner une variante --" />
                                <c:forEach items="${variantes}" var="v">
                                    <form:option value="${v.id}" label="${v.chaussureGenre.chaussure.nom} - ${v.chaussureGenre.categories.nom} - ${v.chaussureGenre.genre.nom} - ${v.couleur.nom} - T${v.pointure.nom}" />
                                </c:forEach>
                            </form:select>
                        </div>

                        <!-- Type de Mouvement -->
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Type de Mouvement</label>
                            <div class="grid grid-cols-2 gap-4">
                                <c:forEach items="${typesMvt}" var="t">
                                    <label class="flex items-center gap-3 p-3 rounded-md border border-gray-200 cursor-pointer hover:bg-gray-50 transition-colors">
                                        <form:radiobutton path="typeMvtStock.id" value="${t.id}" class="w-4 h-4 text-brand-600 focus:ring-brand-500" />
                                        <span class="text-sm font-medium text-gray-900">${t.nom}</span>
                                    </label>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Quantité -->
                        <div>
                            <label for="quantite" class="block text-sm font-semibold text-gray-700 mb-2">Quantité</label>
                            <div class="relative">
                                <form:input path="quantite" type="number" id="quantite" required="true" min="1"
                                    class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all"
                                    placeholder="Ex: 10" />
                            </div>
                        </div>

                        <!-- Date (Optionnelle, par défaut aujourd'hui) -->
                        <div>
                            <label for="dateMvt" class="block text-sm font-semibold text-gray-700 mb-2">Date du mouvement (laisser vide pour maintenant)</label>
                            <form:input path="dateMvt" type="datetime-local" id="dateMvt"
                                class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all" />
                        </div>

                        <!-- Action Buttons -->
                        <div class="flex items-center justify-end gap-3 pt-4">
                            <a href="/stock" class="px-6 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50 transition-colors shadow-sm">
                                Annuler
                            </a>
                            <button type="submit" class="px-6 py-2 text-sm font-medium text-white bg-brand-600 rounded-md hover:bg-brand-700 transition-colors shadow-sm ring-1 ring-brand-500">
                                Enregistrer le mouvement
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
