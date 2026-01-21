<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <jsp:include page="../common/sidebar.jsp" />

    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <jsp:include page="../common/navbar.jsp" />

        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-2xl">
                <div class="mb-8">
                    <a href="/lieu" class="text-brand-600 hover:text-brand-700 font-medium flex items-center gap-2 mb-4 text-sm">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18" />
                        </svg>
                        Retour à la liste
                    </a>
                    <h1 class="text-2xl font-bold text-gray-900">${item.id == null ? 'Ajouter un lieu' : 'Modifier le lieu'}</h1>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-8">
                    <form action="/lieu/enregistrer" method="post" class="space-y-6">
                        <input type="hidden" name="id" value="${item.id}" />
                        
                        <div>
                            <label for="nom" class="block text-sm font-semibold text-gray-700 mb-2">Nom du lieu</label>
                            <input type="text" id="nom" name="nom" value="${item.nom}" 
                                class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all"
                                placeholder="Ex: Analamahitsy" required />
                        </div>

                        <div class="pt-4">
                            <button type="submit" class="w-full bg-brand-600 text-white font-bold py-2 rounded-md hover:bg-brand-700 shadow-md transition-all">
                                Enregistrer
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
