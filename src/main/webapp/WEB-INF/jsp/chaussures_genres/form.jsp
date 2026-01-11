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
                    <h1 class="text-2xl font-bold text-gray-900 mb-2">${item.id == null ? 'Nouvelle' : 'Modifier'} Association Chaussure & Genre</h1>
                    <nav class="flex" aria-label="Breadcrumb">
                        <ol class="inline-flex items-center space-x-1 md:space-x-2">
                            <li class="inline-flex items-center">
                                <a href="/chaussures-genres" class="inline-flex items-center text-sm font-medium text-gray-500 hover:text-brand-600">
                                    Associations
                                </a>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                    <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">${item.id == null ? 'Nouveau' : 'Modification'}</span>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-8">
                    <form:form action="/chaussures-genres/enregistrer" method="POST" modelAttribute="item" class="space-y-6">
                        <form:hidden path="id" />
                        
                        <div>
                            <label for="chaussure.id" class="block text-sm font-semibold text-gray-700 mb-2">Modèle de Chaussure</label>
                            <form:select path="chaussure.id" required="true" class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all">
                                <form:option value="" label="-- Sélectionner un modèle --" />
                                <form:options items="${chaussures}" itemValue="id" itemLabel="nom" />
                            </form:select>
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label for="categories.id" class="block text-sm font-semibold text-gray-700 mb-2">Catégorie</label>
                                <form:select path="categories.id" required="true" class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all">
                                    <form:option value="" label="-- Sélectionner --" />
                                    <form:options items="${categories}" itemValue="id" itemLabel="nom" />
                                </form:select>
                            </div>
                            <div>
                                <label for="genre.id" class="block text-sm font-semibold text-gray-700 mb-2">Genre</label>
                                <form:select path="genre.id" required="true" class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all">
                                    <form:option value="" label="-- Sélectionner --" />
                                    <form:options items="${genres}" itemValue="id" itemLabel="nom" />
                                </form:select>
                            </div>
                        </div>

                        <div class="flex items-center justify-end gap-3 pt-4">
                            <a href="/chaussures-genres" class="px-6 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50 transition-colors shadow-sm">
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
