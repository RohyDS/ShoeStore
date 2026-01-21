<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <jsp:include page="../common/sidebar.jsp" />

    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <jsp:include page="../common/navbar.jsp" />

        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-2xl">
                <div class="mb-8 flex items-center gap-4">
                    <a href="/frais-livraison" class="text-gray-400 hover:text-gray-600 transition-colors">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18" />
                        </svg>
                    </a>
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900 mb-1">
                            ${item.lieu != null ? 'Modifier le Frais' : 'Nouveau Frais de Livraison'}
                        </h1>
                        <p class="text-sm text-gray-500">Définissez un nouveau tarif pour un secteur.</p>
                    </div>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                    <form action="/frais-livraison/enregistrer" method="post" class="p-6 space-y-6">
                        <div class="space-y-4">
                            <div>
                                <label for="idLieu" class="block text-sm font-semibold text-gray-700 mb-2">Secteur (Lieu)</label>
                                <select id="idLieu" name="idLieu" required class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all">
                                    <c:forEach items="${lieux}" var="l">
                                        <option value="${l.id}" ${item.lieu.id == l.id ? 'selected' : ''}>${l.nom}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div>
                                <label for="montant" class="block text-sm font-semibold text-gray-700 mb-2">Montant (Ar)</label>
                                <input type="number" step="0.01" id="montant" name="montant" value="${item.montant}" required
                                    class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-brand-500 focus:border-brand-500 outline-none transition-all"
                                    placeholder="Ex: 2000">
                            </div>
                        </div>

                        <div class="flex items-center justify-end gap-3 pt-4 border-t border-gray-100">
                            <a href="/frais-livraison" class="px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 rounded-md transition-colors">Annuler</a>
                            <button type="submit" class="bg-brand-600 text-white px-6 py-2 rounded-md hover:bg-brand-700 shadow-sm transition-colors text-sm font-semibold">
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
