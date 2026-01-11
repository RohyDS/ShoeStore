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
                    <h1 class="text-2xl font-bold text-gray-900 mb-2">${pointure.id == null ? 'Nouvelle' : 'Modifier'} Pointure</h1>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-8">
                    <form:form action="/pointure/enregistrer" method="POST" modelAttribute="pointure" class="space-y-6">
                        <form:hidden path="id" />
                        
                        <div>
                            <label for="nom" class="block text-sm font-semibold text-gray-700 mb-2">Nom (Label)</label>
                            <form:input path="nom" id="nom" required="true"
                                class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all"
                                placeholder="Ex: 42" />
                        </div>

                        <div class="grid grid-cols-3 gap-4">
                            <div>
                                <label for="eur" class="block text-sm font-semibold text-gray-700 mb-2">EUR</label>
                                <form:input path="eur" type="number" step="0.5" id="eur"
                                    class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all" />
                            </div>
                            <div>
                                <label for="us" class="block text-sm font-semibold text-gray-700 mb-2">US</label>
                                <form:input path="us" type="number" step="0.5" id="us"
                                    class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all" />
                            </div>
                            <div>
                                <label for="uk" class="block text-sm font-semibold text-gray-700 mb-2">UK</label>
                                <form:input path="uk" type="number" step="0.5" id="uk"
                                    class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all" />
                            </div>
                        </div>

                        <div class="flex items-center justify-end gap-3 pt-4">
                            <a href="/pointure" class="px-6 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50 transition-colors shadow-sm">
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
