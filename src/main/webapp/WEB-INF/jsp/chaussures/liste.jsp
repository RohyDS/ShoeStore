<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <jsp:include page="../common/sidebar.jsp" />

    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <jsp:include page="../common/navbar.jsp" />

        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-7xl">
                <div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900 mb-2">Catalogue des Chaussures</h1>
                    </div>
                    <a href="/chaussures/nouveau" class="bg-brand-600 text-white px-4 py-2 rounded-md hover:bg-brand-700 shadow-sm transition-colors text-sm font-medium flex items-center gap-2">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                        </svg>
                        Ajouter un modèle
                    </a>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="min-w-full text-left text-sm whitespace-nowrap">
                            <thead class="bg-gray-50 text-gray-900 font-semibold border-b border-gray-200">
                                <tr>
                                    <th class="px-6 py-3">ID</th>
                                    <th class="px-6 py-3">Modèle</th>
                                    <th class="px-6 py-3">Marque</th>
                                    <th class="px-6 py-3">Coupe</th>
                                    <th class="px-6 py-3">Prix de base</th>
                                    <th class="px-6 py-3">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:forEach items="${chaussures}" var="c">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-3 text-gray-500">#${c.id}</td>
                                        <td class="px-6 py-3 text-gray-900 font-medium">${c.nom}</td>
                                        <td class="px-6 py-3 text-gray-500">${c.marque.nom}</td>
                                        <td class="px-6 py-3 text-gray-500">${c.coupe.nom}</td>
                                        <td class="px-6 py-3 font-medium text-gray-900"><fmt:formatNumber value="${c.prix}" pattern="#,##0.00" /> Ar</td>
                                        <td class="px-6 py-3">
                                            <div class="flex items-center gap-3">
                                                <a href="/chaussures/modifier/${c.id}" class="text-brand-600 hover:text-brand-700 font-medium">Modifier</a>
                                                <a href="/chaussures/supprimer/${c.id}" class="text-red-600 hover:text-red-700 font-medium" onclick="return confirm('Supprimer ?')">Supprimer</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
