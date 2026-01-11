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
                         <h1 class="text-2xl font-bold text-gray-900 mb-2">Historique des Prix & Commandes</h1>
                        <nav class="flex" aria-label="Breadcrumb">
                            <ol class="inline-flex items-center space-x-1 md:space-x-2">
                                <li class="inline-flex items-center">
                                    <span class="inline-flex items-center text-sm font-medium text-gray-500">
                                        <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                            <path d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.407 2.67 1a4 4 0 10-5.34 0c.59-.593 1.56-1 2.67-1m0 0V5m0 12v3" />
                                        </svg>
                                        Ventes
                                    </span>
                                </li>
                                <li>
                                    <div class="flex items-center">
                                        <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                        <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">Commandes</span>
                                    </div>
                                </li>
                            </ol>
                        </nav>
                    </div>
                </div>

                <!-- Table -->
                <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                     <div class="overflow-x-auto">
                        <table class="min-w-full text-left text-sm whitespace-nowrap">
                            <thead class="bg-gray-50 text-gray-900 font-semibold border-b border-gray-200">
                                <tr>
                                    <th class="px-6 py-3">ID</th>
                                    <th class="px-6 py-3">Client</th>
                                    <th class="px-6 py-3">Date Commande</th>
                                    <th class="px-6 py-3">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:forEach items="${commandes}" var="cmd">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-3 font-medium text-brand-600">#${cmd.id}</td>
                                        <td class="px-6 py-3 text-gray-900">${cmd.client.nom}</td>
                                        <td class="px-6 py-3 text-gray-500">${cmd.dateCommande}</td>
                                        <td class="px-6 py-3">
                                            <div class="flex items-center gap-3">
                                                <a href="/commandes/details/${cmd.id}" class="text-brand-600 hover:text-brand-700 font-medium">Voir détails</a>
                                                <a href="/commandes/supprimer/${cmd.id}" class="text-red-600 hover:text-red-700 font-medium" onclick="return confirm('Supprimer cette commande ?')">Supprimer</a>
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
