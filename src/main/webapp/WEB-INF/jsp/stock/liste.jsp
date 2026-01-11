<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
            <div class="container mx-auto max-w-7xl">
                
                <!-- Page Header -->
                <div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                         <h1 class="text-2xl font-bold text-gray-900 mb-2">Gestion du Stock</h1>
                        <nav class="flex" aria-label="Breadcrumb">
                            <ol class="inline-flex items-center space-x-1 md:space-x-2">
                                <li class="inline-flex items-center">
                                    <span class="inline-flex items-center text-sm font-medium text-gray-500">
                                        <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                            <path d="M7 3a1 1 0 000 2h6a1 1 0 100-2H7zM4 7a1 1 0 011-1h10a1 1 0 110 2H5a1 1 0 01-1-1zM2 11a2 2 0 012-2h12a2 2 0 012 2v4a2 2 0 01-2 2H4a2 2 0 01-2-2v-4z" />
                                        </svg>
                                        Gestion Stock
                                    </span>
                                </li>
                                <li>
                                    <div class="flex items-center">
                                        <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                        <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">Mouvements de Stock</span>
                                    </div>
                                </li>
                            </ol>
                        </nav>
                    </div>
                    <div class="flex gap-2">
                        <a href="/stock/nouveau" class="bg-brand-600 text-white px-4 py-2 rounded-md hover:bg-brand-700 shadow-sm transition-colors text-sm font-medium flex items-center gap-2">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                            </svg>
                            Nouveau Mouvement
                        </a>
                    </div>
                </div>

                <!-- Table -->
                <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                     <div class="overflow-x-auto">
                        <table class="min-w-full text-left text-sm whitespace-nowrap">
                            <thead class="bg-gray-50 text-gray-900 font-semibold border-b border-gray-200">
                                <tr>
                                    <th class="px-6 py-3">Date</th>
                                    <th class="px-6 py-3">Chaussure</th>
                                    <th class="px-6 py-3">Détails (Cat/Genre/Coul/Pnt)</th>
                                    <th class="px-6 py-3">Quantité</th>
                                    <th class="px-6 py-3">Type</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:forEach items="${stocks}" var="s">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-3 text-gray-500">${s.dateMvt}</td>
                                        <td class="px-6 py-3 text-gray-900 font-medium">${s.chaussuresCouleurPointure.chaussureGenre.chaussure.nom}</td>
                                        <td class="px-6 py-3 text-gray-500">
                                            ${s.chaussuresCouleurPointure.chaussureGenre.categories.nom} / ${s.chaussuresCouleurPointure.chaussureGenre.genre.nom} / ${s.chaussuresCouleurPointure.couleur.nom} / T${s.chaussuresCouleurPointure.pointure.nom}
                                        </td>
                                        <td class="px-6 py-3 font-medium ${s.quantite > 0 ? 'text-green-600' : 'text-red-600'}">
                                            ${s.quantite > 0 ? '+' : ''}${s.quantite}
                                        </td>
                                        <td class="px-6 py-3">
                                            <span class="px-2 py-1 text-xs font-medium rounded-full ${s.quantite > 0 ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}">
                                                ${s.quantite > 0 ? 'Entrée' : 'Sortie'}
                                            </span>
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
