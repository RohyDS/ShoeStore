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
                    <h1 class="text-2xl font-bold text-gray-900 mb-2">${client.id == null ? 'Nouveau' : 'Modifier'} Client</h1>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-8">
                    <form:form action="/clients/enregistrer" method="POST" modelAttribute="client" class="space-y-6">
                        <form:hidden path="id" />
                        
                        <div>
                            <label for="nom" class="block text-sm font-semibold text-gray-700 mb-2">Nom du client</label>
                            <form:input path="nom" id="nom" required="true"
                                class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all"
                                placeholder="Entrez le nom complet" />
                        </div>

                        <div class="flex items-center justify-end gap-3 pt-4">
                            <a href="/clients" class="px-6 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50 transition-colors shadow-sm">
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
