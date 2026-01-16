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
                    <h1 class="text-2xl font-bold text-gray-900 mb-2">${item.id == null ? 'Nouvelle' : 'Modifier'} Couleur</h1>
                    <nav class="flex" aria-label="Breadcrumb">
                        <ol class="inline-flex items-center space-x-1 md:space-x-2">
                            <li class="inline-flex items-center">
                                <a href="/couleur" class="inline-flex items-center text-sm font-medium text-gray-500 hover:text-brand-600">
                                    Couleurs
                                </a>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                    <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">${item.id == null ? 'Nouvelle' : 'Modification'}</span>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-8">
                    <form:form action="/couleur/enregistrer" method="POST" modelAttribute="item" class="space-y-6">
                        <form:hidden path="id" />
                        
                        <div>
                            <label for="nom" class="block text-sm font-semibold text-gray-700 mb-2">Nom de la couleur</label>
                            <form:input path="nom" id="nom" required="true"
                                class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all"
                                placeholder="Ex: Noir, Blanc, etc." />
                        </div>

                        <div>
                            <label for="majorationPourcentage" class="block text-sm font-semibold text-gray-700 mb-2">
                                Majoration de prix (%)
                                <span class="text-xs font-normal text-gray-500 ml-1 italic">(S'applique sur le prix de base de l'article)</span>
                            </label>
                            <form:input path="majorationPourcentage" type="number" step="0.01" id="majorationPourcentage"
                                class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all"
                                placeholder="Ex: 10.0" />
                            <p class="mt-1 text-xs text-gray-500">Exemple: Si le prix est de 100 000 Ar et la majoration est de 10%, le prix final sera de 110 000 Ar.</p>
                        </div>

                        <div class="flex items-center justify-end gap-3 pt-4">
                            <a href="/couleur" class="px-6 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50 transition-colors shadow-sm">
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